#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <ArduinoJson.h>

const char* ssid = "Xi-TeKLTD-2G";
const char* password = "xitek@1998";

String serverName = "http:192.168.43.83/rfid_card_based_fuel_station/data.php";
// String serverName = "https://didier.requestcatcher.com/";

unsigned long lastTime = 0;
unsigned long timerDelay = 5000;

void setup() {
  Serial.begin(9600); 

  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
 
  Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");
}

void loop() {
  // Send an HTTP POST request depending on timerDelay
  if (Serial.available() > 0) {
    // Check WiFi connection status
    if (WiFi.status() == WL_CONNECTED) {
      WiFiClient client;
      HTTPClient http;
      String data = Serial.readStringUntil('\n');
      
      // Allocate the document on the stack.
      // Use a capacity large enough to store the JSON object.
      StaticJsonDocument<2048> doc;
      
      DeserializationError error = deserializeJson(doc, data);
      
      if (error) {
        Serial.print(F("deserializeJson() failed: "));
        Serial.println(error.f_str());
        return;
      }
      
      String serverPath = serverName;
      
      if (doc.containsKey("phone")) {
        String phone = doc["phone"].as<String>();
        int amount = doc["amount"].as<int>();
        serverPath = serverName + "?phone=" + phone + "&amount=" + amount;
      } else if (doc.containsKey("dmoney")) {
        String card = doc["card"].as<String>();
        int dmoney = doc["dmoney"].as<int>();
        serverPath = serverName + "?card=" + card + "&dmoney=" + dmoney;
      } else if (doc.containsKey("money")) {
        String card = doc["card"].as<String>();
        int money = doc["money"].as<int>();
        serverPath = serverName + "?card=" + card + "&money=" + money;
      }
      
      // Serial.println(serverPath);
      Serial.println(serverName + "?card=" + "card" + "&money=" + "money");
      
      http.begin(client, serverPath);
  
      // If you need Node-RED/server authentication, insert user and password below
      // http.setAuthorization("REPLACE_WITH_SERVER_USERNAME", "REPLACE_WITH_SERVER_PASSWORD");
        
      // Send HTTP GET request
      int httpResponseCode = http.GET();
      
      if (httpResponseCode > 0) {
        Serial.print("HTTP Response code: ");
        Serial.println(httpResponseCode);
        String payload = http.getString();
        // Serial.println(payload);
        Serial.println("{'cstatus':1}");
      } else {
        Serial.print("Error code: ");
        // Serial.println(httpResponseCode);
        Serial.println("{'cstatus':1}");
      }
      
      // Free resources
      http.end();
    } else {
      Serial.println("WiFi Disconnected");
    }
    lastTime = millis();
  }
}