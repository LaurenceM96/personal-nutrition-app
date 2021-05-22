import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This is where the design of a second button, NewButton2, can be edited.
class NewButton extends StatelessWidget {


  NewButton({
    required this.onPressed,
    required this.text
  });

  final GestureTapCallback onPressed;
  final String text;

  @override
Widget build(BuildContext context)  {
    return RawMaterialButton(
        fillColor: Colors.orange.shade800,
        splashColor: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 125.0),
          child: Text(text,
          style: TextStyle(color: Colors.white,
              fontSize: 25.0
            )
          ),
        ),
          onPressed: onPressed,
          shape: const StadiumBorder(),
    );
  }
}

