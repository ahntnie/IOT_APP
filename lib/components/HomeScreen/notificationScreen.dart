import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  String formatDatetime = DateFormat("dd/MM/yyyy HH:mm ").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon:const Icon(Icons.arrow_back),color: Colors.grey[400],),
        title: Text("NOTIFICATIONS",style: TextStyle(color: Colors.grey[400],fontSize: 25,fontWeight: FontWeight.w500)),
        centerTitle: true,
      ),
      body:  Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 1,child: CircleAvatar(child: Image.asset("assets/logoApp.png",fit: BoxFit.cover,),radius: 20,)),                          
                    Expanded(
                      flex: 2,
                      child: Text.rich(TextSpan(
                        text: message.notification!.title.toString(),style: const TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: message.notification!.body.toString(),style: const TextStyle(fontWeight: FontWeight.normal))
                        ]
                      )
                    )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Text(formatDatetime,style: TextStyle(color: Colors.grey[500],fontSize: 12),)
                ],),
                const Divider(color: Colors.black54,)
              ],
            ),     
      )
    );
  }
}