import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrition App',
      home: NutritionHomePage(),
    );
  }
}

class NutritionHomePage extends StatefulWidget {
  @override
  _NutritionHomePageState createState() => _NutritionHomePageState();
}

class _NutritionHomePageState extends State<NutritionHomePage>
    with TickerProviderStateMixin {
  final title = 'Today\'s Nutrition';
  final textPlaceholder = '1254 Calories \n 54g Protein';

  var consumedMeals = ['coco pops', 'apricot'];
  var meals = {'coco pops': '500,2.5', 'apricot': '100,1.5'};

  //The only way I could work out how to stagger the animations by a little is to create two separate ones
  //First Animation
  late AnimationController _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  late final Animation<double> _menuButtonOpacityAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  late final Animation<double> _menuIconRotationAnimation =
    Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(parent: _animationController, curve: Curves.ease));
  late final Animation<Offset> _menuButtonSlideAnimation =
    Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.ease));


  //Second Animation
  late AnimationController _animationController2 = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  late final Animation<double> _menuButtonTwoOpacityAnimation = CurvedAnimation(parent: _animationController2, curve: Curves.easeIn);
  late final Animation<Offset> _menuButtonTwoSlideAnimation =
  Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero
  ).animate(CurvedAnimation(parent: _animationController2, curve: Curves.ease));

  // @override
  // void initState() {
  //   super.initState();
  //   _animationController.addListener(() {
  //     setState(() {
  //
  //     });
  //   });
  // }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double getRadiansFromDegrees(double degree) {
    return degree * 3.1415926535897932 / 180;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final navigationBarHeight = size.height / 7.5;
    return Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              // Add the app bar to the CustomScrollView.
              SliverAppBar(
                // Provide a standard title.
                title: Text(
                  title,
                  style: TextStyle(color: Colors.black),
                ),
                //Add color
                backgroundColor: Colors.transparent,
                // Allows the user to reveal the app bar if they begin scrolling
                // back up the list of items.
                floating: false,
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsetsDirectional.only(bottom: 92),
                  centerTitle: true,
                  title: Text(textPlaceholder,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      )),
                ),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: 350,
                // Make it pinned so always shows
                pinned: false,
              ),
              SliverToBoxAdapter(
                child: Container(
                  //color: Colors.black12,
                  height: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0.0, -13),
                              blurRadius: 16.0,
                              spreadRadius: -7.0,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Next, create a SliverList
              SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => ConsumedMealListItem(
                    mealName: consumedMeals[index],
                    calories:
                        meals[consumedMeals[index]].toString().split(',').first,
                    protein:
                        meals[consumedMeals[index]].toString().split(',').last,
                  ),
                  // Builds 1000 ListTiles
                  childCount: consumedMeals.length,
                ),
              ),
            ],
          ),
          Positioned(
            //This is the beginning on the nav bar
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: navigationBarHeight,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, navigationBarHeight),
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
                              if (_animationController2.isCompleted) {
                                _animationController.reverse();
                                Future.delayed(Duration(milliseconds: 60), () {_animationController2.reverse();});
                              } else {
                                _animationController.forward();
                                Future.delayed(Duration(milliseconds: 60), () {_animationController2.forward();});
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
                    width: size.width,
                    height: navigationBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.home),
                          color: Colors.orange,
                          onPressed: () {},
                          iconSize: navigationBarHeight / 3,
                        ),
                        Container(
                          width: size.width * 0.08,
                        ),
                        IconButton(
                          icon: Icon(Icons.restaurant_menu),
                          onPressed: () {},
                          iconSize: navigationBarHeight / 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            //This is the first of the floating menu items
            bottom: navigationBarHeight + size.height * 0.05,
            left: size.width * 0.05,
            child: Stack(children: [
              SlideTransition(
                position: _menuButtonSlideAnimation,
                child: FadeTransition(
                  opacity: _menuButtonOpacityAnimation,
                  child: FloatingMenuItem(
                    width: size.width * 0.9,
                    height: navigationBarHeight/2,
                    color: Colors.orange,
                    text: "Record consumed meal",
                    textColor: Colors.white,
                    onClick: () {},
                  ),
                ),
              ),
            ]),
          ),
          Positioned(
            //This is the second of the floating menu items
            bottom: navigationBarHeight*1.75 + size.height * 0.05,
            left: size.width * 0.05,
            child: Stack(children: [
              SlideTransition(
                position: _menuButtonTwoSlideAnimation,
                child: FadeTransition(
                  opacity: _menuButtonTwoOpacityAnimation,
                  child: FloatingMenuItem(
                    width: size.width * 0.9,
                    height: navigationBarHeight/2,
                    color: Colors.orange,
                    text: "Create new meal",
                    textColor: Colors.white,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    }, //this is where you are going to make a function for creating a new meal
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
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
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Manns got me working on the sabath, you get me?'),
        ),
      ),
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
    Path path = Path()..moveTo(0, 20);
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
    Path pathShadow = Path()..moveTo(0, 20 + shadowOffset);
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

class ConsumedMealListItem extends StatelessWidget {
  const ConsumedMealListItem({
    Key? key,
    required this.mealName,
    required this.calories,
    required this.protein,
  }) : super(key: key);

  final String mealName;
  final String calories;
  final String protein;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0, 8.0, 28.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${mealName[0].toUpperCase()}${mealName.substring(1)}',
            style: TextStyle(fontSize: 24.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(calories + ' ', style: TextStyle(fontSize: 17.0)),
                  Text(protein + ' ', style: TextStyle(fontSize: 17.0)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('KCal', style: TextStyle(fontSize: 17.0)),
                  Text('grams', style: TextStyle(fontSize: 17.0)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
