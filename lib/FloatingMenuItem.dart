import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingMenuItem extends StatelessWidget { //this is the floating menu item
  FloatingMenuItem({
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.textColor,
    required this.onClick,
  });

  final double width;
  final double height;
  final Color color;
  final String text;
  final Color textColor;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Material(
        //The Inkwell needs to be wrapped in Material widget so the ripple effect shows
        color: Colors.transparent,
        child: InkWell(
          //This is a widget that provides onTap functionality
          onTap: () => onClick(),
          child: Column(
            // We wrap the text in a column here to center the text vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,
                  style: TextStyle(color: textColor, fontSize: height * 0.5),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
