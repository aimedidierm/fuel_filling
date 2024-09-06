#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

const char* ssid = "Balance";
const char* password = "balance1234";
const char* serverName = "http://192.168.43.83/rfid_card_based_fuel_station/data.php";

WiFiClient client;

void setup() {
  Serial.begin(9600);
  
  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  Serial.print("Connecting to Wi-Fi");
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  
  Serial.println("\nConnected to Wi-Fi");
}

void loop() {
  // Prepare the GET request URL with query parameters
  // float money = 23.5;
  // int card = 1;
  // String url = String(serverName) + "?money=" + String(money) + "&card=" + String(card);
  // sendHTTPRequest(url);
  if (Serial.available()) {
    String requestType = Serial.readStringUntil(',');
    String userStuff = Serial.readStringUntil(','); //this is phone number or card ID
    String amount = Serial.readStringUntil('\n');
    String url;
    if (requestType == "card") {
      //request EX
      //card,abc,200
      url = String(serverName) + "?money=" + String(amount) + "&card=" + String(userStuff);
    } else if(requestType == "dcard"){
      //request EX
      //dcard,abc,200
      url = String(serverName) + "?dmoney=" + String(amount) + "&card=" + String(userStuff);
    } else if (requestType == "phone") {
      //request EX
      //phone,0788750979,200
      url = String(serverName) + "?money=" + String(amount) + "&phone=" + String(userStuff);
    } else {
      Serial.println("Invalid request type");
      return;
    }
    sendHTTPRequest(url);
  }
  delay(1000);
}

void sendHTTPRequest(String url) {
  if(WiFi.status() == WL_CONNECTED){
    
    HTTPClient http;
    
    // Use the WiFiClient with the full URL containing the GET parameters
    http.begin(client, url);  // Specify the full URL for the GET request
    
    // Send the GET request
    int httpResponseCode = http.GET();
    
    // Print the response and status code
    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println(response);
    } else {
      Serial.println("Error in GET request. HTTP Response code: " + String(httpResponseCode));
    }
    
    http.end();
  }
}