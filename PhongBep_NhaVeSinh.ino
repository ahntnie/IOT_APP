
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);

int coi = 7;
int cambienkhi = A0;
int cambienlua = 6;


void setup() {
  Serial.begin(9200);
  lcd.init();
  lcd.backlight();
  
  
  pinMode(cambienlua, INPUT);
  pinMode(cambienkhi, INPUT);
  pinMode(coi, OUTPUT);
}


void loop() {


  //chay();
  int value = analogRead(cambienkhi);
  lcd.setCursor(0, 0);
  lcd.print("Value :");
  lcd.print(value);
  lcd.print("  ");

  if ( value > 200 || digitalRead(cambienlua)==LOW) {
    digitalWrite(coi, HIGH);
    lcd.setCursor(0, 1);
    lcd.print("GAS Detected!");
  } else {
    digitalWrite(coi, LOW);
    lcd.setCursor(0, 1);
    lcd.print("             ");
  }
}
