#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#define HOST "didier.requestcatcher.com/" // Enter HOST URL without "http:// "  and "/" at the end of URL
#define WIFI_SSID "Virus" // WIFI SSID here                                   
#define WIFI_PASSWORD "mbega123455"
int  mq_value;
String sendval, sendval2, sendval3, postData;
void setup() { 
Serial.begin(9600);
WiFi.mode(WIFI_STA);           
WiFi.begin(WIFI_SSID, WIFI_PASSWORD);//try to connect with wifi
Serial.print("Connecting to ");
Serial.print(WIFI_SSID);
    while (WiFi.status() != WL_CONNECTED) 
    { Serial.print(".");
        delay(500); 
    }
Serial.println();
Serial.print("Connected to ");
Serial.println(WIFI_SSID);
Serial.print("IP Address is : ");
Serial.println(WiFi.localIP());    //print local IP address

delay(30);
}

void loop() {
WiFiClient client;
HTTPClient http;  
 
sendval =  String(123);
sendval2 =  String(456);
postData = "sendval=" + sendval + "&sendval2=" + sendval2;

    Serial.println("...........................................................");
    Serial.println("Sensor 0 : ");Serial.println(sendval);          /* state value for sensor 0 */
    Serial.println("...........................................................");
    Serial.println("Sensor 1 : ");Serial.println(sendval2);          /* state value for sensor 1 */
    Serial.println("...........................................................");
  
    delay(1000);    
http.begin(client,"http://didier.requestcatcher.com/");
http.addHeader("Content-Type", "application/x-www-form-urlencoded");            //Specify content-type header

  
 
int httpCode = http.POST(postData);   // Send POST request to php file and store server response code in variable named httpCode
Serial.println("Values are, sendval = " + sendval + " and sendval2 = "+sendval2);
delay(100);

// if connection eatablished then do this
if (httpCode == 200) { Serial.println("Values uploaded successfully."); Serial.println(httpCode); 
String webpage = http.getString();    // Get html webpage output and store it in a string
Serial.println(webpage + "\n"); 
}

// if failed to connect then return and restart

else { 
  Serial.println(httpCode); 
  Serial.println("Failed to upload values. \n"); 
  http.end(); 
  return; }
}
