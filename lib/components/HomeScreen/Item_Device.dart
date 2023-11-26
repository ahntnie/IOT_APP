
import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/device.dart';

class ItemDevice extends StatefulWidget {
  const ItemDevice({super.key,required this.device});
  final Device device;

  @override
  State<ItemDevice> createState() => _ItemDeviceState();
}

class _ItemDeviceState extends State<ItemDevice>{
  bool status = false;
  @override
  Widget build(BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width*0.45,
        height: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:Container(  
            color: Colors.grey[200],
            child: Column(
              children: [
                Image.network(widget.device.url_image,fit: BoxFit.cover,width: 50,height: 50,),
                Text(widget.device.title,style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),textAlign: TextAlign.center,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(widget.device.status?"ON":"OFF",style: TextStyle(
                        color: widget.device.status?Colors.green:Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                    Switch(
                      value: widget.device.status,
                      onChanged: (value) {
                        setState(() {
                          widget.device.status = value;
                        });
                      })
                    
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }
}