void setup() {
  Serial.begin(9600);  // Start communication with the ESP-01 and Serial Monitor
}

void loop() {
  String card = "13 13 BD AB";
  String money = "100";

  String request = "money," + card + "," + money + "\n";
  
  Serial.print(request);  // Send the request to the ESP-01 via hardware serial
  
  delay(5000);  // Wait for the ESP-01 to process the request
  
  if (Serial.available()) {
    String response = Serial.readString();
    Serial.println("Response from ESP-01: " + response);  // Print the response from the ESP-01
  }
  
  delay(10000);  // Wait before sending the next request
}
