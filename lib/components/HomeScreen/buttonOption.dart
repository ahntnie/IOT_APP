import 'package:flutter/material.dart';

class ButtonOption extends StatefulWidget {
  const ButtonOption(
      {super.key,
      required this.roomName,
      required this.onPressed,
      this.icon,
      this.onLongPressed});
  final String roomName;
  final IconData? icon;
  final Function()? onPressed;
  final Function()? onLongPressed;
  @override
  State<ButtonOption> createState() => _ButtonOptionState();
}

class _ButtonOptionState extends State<ButtonOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
      width: MediaQuery.of(context).size.width * 0.40,
      height: 100,
      child: ElevatedButton(
          onLongPress: widget.onLongPressed,
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: widget.icon == null
              ? Text(
                  widget.roomName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                )
              : Icon(
                  widget.icon,
                  size: 25,
                  color: Colors.black,
                )),
    );
  }
}
