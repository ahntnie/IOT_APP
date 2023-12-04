import 'package:flutter/material.dart';

class device_detail extends StatefulWidget {
  String selectedValue;
  String newValue;
   device_detail({super.key,required this.selectedValue,required this.newValue});

  @override
  State<device_detail> createState() => _device_detailState();
}



class _device_detailState extends State<device_detail> {
  List<String> items = ['True', 'False'];
  List<String> item=['Hành lang','Phòng khách','Phòng bếp','Nhà vệ sinh','Phòng ngủ'];
  List<String> itm = ['Công tắc', 'biến trở'];
  @override
  Widget build(BuildContext context) {
    var selectedValue;
    return  Scaffold(
      appBar: AppBar( title: Text(
          'DEVICE DETAIL',
          style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 25,
              fontWeight: FontWeight.w500),
      
      ),
       centerTitle: true,
       leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[400],
          ),
        ),
        actions: [IconButton(onPressed: (){}, 
        icon: Icon(
          Icons.delete_sharp,
          color: Colors.grey[400],
        ))],
      ),
      body: Center(
        child: Column(
          children: [
            Row(children: [
              CircleAvatar( radius: 100.0,
              backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/6134/6134812.png'),)
            ],),
            Row(
                children: [
                  Column(children: [
                    Text("Tên thiết bị",style: TextStyle(fontSize: 20)),SizedBox(width: 16.0)
                  ],),
                  Container(
                    child: Column(
                      children: [
                        TextField(onChanged: (newValue) {
                          
                        },)
                      ],
                    ),
                    height: 80,
                    width: 100,
                  )
                ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text("Status trạng thái",style: TextStyle(fontSize: 20),),SizedBox(width: 16.0,)
                  ],
                ),
                Column(
                  
                  children: [
                    
                   DropdownButton(
                   value: selectedValue,
                       items: items.map((String value) {
                   return DropdownMenuItem(
                        value: value,
                      child: Text(value),
                   );
                     }).toList(),
                              onChanged: ( newValue) => setState(() {
                               selectedValue = newValue;
                        }),
                          )
                  ],
                ),

              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text("Vị trí",style: TextStyle(fontSize: 20),),SizedBox(width: 16.0,)
                  ],
                ),
                Column(
                  children: [
                   DropdownButton(
                   value: selectedValue,
                       items: item.map((String value) {
                   return DropdownMenuItem(
                        value: value,
                      child: Text(value),
                   );
                     }).toList(),
                              onChanged: ( newValue) => setState(() {
                               selectedValue = newValue;
                        }),
                          )
                  ],
                ),

              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text("Loại điều khiển",style: TextStyle(fontSize: 20),),SizedBox(width: 16.0,)
                  ],
                ),
                Column(
                  children: [
                     DropdownButton(
                   value: selectedValue,
                       items: itm.map((String value) {
                   return DropdownMenuItem(
                        value: value,
                      child: Text(value),
                   );
                     }).toList(),
                              onChanged: ( newValue) => setState(() {
                               selectedValue = newValue;
                        }),
                          )
                  ],
                )
              ],
            ),
            Row(
              children: [
                TextButton(onPressed: null, child: 
                Text("Save",style: TextStyle(fontSize: 20,backgroundColor: Colors.grey[400]),))
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      )
      
    );
  }
}
