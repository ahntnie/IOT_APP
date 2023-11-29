import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final List<String> imgList = [
    'assets/anh.jpg',
    'assets/anh1.jpg',
    'assets/anh2.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterCarousel(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
      items: imgList
          .map((imgList) => Container(
                child: Center(
                  child: imgList != 'assets/anh2.jpg'
                      ? Image.asset(
                          imgList,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height,
                        )
                      : Stack(children: [
                          Image.asset(
                            imgList,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signin');
                              },
                              child: const Text('Get Started'),
                            ),
                          ),
                        ]),
                ),
              ))
          .toList(),
    ));
  }
}
