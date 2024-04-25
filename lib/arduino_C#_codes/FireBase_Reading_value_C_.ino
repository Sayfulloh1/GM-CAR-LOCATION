#include<WiFi.h>
#include<Firebase_ESP_Client.h>
#include<addons/TokenHelper.h>
#include<addons/RTDBHelper.h>

#define WIFI_SSID "Galaxy A15 CC20"
#define WIFI_PASSWORD "qalqon70"
#define API_KEY "AIzaSyCOFSVSq7bTsSHhTldoWpp4pMpJbv_vCUk"
#define DATABASE_URL "https://esp32-rtdb-b9561-default-rtdb.asia-southeast1.firebasedatabase.app/"




FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis=0;
bool signupOK=false;
float voltage=0.0;

bool ledStatus=false, switchStatus=false;


#include <TinyGPS++.h>
#include <HardwareSerial.h>

// Define the serial port connected to the GPS module
HardwareSerial GPS_Serial(1);

// Define the TinyGPS++ object
TinyGPSPlus gps;
  double latitude,longitude;  String Lt,Ln;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

  
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.println("Connecting to Wi-Fi");
  while(WiFi.status()!=WL_CONNECTED){
    Serial.print("."); delay(300);
    }
   Serial.println();
   Serial.print("Connected with IP: ");
   Serial.println(WiFi.localIP());
   Serial.println();

   config.api_key=API_KEY;
   config.database_url=DATABASE_URL;
   if(Firebase.signUp(&config, &auth,"","")){
    Serial.println("signUp OK");
    signupOK=true;
   }else {
      Serial.printf("%s\n", config.signer.signupError.message.c_str());
   }

   config.token_status_callback=tokenStatusCallback;
   Firebase.begin(&config, &auth);
   Firebase.reconnectWiFi(true);

   GPS_Serial.begin(9600, SERIAL_8N1, 16, 17); // baud rate, protocol, RX pin, TX pin

  Serial.println("GPS Module Test");
}

void loop() {
  // put your main code here, to run repeatedly:


Serial.println("Reading...");
  // Keep reading data from GPS module
  while (GPS_Serial.available() > 0) {
    if (gps.encode(GPS_Serial.read())) {
      // If GPS data is parsed successfully
      if (gps.location.isUpdated()) {
        // If new location data is available
        latitude = gps.location.lat();
        longitude = gps.location.lng();
        Lt=String(latitude, 6);
        Ln=String(longitude, 6);
        Serial.print("Latitude: ");
        Serial.println(latitude, 6); // Print latitude with 6 decimal places
        Serial.print("Longitude: ");
        Serial.println(longitude, 6); // Print longitude with 6 decimal places
      }
    }
  }

  while (GPS_Serial.available()) {
    char c = GPS_Serial.read();
    Serial.print(c);
  }
  
  delay(2000);
  
  if(Firebase.ready()&&signupOK&&(millis()-sendDataPrevMillis>3000||sendDataPrevMillis==0)){
    sendDataPrevMillis=millis();
    const char *a=Lt.c_str();
    const char *b=Ln.c_str();
    if(Firebase.RTDB.setString(&fbdo, "GPS/Latitude",a)){
      Serial.print(a);
      Serial.print("-succesfully saved to: "+fbdo.dataPath());
      Serial.println(" ("+fbdo.dataType()+")");
    }else{
      Serial.println("FAILED: "+fbdo.errorReason());
    }

    if(Firebase.RTDB.setString(&fbdo, "GPS/Longitude",b)){
      Serial.print(b);
      Serial.print("-succesfully saved to: "+fbdo.dataPath());
      Serial.println(" ("+fbdo.dataType()+")");
    }else{
      Serial.println("FAILED: "+fbdo.errorReason());
    }


    }
    
   
  }
