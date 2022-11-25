#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>

const char* ssid = "Virus";
const char* password = "mbega123455";
String serverName = "http://didier.requestcatcher.com?";
void setup() {
  Serial.begin(115200); 

  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
  }
}

void loop() {
      WiFiClient client;
      HTTPClient http;

      String req = Serial.readStringUntil('\n');
      String serverPath = serverName + "?money=100&card=F3%65%AB%AB";
      http.begin(client, serverPath.c_str());
      int httpResponseCode = http.GET();
      if (httpResponseCode>0) {
        Serial.print("HTTP Response code: ");
        Serial.println(httpResponseCode);
        String payload = http.getString();
        Serial.println(payload);
      }
      http.end();
    }
     
