#include <Arduino.h>

#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

int cambienkhi = A0;
int cambienlua = 6;
int coi = 7;

int len = 8;
int gtlen;  // Lên là trừ
int xuong = 9;
int gtxuong;  // Xuống là cộng
int menu = 10;
int gtmenu;
int macdinh = 1;
int trangthai=0;

int congtru_tong = 0;
int congtru_menu1 = 0;
int congtru_menu2 = 0;
int congtru_menu3 = 0;
int congtru_menu4 = 0;
int demmenu1 = 0;
int demmenu2 = 0;
int demmenu3 = 0;
int demmenu4 = 0;
int demtong = 0;

int bientro = A0;
int gtbientro;
int gtbiendoi;
int gtdosang = 0;

// void baochay()
// {
//   ////cam bien khi gas
//   int value = analogRead(cambienkhi);
//   lcd.setCursor(0, 0);
//   lcd.print("Value :");
//   lcd.print(value);
//   lcd.print("  ");

//   if (value > 400 || digitalRead(cambienlua)==HIGH) {
//     digitalWrite(coi, HIGH);
//     lcd.setCursor(0, 1);
//     lcd.print("GAS Detected!");
//   } else {
//     digitalWrite(coi, LOW);
//     lcd.setCursor(0, 1);
//     lcd.print("             ");
//   }
// }


void manhinh()  // HIỂN THỊ MÀN HÌNH CHÍNH
{
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(" MAN HINH CHINH ");
  // lcd.setCursor(0, 0);
  // baochay();
  // // //lcd.print("Màn hình 1");
  //  delay(1000);

  //  lcd.clear();
  //  lcd.setCursor(0, 0);
  // manhinh();
  // //lcd.print("Màn hình 2");
  // manhinh();
    //baochay();
    
    



}

void menu_tong()  // HIỂN THỊ MENU TỔNG
{
  if (congtru_tong == 0) {
    lcd.clear();
    lcd.print(">BACK");
    lcd.setCursor(0, 1);
    lcd.print(" PHONG KHACH");

    //  lcd.clear();
    //   lcd.setCursor(0, 0);
    //  lcd.print(" MAN HINH CHINH ");

  } else if (congtru_tong == 1) {
    lcd.clear();
    lcd.print(" BACK");
    lcd.setCursor(0, 1);
    lcd.print(">PHONG KHACH");

    // lcd.clear();
    // lcd.print(">BACK");
    // lcd.setCursor(0, 1);
    // lcd.print(" PHONG KHACH");
  } else if (congtru_tong == 2) {
    lcd.clear();
    lcd.print(">PHONG BEP");
    lcd.setCursor(0, 1);
    lcd.print(" PHONG NGU");

    // lcd.clear();
    // lcd.print(" BACK");
    // lcd.setCursor(0, 1);
    // lcd.print(">PHONG KHACH");

  } else if (congtru_tong == 3) {
    lcd.clear();
    lcd.print(" PHONG BEP");
    lcd.setCursor(0, 1);
    lcd.print(">PHONG NGU");

    // lcd.clear();
    // lcd.print(">PHONG BEP");
    // lcd.setCursor(0, 1);
    // lcd.print(" PHONG NGU");


  } else if (congtru_tong == 4) {
    lcd.clear();
    lcd.print(">PHONG WC");
    lcd.setCursor(0, 1);

    //  lcd.clear();
    // lcd.print(" PHONG BEP");
    // lcd.setCursor(0, 1);
    // lcd.print(">PHONG NGU");
  } 
}

void chonmenu_tong()  // CHỌN MENU TỔNG
{
  switch (congtru_tong) {
    case 0:
      //BACK
      break;
    case 1:
      //MENU 1
      break;
    case 2:
      //MENU 2
      break;
    case 3:
      // lcd.clear();
      // lcd.setCursor(5, 0);
      // lcd.print("MENU 3");
      // lcd.setCursor(0, 1);
      // lcd.print("NOI DUNG MENU 3.");
      break;
    case 4:
      //menu 4
      break;
    
  }
}

void menu_1()  // HIỂN THỊ MENU 1
{
  if (congtru_menu1 == 0) {
    lcd.clear();
    lcd.print(">BACK");
    lcd.setCursor(0, 1);
    lcd.print(" DenPhongKhach");
  } else if (congtru_menu1 == 1) {
    lcd.clear();
    lcd.print(" BACK");
    lcd.setCursor(0, 1);
    lcd.print(">DenPhongKhach");
  } 
}

void chonmenu_1()  // CHỌN MENU 1
{
  switch (congtru_menu1) {
    case 0:
      //BACK
      break;
    case 1:
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("LED 1:OFF");
      lcd.setCursor(0, 1);
      lcd.print("LED 2:OFF");
      break;
  }
}

void menu_2()  // HIỂN THỊ MENU 2
{
  if (congtru_menu2 == 0) {
    lcd.clear();
    lcd.print(">BACK");
    lcd.setCursor(0, 1);
    lcd.print(" DenPhongBep");
  } else if (congtru_menu2 == 1) {
    lcd.clear();
    lcd.print(" BACK");
    lcd.setCursor(0, 1);
    lcd.print(">DenPhongBep");
  } 
}

void chonmenu_2()  // CHỌN MENU 2
{
  switch (congtru_menu2) {
    case 0:
      //BACK
      break;
    
    case 1:
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("LED BEP:ON");
      break;
  }
}

void menu_3()  // HIỂN THỊ Phòng Ngủ
{
  if (congtru_menu3 == 0) {
    lcd.clear();
    lcd.print(">BACK");
    lcd.setCursor(0, 1);
    lcd.print(" DO SANG");
  } else if (congtru_menu3 == 1) {
    lcd.clear();
    lcd.print(" BACK");
    lcd.setCursor(0, 1);
    lcd.print(">DO SANG");
  } 
}

void chonmenu_3()  // CHỌN Phòng Ngủ
{
  switch (congtru_menu3) {
    case 0:
      //BACK
      break;
    
    case 1:
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("    DO SANG   ");
      lcd.setCursor(0, 1);
      lcd.print("GIA TRI: ");
      break;
  }
}


void menu_4()  // HIỂN THỊ Menu phòng WC
{
  if (congtru_menu4 == 0) {
    lcd.clear();
    lcd.print(">BACK");
    lcd.setCursor(0, 1);
    lcd.print(" DEN.PHONG.WC");
  } else if (congtru_menu4 == 1) {
    lcd.clear();
    lcd.print(" BACK");
    lcd.setCursor(0, 1);
    lcd.print(">DEN.PHONG.WC");
  } 
}

void chonmenu_4()  // CHỌN phòng WC
{
  switch (congtru_menu4) {
    case 0:
      //BACK
      break;
    
    case 1:
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("LED WC:OFF");
      break;
  }
}


void setup() {
  Serial.begin(9600);

  lcd.init();
  lcd.backlight();

  pinMode(len, INPUT);
  pinMode(xuong, INPUT);
  pinMode(menu, INPUT);

  pinMode(cambienlua, INPUT);
  pinMode(cambienkhi, INPUT);
  pinMode(coi, OUTPUT);
 
  manhinh();
 
}

void loop() {

  
  gtlen = digitalRead(len);
  gtxuong = digitalRead(xuong);
  gtmenu = digitalRead(menu);
  trangthai =  digitalRead(menu);

  if (gtlen != macdinh)  // NÚT LÊN
  {
    if (gtlen == 0)  // Khi nhấn nút lên
    {
      if (demtong == 1)  // LÊN Ở MENU TỔNG
      {
        if (congtru_tong >= 4) {
          congtru_tong = 0;
        } else {
          congtru_tong++;
        }
        menu_tong();
      }

      else if (demtong == 2 && congtru_tong == 1)  // LÊN Ở MENU 1
      {
        if (congtru_menu1 >= 1) {
          congtru_menu1 = 0;
        } else {
          congtru_menu1++;
        }
        menu_1();
      }

      else if (demtong == 2 && congtru_tong == 2)  // LÊN Ở MENU 2
      {
        if (congtru_menu2 >= 1) {
          congtru_menu2 = 0;
        } else {
          congtru_menu2++;
        }
        menu_2();
      }

      else if (demtong == 2 && congtru_tong == 3)  // LÊN Ở MENU 3
      {
        if (congtru_menu3 >= 1) {
          congtru_menu3 = 0;
        } else {
          congtru_menu3++;
        }
        menu_3();
      }

       else if (demtong == 2 && congtru_tong == 4)  // LÊN Ở MENU 4
      {
        if (congtru_menu4 >= 1) {
          congtru_menu4 = 0;
        } else {
          congtru_menu4++;
        }
        menu_4();
      }

      else if (demtong == 3 && demmenu3 == 1)  // - ĐỘ SÁNG
      {
        if (gtdosang <= 0) {
          gtdosang = 0;
        } else {
          gtdosang--;
        }
      }

      delay(200);
    }
    macdinh = gtlen;
  }

  if (gtxuong != macdinh)  // NÚT XUỐNG
  {
    if (gtxuong == 0)  //Khi nhấn nút xuống
    {
      if (demtong == 1)  // XUỐNG Ở MENU TỔNG
      {
        if (congtru_tong <= 0) {
          congtru_tong = 4;
        } else {
          congtru_tong--;
        }
        menu_tong();
      }

      else if (demtong == 2 && congtru_tong == 1)  // XUỐNG Ở MENU 1
      {
        if (congtru_menu1 <= 0) {
          congtru_menu1 = 1;
        } else {
          congtru_menu1--;
        }
        menu_1();
      }

      else if (demtong == 2 && congtru_tong == 2)  // XUỐNG Ở MENU 2
      {
        if (congtru_menu2 <= 0) {
          congtru_menu2 = 1;
        } else {
          congtru_menu2--;
        }
        menu_2();
      }

      else if (demtong == 2 && congtru_tong == 3)  // XUỐNG Ở MENU 3
      {
        if (congtru_menu3 <= 0) {
          congtru_menu3 = 1;
        } else {
          congtru_menu3--;
        }
        menu_3();
      }

      else if (demtong == 2 && congtru_tong == 4)  // XUỐNG Ở MENU 4
      {
        if (congtru_menu4 <= 0) {
          congtru_menu4 = 1;
        } else {
          congtru_menu4--;
        }
        menu_4();
      }

      else if (demtong == 3 && demmenu3 == 1)  // + ĐỘ SÁNG
      {
        if (gtdosang >= 100) {
          gtdosang = 100;
        } else {
          gtdosang++;
        }
      }

      delay(200);
    }
    macdinh = gtxuong;
  }

       
  
  // lcd.clear();
  //  lcd.setCursor(0, 0);
  //  manhinh();
  // // // //lcd.print("Màn hình 1");
  //  delay(1000);

  
   //baochay();
  //delay(1000);

  if (gtmenu != macdinh)  // NÚT MENU
  {  
    if (gtmenu == 0)  //Khi nhấn nút
    {
      demtong++;     
      if (demtong == 1)  //Ở menu tổng
      {
        menu_tong();
        
      } else if (demtong == 2 && congtru_tong == 0)  //Nhấn BACK từ Menu tổng về màn hình
      {
        demtong = 0;
        //baochay();
        manhinh();
      }

      else if (demtong == 2 && congtru_tong == 1)  // Ở menu 1
      {
        menu_1();
        demmenu1++;
      } else if (demtong == 3 && demmenu1 == 1 && congtru_menu1 > 0)  //Chọn menu 1
      {
        chonmenu_1();
      } else if (demtong == 4 && demmenu1 == 1 && congtru_menu1 > 0)  //Từ chọn_menu1 về menu 1
      {
        demtong = 2;
        congtru_menu1 = 0;
        menu_1();
      } else if (demtong == 3 && demmenu1 == 1 && congtru_menu1 == 0 && congtru_tong == 1)  //Nhấn BACK ở menu 1
      {
        congtru_tong = 0;
        demtong = 1;
        demmenu1 = 0;
        menu_tong();
      }


      else if (demtong == 2 && congtru_tong == 2)  //Ở menu 2
      {
        menu_2();
        demmenu2++;
      } else if (demtong == 3 && demmenu2 == 1 && congtru_menu2 > 0)  // Chọn menu_2
      {
        chonmenu_2();
      } else if (demtong == 4 && demmenu2 == 1 && congtru_menu2 > 0)  //Từ chọn_menu2 về menu 2
      {
        demtong = 2;
        congtru_menu2 = 0;
        menu_2();
      } else if (demtong == 3 && demmenu2 == 1 && congtru_menu2 == 0 && congtru_tong == 2)  //Nhấn BACK ở menu 2
      {
        congtru_tong = 0;
        demtong = 1;
        demmenu2 = 0;
        menu_tong();
      }

      else if (demtong == 2 && congtru_tong == 3)  //Ở menu 3
      {
        menu_3();
        demmenu3++;
      } else if (demtong == 3 && demmenu3 == 1 && congtru_menu3 > 0)  // Chọn menu_3
      {
        chonmenu_3();
      } else if (demtong == 4 && demmenu3 == 1 && congtru_menu3 > 0)  //Từ chọn_menu3 về menu 3
      {
        demtong = 2;
        congtru_menu3 = 0;
        menu_3();
      } else if (demtong == 3 && demmenu3 == 1 && congtru_menu3 == 0 && congtru_tong == 3)  //Nhấn BACK ở menu 3
      {
        congtru_tong = 0;
        demtong = 1;
        demmenu3 = 0;
        menu_tong();
      }

      else if (demtong == 2 && congtru_tong == 4)  //Ở menu 4
      {
        menu_4();
        demmenu4++;
      } else if (demtong == 3 && demmenu4 == 1 && congtru_menu4 > 0)  // Chọn menu_4
      {
        chonmenu_4();
      } else if (demtong == 4 && demmenu4 == 1 && congtru_menu4 > 0)  //Từ chọn_menu3 về menu 4
      {
        demtong = 2;
        congtru_menu4 = 0;
        menu_4();
      } else if (demtong == 3 && demmenu4 == 1 && congtru_menu4 == 0 && congtru_tong == 4)  //Nhấn BACK ở menu 4
      {
        congtru_tong = 0;
        demtong = 1;
        demmenu4 = 0;
        menu_tong();
      }

      else if (demtong == 2 &&  congtru_tong == 5 ) // chọn menu tổng 5
      {
        chonmenu_tong();
      } else if (demtong == 3 &&  congtru_tong == 5 ) //Thoát từ 5 về menu tổng
      {
        demtong = 1;
        menu_tong();
      }

      delay(100);
    }
    macdinh = gtmenu;
  }


  if (demtong == 3 && demmenu3 == 1)  //CHỌN MENU 3: độ sáng
  {
    if (congtru_menu3 == 1)  // Độ sáng
    {
      if (gtdosang < 10) {
        lcd.setCursor(9, 1);
        lcd.print(gtdosang);
        lcd.setCursor(10, 1);
        lcd.print("      ");
      } else if (gtdosang < 100) {
        lcd.setCursor(9, 1);
        lcd.print(gtdosang);
        lcd.setCursor(11, 1);
        lcd.print("     ");
      } else {
        lcd.setCursor(9, 1);
        lcd.print(gtdosang);
        lcd.setCursor(12, 1);
        lcd.print("    ");
      }
    }
  }
 
  

  Serial.print("Đếm tổng: ");
  Serial.print(demtong);
  Serial.print("    ");
  Serial.print("+/- tổng: ");
  Serial.print(congtru_tong);
  Serial.print("    ");
  Serial.print("Đếm menu 1 : ");
  Serial.print(demmenu1);
  Serial.print("    ");
  Serial.print("Đếm menu 2 : ");
  Serial.print(demmenu2);
  Serial.print("    ");
  Serial.print("+/- menu 1: ");
  Serial.print(congtru_menu1);
  Serial.print("    ");
  Serial.print("+/- menu 2: ");
  Serial.println(congtru_menu2);

 


}  //Kết loop
