
#include <LiquidCrystal_I2C.h>
#include <Servo.h>
#include <EEPROM.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);
Servo myServo;
int btnLCD1 = 2;
int btnLCD2 = 4;
int btnBat_Tat_LCD = 7;

int ledHanhLang = 5;
int dongcua = 13;
int trangthaiTruocDongCua = LOW;

char password[] = "1212";
char inputPassword[5];
int passwordIndex = 0;
unsigned long t = 0;
int trangThaiTruocBtnLCD = LOW;
bool on = false;
int lightPin = A1; // quang tro



void setup() {
  Serial.begin(9600);
  lcd.init();
  lcd.backlight();
 
  pinMode(ledHanhLang, OUTPUT);
  pinMode(btnBat_Tat_LCD, INPUT);
  pinMode(btnLCD1, INPUT);
  pinMode(btnLCD2, INPUT);
  pinMode(dongcua,INPUT);

  myServo.attach(A0);
  lcd.setCursor(0, 0);
  lcd.print("Enter password:");
  

}

void loop() {
  
  //LCD
  int trangThaiBtnLCD = digitalRead(btnBat_Tat_LCD);

  if (!on) {
    int btnLCD1State = digitalRead(btnLCD1);
    int btnLCD2State = digitalRead(btnLCD2);

    if (btnLCD1State == LOW) {
      inputPassword[passwordIndex] = '1';
      passwordIndex++;

      lcd.setCursor(passwordIndex - 1, 1);
      lcd.print("*");
      delay(200);
    }

    if (btnLCD2State == LOW) {
      inputPassword[passwordIndex] = '2';
      passwordIndex++;

      lcd.setCursor(passwordIndex - 1, 1);
      lcd.print("*");
      delay(200);
    }

    if (passwordIndex == 4) {
      lcd.clear();
      lcd.setCursor(0, 0);

      if (strncmp(inputPassword, password, 4) == 0) {

        lcd.print("Correct password");
        delay(2000);
        on = true; // Mở khóa
        myServo.write(0);
        delay(200);
     
        // delay(2000);
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("Vao nha!");
        
        lcd.noDisplay();
        lcd.noBacklight();
      } else {
        lcd.print("Wrong password");
        delay(2000);
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("Enter password:");
      }

      memset(inputPassword, 0, sizeof(inputPassword));
      passwordIndex = 0;
    }
  }

  if (trangThaiBtnLCD != trangThaiTruocBtnLCD && trangThaiBtnLCD == HIGH) {
    lcd.display();
    lcd.backlight();
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Enter password:");
    on = false; // Khóa lại
  }

  trangThaiTruocBtnLCD = trangThaiBtnLCD;



  int trangthaiDongCua = digitalRead(dongcua);
    if(trangthaiDongCua != trangthaiTruocDongCua && trangthaiDongCua == HIGH){
      Serial.print("nhan");
      myServo.write(90);

    }

  trangthaiTruocDongCua = trangthaiDongCua;


  //DenHanhLang
  int analogValue = analogRead(lightPin);
  if (analogValue < 500)
    digitalWrite(ledHanhLang, HIGH);
  else
    digitalWrite(ledHanhLang, LOW);

}
