import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  String name="Living room's light ";
  String description="is being turned on,Did you turn on it?";
  String formatDatetime = DateFormat("dd/MM/yyyy HH:mm ").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon:const Icon(Icons.arrow_back),color: Colors.grey[400],),
        title: Text("NOTIFICATIONS",style: TextStyle(color: Colors.grey[400],fontSize: 25,fontWeight: FontWeight.w500)),
        centerTitle: true,
      ),
      body: null
    );
  }
}