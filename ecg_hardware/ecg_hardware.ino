#include <WiFi.h>
#include <FirebaseESP32.h>

// Replace with your network credentials
const char* WIFI_SSID = "Ojiya";
const char* WIFI_PASSWORD = "ojith@1234";

// Replace with your Firebase credentials
#define FIREBASE_HOST "https://arduino-ecg-f7bf6-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "AIzaSyCsMrtXRm0MWjuC4Xx8b4oxII53fucApQA "

// FirebaseESP32 data object
FirebaseData firebaseData;
FirebaseJsonArray sdata;

bool set=false;//for send the data to firebase

int count =1;//for differnet memo
#define led 19

void setup() {
  Serial.begin(115200);
  pinMode(23, INPUT); // Pin LO +
  pinMode(22, INPUT); // Pin LO -
  pinMode(led, OUTPUT); // led
  pinMode(21, INPUT);//reset and data sending button

  // Connect to Wi-Fi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("WiFi Connected");

  // Connect to Firebase
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
}

void loop() {
  
  if(digitalRead(21)==HIGH){
    set=true;
  }else{
    set=false;
  }

  
  if(set!=false){
    if ((digitalRead(23) == 1) || (digitalRead(22) == 1)) {
      Serial.println('!');
    }else {
      digitalWrite(led,HIGH);
      for(int i=0;i<250;i++){
        
        int ecgValue = analogRead(32);
      Serial.print("ecgValue ");
      Serial.println(ecgValue);
       sdata.set("/["+String(i)+"]",analogRead(32));//data sending
       delay(10);
      }
    Firebase.setArray(firebaseData,count,sdata);
        digitalWrite(led,LOW);
    }
    count++;
    Serial.print("count is ");
    Serial.println(count);
  }
  
  delay(1);
}
