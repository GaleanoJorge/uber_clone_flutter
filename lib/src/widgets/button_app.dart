import 'package:flutter/material.dart';
import 'package:uber_clone/src/utils/colors.dart' as utils;

class ButtonApp extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color? color;
  final IconData? icon;
  final Function? onPressed;

  const ButtonApp({
    required this.text,
    required this.onPressed,
    this.color = utils.Colors.uberCloneColor,
    this.textColor = Colors.white,
    this.icon = Icons.arrow_forward_ios,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: this.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        onPressed!();
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                this.text!,
                style: TextStyle(
                  color: this.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50,
              child: CircleAvatar(
                radius: 15,
                child: Icon(
                  this.icon,
                  color: utils.Colors.uberCloneColor,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
