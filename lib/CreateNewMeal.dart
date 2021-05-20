import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  NewButton({required this.onPressed});

  final GestureTapCallback onPressed;

  @override
Widget build(BuildContext context)  {
    return RawMaterialButton(
        fillColor: Colors.deepOrange,
        splashColor: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 9.0,
              horizontal: 20.0),
          child: Text("Go Back",
          style: TextStyle(color: Colors.white
            )
          ),
        ),
          onPressed: onPressed,
          shape: const StadiumBorder(),
    );
  }
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a new meal"),
      ),
      body: Center(
        child: NewButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}