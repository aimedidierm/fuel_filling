#include <ArduinoJson.h>
#include <SPI.h>
#include <MFRC522.h>
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>
#include <Keypad.h>

#define SS_PIN 10
#define RST_PIN 9
MFRC522 mfrc522(SS_PIN, RST_PIN);   // Create MFRC522 instance.

void(* resetFunc) (void) = 0;

int Interrupt = 0;
int sensorPin = 2;
#define Valve A1
#define red 8
#define buzzer A0
float calibrationFactor = 90; 
volatile byte pulseCount = 0;  
float flowRate = 0.0;
unsigned int flowMilliLitres = 0;
unsigned long totalMilliLitres = 270;
unsigned long oldTime = 0;

LiquidCrystal_I2C lcd(0x27, 20, 4);  // set the LCD address to 0x27 for a 16 chars and 2 line display

const byte ROWS = 4; // four rows
const byte COLS = 3; // three columns
// define the symbols on the buttons of the keypads
char newNum[12] = "", momomoney[12] = "", directmoney[12] = "", bonusamount[12] = "", dismoney[12] = "";

char keys[ROWS][COLS] = {
    {'1', '2', '3'},
    {'4', '5', '6'},
    {'7', '8', '9'},
    {'*', '0', '#'}
};

byte rowPins[ROWS] = {7, 6, 5, 4}; // connect to the row pinouts of the keypad
byte colPins[COLS] = {3, A3, A2}; // connect to the column pinouts of the keypad

Keypad keypad = Keypad(makeKeymap(keys), rowPins, colPins, ROWS, COLS);

int drink = 0, drinkvolume = 0, phone = 0, amount = 0, kwiyaboneshaamount = 0, kwishyuraamount = 0;
String card;
String data = "";

void setup() 
{
    lcd.init();                      // initialize the lcd 
    lcd.init();
    SPI.begin();  
    Serial.begin(9600);   // Initiate a serial communication
    SPI.begin();      // Initiate  SPI bus
    mfrc522.PCD_Init();   // Initiate MFRC522
    pinMode(Valve, OUTPUT);
    digitalWrite(Valve, HIGH);
    pinMode(sensorPin, INPUT);
    digitalWrite(sensorPin, HIGH);
    attachInterrupt(Interrupt, pulseCounter, FALLING);
    lcd.backlight();
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Car auto fuel");
    lcd.setCursor(0, 1);
    lcd.print("filling system");
    delay(5000);
}

void loop() 
{
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Choose payment");
    lcd.setCursor(0, 1);
    lcd.print("Method & press #");
    delay(3000);
    paymentmethod();
}

void paymentmethod() {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("1. Mobile money");
    lcd.setCursor(0, 1);
    lcd.print("2. Smart card");
    int key = keypad.getKey();
    if (key == '1') {
        momo();
    }
    if (key == '2') {
        readcard();
    }
    delay(100);
    paymentmethod();
}

void momo() {
    int i = 0, j = 0, k = 0;
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Please enter");
    lcd.setCursor(0, 1);
    lcd.print("mobile number");
    delay(2000);
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Mobile number");
    
    while (true) {
        lcd.setCursor(0, 1);
        int key = keypad.getKey();
        if (key != NO_KEY && key != '#' && key != '*') {
            newNum[j] = key;
            newNum[j + 1] = '\0';   
            j++;
            lcd.setCursor(0, 1);
            lcd.print(newNum);
        }
        if (key == '#' && j > 0) {
            j = 0;
            lcd.clear();
            lcd.setCursor(0, 0);
            lcd.print("Enter money:");
            lcd.setCursor(0, 1);
            
            while (true) {
                int key = keypad.getKey();
                if (key != NO_KEY && key != '#' && key != '*') {
                    momomoney[j] = key;
                    momomoney[j + 1] = '\0';   
                    j++;
                    lcd.setCursor(0, 1);
                    lcd.print(momomoney);
                }
                if (key == '#' && j > 0) {
                    j = 0;
                    lcd.clear();
                    lcd.print("Loading");
                    Serial.println((String)"phone=" + newNum + "&amount=" + momomoney);
                    while (k == 0) {
                        if (Serial.available() > 0) {
                            data = Serial.readStringUntil('\n');
                            Serial.println(data);
                            
                            DynamicJsonDocument doc(1024);
                            DeserializationError error = deserializeJson(doc, data);
                            if (error) {
                                Serial.print(F("deserializeJson() failed: "));
                                Serial.println(error.f_str());
                                return;
                            }
                            
                            if (doc.containsKey("c")) {
                                int outml = doc["c"];
                                if (outml == 1) {
                                    lowbalance();
                                } else {
                                    drinkvolume = outml;
                                    drinkout();
                                }
                            }
                        }
                    }
                } else if (key == '*') {
                    resetFunc();
                }
                delay(100);
            }
        }
    }
}

void drinkout() {
    digitalWrite(Valve, LOW);
    while (drinkvolume > 20) {
        if ((millis() - oldTime) > 1000) { 
            detachInterrupt(Interrupt);
            flowRate = ((1000.0 / (millis() - oldTime)) * pulseCount) / calibrationFactor;
            oldTime = millis();
            flowMilliLitres = (flowRate / 60) * 1000;
            drinkvolume -= flowMilliLitres;
            lcd.clear();
            lcd.setCursor(0, 0);
            lcd.print(directmoney);
            lcd.print(momomoney);
            lcd.print("Rwf");
            lcd.setCursor(0, 1);
            lcd.print(drinkvolume);
            pulseCount = 0;
            attachInterrupt(Interrupt, pulseCounter, FALLING);
        }
    }
    digitalWrite(Valve, HIGH);
    resetFunc();
    delay(3000);
    resetFunc();
}

void readcard() {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Tap your card");
    delay(500);
    
    if (!mfrc522.PICC_IsNewCardPresent()) {
        readcard();
    }
    
    if (!mfrc522.PICC_ReadCardSerial()) {
        readcard();
    }
    
    String content = "";
    for (byte i = 0; i < mfrc522.uid.size; i++) {
        content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
        content.concat(String(mfrc522.uid.uidByte[i], HEX));
    }
    content.toUpperCase();
    card = content.substring(1);
    
    while (true) {
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("1. Pay now");
        lcd.setCursor(0, 1);
        lcd.print("2. By bonus");
        int key = keypad.getKey();
        if (key == '1') {
            paydirect();
        }
        if (key == '2') {
            bonus();
        }
        delay(100);
    }
}

void paydirect() {
    int j = 0, k = 0;
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Enter money:");
    
    while (true) {
        int key = keypad.getKey();
        if (key != NO_KEY && key != '#' && key != '*') {
            directmoney[j] = key;
            directmoney[j + 1] = '\0';   
            j++;
            lcd.setCursor(0, 1);
            lcd.print(directmoney);
        }
        if (key == '#' && j > 0) {
            j = 0;
            lcd.clear();
            lcd.print("Loading");
            delay(2000);
            Serial.println((String)"card=" + card + "&dmoney=" + directmoney);
            
            while (k == 0) {
                if (Serial.available() > 0) {
                    data = Serial.readStringUntil('\n');
                    Serial.println(data);
                    
                    DynamicJsonDocument doc(1024);
                    DeserializationError error = deserializeJson(doc, data);
                    if (error) {
                        Serial.print(F("deserializeJson() failed: "));
                        Serial.println(error.f_str());
                        return;
                    }
                    
                    if (doc.containsKey("cstatus")) {
                        int outml = doc["cstatus"];
                        if (outml == 1) {
                            lowbalance();
                        } else {
                            drinkvolume = outml;
                            drinkout();
                        }
                    }
                }
            }
        } else if (key == '*') {
            resetFunc();
        }
        delay(100);
    }
}

void bonus() {
    int j = 0, k = 0;
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Enter amount:");
    
    while (true) {
        int key = keypad.getKey();
        if (key != NO_KEY && key != '#' && key != '*') {
            bonusamount[j] = key;
            bonusamount[j + 1] = '\0';   
            j++;
            lcd.setCursor(0, 1);
            lcd.print(bonusamount);
        }
        if (key == '#' && j > 0) {
            j = 0;
            lcd.clear();
            lcd.print("Loading");
            Serial.println((String)"card='" + card + "'&money=" + bonusamount);
            
            while (k == 0) {
                if (Serial.available() > 0) {
                    data = Serial.readStringUntil('\n');
                    Serial.println(data);
                    
                    DynamicJsonDocument doc(1024);
                    DeserializationError error = deserializeJson(doc, data);
                    if (error) {
                        Serial.print(F("deserializeJson() failed: "));
                        Serial.println(error.f_str());
                        return;
                    }
                    
                    if (doc.containsKey("cstatus")) {
                        int outml = doc["cstatus"];
                        if (outml == 1) {
                            lowbalance();
                        } else if (outml == 2) {
                            usern();
                        } else if (outml == 3) {
                            call();
                        } else {
                            drinkvolume = outml;
                            drinkout();
                        }
                    }
                }
            }
        } else if (key == '*') {
            resetFunc();
        }
        delay(100);
    }
}

void lowbalance() {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Insufficient");
    lcd.setCursor(0, 1);
    lcd.print("funds");
    digitalWrite(red, HIGH);
    tone(buzzer, 1000, 1000);
    delay(3000);
    digitalWrite(red, LOW);
    lcd.clear();
    resetFunc();
}

void usern() {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("User not");
    lcd.setCursor(0, 1);
    lcd.print("found");
    digitalWrite(red, HIGH);
    tone(buzzer, 1000, 1000);
    delay(3000);
    digitalWrite(red, LOW);
    lcd.clear();
    resetFunc();
}

void call() {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Not yet allowed");
    digitalWrite(red, HIGH);
    tone(buzzer, 1000, 1000);
    delay(3000);
    digitalWrite(red, LOW);
    lcd.clear();
    resetFunc();
}

void pulseCounter() {
    pulseCount++;
}