#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>

const char* ssid = "fuel_filling";
const char* password = "mbega123455";
String serverName = "http://172.20.10.8/fuel_filling/data.php";
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
      //String serverPath = serverName + "?money=100&card=F3%65%AB%AB";
      String serverPath = serverName + req;
      // Your Domain name with URL path or IP address with path
      http.begin(client, serverPath.c_str());
      
      // Send HTTP GET request
      int httpResponseCode = http.GET();
      
      if (httpResponseCode>0) {
        Serial.print("HTTP Response code: ");
        Serial.println(httpResponseCode);
        String payload = http.getString();
        Serial.println(payload);
      }
      // Free resources
      http.end();
    }
     
