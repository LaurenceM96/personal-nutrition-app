import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This is where the design of a second button, NewButton2, can be edited.
class NewButton1 extends StatelessWidget {
  NewButton1({required this.onPressed});

  final GestureTapCallback onPressed;

  @override
Widget build(BuildContext context)  {
    return RawMaterialButton(
        fillColor: Colors.orange.shade800,
        splashColor: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 125.0),
          child: Text("Breakfast",
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


// This is where the design of a second button, NewButton2, can be edited.
class NewButton2 extends StatelessWidget {
  NewButton2({required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context)  {
    return RawMaterialButton(
      fillColor: Colors.orange.shade800,
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 125.0),
        child: Text("  Lunch  ",
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

// This is where the design of a second button, NewButton3, can be edited.
class NewButton3 extends StatelessWidget {
  NewButton3({required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context)  {
    return RawMaterialButton(
      fillColor: Colors.orange.shade800,
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 125.0),
        child: Text("  Dinner  ",
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

// This is where the design of a second button, NewButton3, can be edited.
class NewButton4 extends StatelessWidget {
  NewButton4({required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context)  {
    return RawMaterialButton(
      fillColor: Colors.orange.shade800,
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 125.0),
        child: Text("  Other  ",
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