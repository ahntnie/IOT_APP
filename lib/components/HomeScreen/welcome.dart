import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key,required this.name});
  final String name;
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String dateTime = DateFormat("dd/MM/yyyy HH:mm ").format(DateTime.now());
  late String greeting; 
  late int hour;
  
  @override
  void initState(){
    super.initState();
    setState(() {
      hour = DateTime.now().hour;
      if(hour>=4 && hour<11){
        greeting = "Good morning";
      }
      else if(hour>=11 && hour<18){
        greeting = "Good afternoon";
      }
      else{
        greeting = "Good evening";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(    
      margin: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("assets/user.jpg",fit: BoxFit.cover,),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Text(dateTime,style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),),
                  const SizedBox(height: 5,),
                  Text("$greeting,\n${widget.name}",style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,     
                    fontSize: 17       
                  ),),       
                ],
              )
            ],
          ),
          const SizedBox(height: 5,),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("25°C",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),),
                    Text("TEMPERATURE",style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),)
                  ]
                )
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("40%",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),),
                    Text("HUMIDITY",style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),)
                  ]
                )
              )
            ],
          )
        ],
      ),
    );
  }
}