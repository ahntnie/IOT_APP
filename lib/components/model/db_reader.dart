import 'package:flutter/services.dart';

class InfoReader{
  Future<String> getInfo() async{
    String s="";
    try{
      s = await rootBundle.loadString('assets/device.json');
      return(s);
    }catch(e){
      return e.toString();
    }
  }

}

