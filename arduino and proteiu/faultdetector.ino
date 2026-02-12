#include <LiquidCrystal.h>

LiquidCrystal lcd(7, 6, 5, 4, 3, 2);

int voltagePin = A0;
int currentPin = A1;
int buzzerPin  = 8;

float voltage;
int currentADC;

void setup() {
  lcd.begin(16, 2);
  pinMode(buzzerPin, OUTPUT);

  lcd.print("Power Line");
  lcd.setCursor(0,1);
  lcd.print("Monitoring...");
  delay(2000);
  lcd.clear();
}

void loop() {

  int voltageADC = analogRead(voltagePin);
  currentADC = analogRead(currentPin);

  voltage = (voltageADC * 5.0) / 1023.0;

  lcd.setCursor(0,0);
  lcd.print("V=");
  lcd.print(voltage,2);
  lcd.print("V     ");

  lcd.setCursor(0,1);

  if (currentADC > 800) {
    lcd.print("SHORT CIRCUIT ");
    digitalWrite(buzzerPin, HIGH);
  }
  else if (voltage < 2.0) {
    lcd.print("UNDER VOLT   ");
    digitalWrite(buzzerPin, HIGH);
  }
  else if (voltage > 4.0) {
    lcd.print("OVER VOLT    ");
    digitalWrite(buzzerPin, HIGH);
  }
  else {
    lcd.print("NORMAL       ");
    digitalWrite(buzzerPin, LOW);
  }

  delay(500);
}
