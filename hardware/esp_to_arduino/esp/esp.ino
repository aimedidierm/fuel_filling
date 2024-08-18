#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

const char* ssid = "Xi-TeKLTD-2G";
const char* password = "xitek@1998";

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
    String card = Serial.readStringUntil(',');
    String amount = Serial.readStringUntil('\n');

    String url;
    if (requestType == "money") {
      // url = "http://yourwebsite.com/path/to/your/script.php?card=" + card + "&money=" + amount;
      url = "http://192.168.1.82/rfid_card_based_fuel_station/data.php?card=" + card + "&money=" + amount;
    } else if (requestType == "dmoney") {
      // url = "http://yourwebsite.com/path/to/your/script.php?card=" + card + "&dmoney=" + amount;
      url = "http://192.168.1.82/rfid_card_based_fuel_station/data.php?card=" + card + "&dmoney=" + amount;
    } else {
      Serial.println("Invalid request type");
      return;
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
