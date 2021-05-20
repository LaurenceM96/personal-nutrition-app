import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app/FloatingMenuItem.dart';

class CustomShapedNavBar extends StatefulWidget {
  CustomShapedNavBar({
    Key? key,
    required this.navBarHeight,
    required this.navBarWidth,
    required this.menuItems,
  }) : super(key: key);

  final double navBarHeight;
  final double navBarWidth;
  final List<FloatingMenuItem> menuItems;

  @override
  _CustomShapedNavBarState createState() =>
      _CustomShapedNavBarState(
        navBarHeight: navBarHeight,
        navBarWidth: navBarWidth,
        menuItems: menuItems,
      );
}

class _CustomShapedNavBarState extends State<CustomShapedNavBar>
    with TickerProviderStateMixin {
  _CustomShapedNavBarState({
    required this.navBarHeight,
    required this.navBarWidth,
    required this.menuItems,
  }) : super();

  final double navBarHeight;
  final double navBarWidth;
  final List<FloatingMenuItem> menuItems;

  List<AnimationController> _animationControllers = [];
  List<Animation<Offset>> _menuButtonSlideAnimations = [];
  List<Animation<double>> _menuButtonOpacityAnimations = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < menuItems.length + 1; i++) {
      _animationControllers.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)));
      _menuButtonSlideAnimations.add(Tween<Offset>(
          begin: Offset(0, 0.5),
          end: Offset.zero
      ).animate(
          CurvedAnimation(parent: _animationControllers[i], curve: Curves.ease)));
      _menuButtonOpacityAnimations.add(CurvedAnimation(parent: _animationControllers[i], curve: Curves.easeIn));
    }
  }

  late final Animation<double> _menuIconRotationAnimation =
  Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationControllers[0], curve: Curves.ease));

  bool _menuVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          //This is the beginning on the nav bar
          bottom: 0,
          left: 0,
          child: Container(
            width: navBarWidth,
            height: navBarHeight,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(navBarWidth, navBarHeight),
                  painter: NavBarCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: Container(
                    width: 65.0,
                    height: 65.0,
                    child: RotationTransition(
                      turns: _menuIconRotationAnimation,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            if (_animationControllers[0].isCompleted) {
                              for (int i = 0;
                              i < _animationControllers.length;
                              i++) {
                                Future.delayed(Duration(milliseconds: 60 * i),
                                        () {
                                      _animationControllers[i].reverse();
                                    });
                              }
                              Future.delayed(
                                  Duration(
                                      milliseconds: 60 +
                                          _animationControllers[0]
                                              .duration!
                                              .inMilliseconds), () {
                                setState(() {
                                  _menuVisibility = false;
                                });
                              });
                            } else {
                              _menuVisibility = true;
                              for (int i = 0;
                              i < _animationControllers.length;
                              i++) {
                                Future.delayed(Duration(milliseconds: 60 * i),
                                        () {
                                      _animationControllers[i].forward();
                                    });
                              }
                            }
                          });
                        },
                        backgroundColor: Colors.orange,
                        child: Icon(Icons.add, size: 48.0),
                        elevation: 0.1,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: navBarWidth,
                  height: navBarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //We should make these a separate class too, then we can pass in a list of what icons we want
                      IconButton(
                        icon: Icon(Icons.home),
                        color: Colors.orange,
                        onPressed: () {},
                        iconSize: navBarHeight / 3,
                      ),
                      Container(
                        width: navBarWidth * 0.08,
                      ),
                      IconButton(
                        icon: Icon(Icons.restaurant_menu),
                        onPressed: () {},
                        iconSize: navBarHeight / 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Stack(children: [
          for (var i = 0; i < menuItems.length; i++)
            Positioned(
                bottom: navBarHeight + menuItems[i].height * i * 1.35 + navBarHeight * 0.3,
                left: (navBarWidth - menuItems[i].width) / 2,
                child: SlideTransition(
                    position: _menuButtonSlideAnimations[i],
                    child: FadeTransition(
                      opacity: _menuButtonOpacityAnimations[i],
                      child: Visibility(
                        visible: _menuVisibility,
                        child: FloatingMenuItem(
                          width: menuItems[i].width,
                          height: menuItems[i].height,
                          color: menuItems[i].color,
                          text: menuItems[i].text,
                          textColor: menuItems[i].textColor,
                          onClick: menuItems[i].onClick
                        )
                      )
                    )
                )
            )
        ])
      ],
    );
  }
}

class NavBarCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //create the actual path and paint
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()
      ..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20);
    path.arcToPoint(
      Offset(size.width * 0.6, 20),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    //create the shadow path and paint
    final shadowOffset = 0.0;
    Path pathShadow = Path()
      ..moveTo(0, 20 + shadowOffset);
    pathShadow.quadraticBezierTo(size.width * 0.2, 0 + shadowOffset,
        size.width * 0.35, 0 + shadowOffset);
    pathShadow.quadraticBezierTo(size.width * 0.4, 0 + shadowOffset,
        size.width * 0.4, 20 + shadowOffset);
    pathShadow.arcToPoint(
      Offset(size.width * 0.6, 20 + shadowOffset),
      radius: Radius.circular(10),
      clockwise: false,
    );
    pathShadow.quadraticBezierTo(size.width * 0.6, 0 + shadowOffset,
        size.width * 0.65, 0 + shadowOffset);
    pathShadow.quadraticBezierTo(
        size.width * 0.8, 0 + shadowOffset, size.width, 20 + shadowOffset);
    pathShadow.lineTo(size.width, size.height);
    pathShadow.lineTo(0, size.height);
    pathShadow.close();

    Paint paintShadow = Paint()
      ..color = Colors.black.withAlpha(180)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0)
      ..style = PaintingStyle.stroke;
    paintShadow.strokeWidth = 5.0;

    //draw shadow first so it's underneath
    canvas.drawPath(pathShadow, paintShadow);
    //now draw actual nav bar
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
