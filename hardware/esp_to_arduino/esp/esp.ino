#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

const char* ssid = "EGATEEMIFI_CCDC";
const char* password = "30361568";

WiFiClient wifiClient;

void setup() {
  Serial.begin(9600);  // Communication with Arduino
  WiFi.begin(ssid, password);
  
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to Wi-Fi...");
  }
  Serial.println("Connected to Wi-Fi");
}

void loop() {
  if (Serial.available()) {
    String requestType = Serial.readStringUntil(',');
    // String card = Serial.readStringUntil(',');
    String card = "card1";
    String amount = Serial.readStringUntil('\n');

    String url;
    if(card == "card1") {
      if (requestType == "money") {
        url = "http://192.168.1.82/rfid_card_based_fuel_station/card1.php?money=" + amount;
      } else if (requestType == "dmoney") {
        url = "http://192.168.1.82/rfid_card_based_fuel_station/card1.php?dmoney=" + amount;
      } else {
        Serial.println("Invalid request type");
        return;
      }
    } else {
      
    }
    sendHTTPRequest(url);
  }
}

void sendHTTPRequest(String url) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(wifiClient, url);  // Use the updated API call with WiFiClient

    int httpCode = http.GET();

    if (httpCode > 0) {
      String payload = http.getString();
      Serial.println(payload); // Send the response back to the Arduino
    } else {
      Serial.println("Error on HTTP request");
    }

    http.end();
  }
}
