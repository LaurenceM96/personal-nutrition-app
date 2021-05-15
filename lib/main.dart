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

class _NutritionHomePageState extends State<NutritionHomePage> {

  final title = 'Today\'s Nutrition';
  final textPlaceholder = '1254 Calories \n 54g Protein';

  var consumedMeals = ['coco pops', 'apricot'];
  var meals = {'coco pops':'500,2.5', 'apricot':'100,1.5'};

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final navigationBarHeight = size.height/7.5;
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
                  titlePadding: EdgeInsetsDirectional.only(bottom: 92) ,
                  centerTitle: true,
                  title: Text(
                      textPlaceholder,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      )
                  ),
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
                          boxShadow: [BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0.0, -13),
                            blurRadius: 16.0,
                            spreadRadius: -7.0,
                          )],
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
                          calories: meals[consumedMeals[index]].toString().split(',').first,
                          protein: meals[consumedMeals[index]].toString().split(',').last,
                      ),
                  // Builds 1000 ListTiles
                  childCount: consumedMeals.length,
                ),
              ),
            ],
          ),
          Positioned(
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
                      child: FloatingActionButton(
                        onPressed: (){setState(() {
                          _visible ? _visible = false : _visible = true;
                        });},
                        backgroundColor: Colors.orange,
                        child: Icon(Icons.add, size: 48.0),
                        elevation: 0.1,
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
                          onPressed: (){},
                          iconSize: navigationBarHeight/3,
                        ),
                        Container(
                          width: size.width*0.08,
                        ),
                        IconButton(
                          icon: Icon(Icons.restaurant_menu),
                          onPressed: (){},
                          iconSize: navigationBarHeight/3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: navigationBarHeight + size.height*0.05,
            left: size.width*0.05,
            child: FloatingMenuItem(
                width: size.width*0.9,
                height: 80,
                color: Colors.orange,
                text: "TEST",
                textColor: Colors.white,
                visible: _visible,
                onClick: () {setState(() {
                  print(_visible);
                });},
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //create the actual path and paint
    Paint paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width*0.2, 0, size.width*0.35, 0);
    path.quadraticBezierTo(size.width*0.4, 0, size.width*0.4, 20);
    path.arcToPoint(Offset(size.width*0.6, 20), radius: Radius.circular(10),
    clockwise: false,);
    path.quadraticBezierTo(size.width*0.6, 0, size.width*0.65, 0);
    path.quadraticBezierTo(size.width*0.8, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    //create the shadow path and paint
    final shadowOffset = 0.0;
    Path pathShadow = Path()..moveTo(0, 20 + shadowOffset);
    pathShadow.quadraticBezierTo(size.width*0.2, 0 + shadowOffset, size.width*0.35, 0 + shadowOffset);
    pathShadow.quadraticBezierTo(size.width*0.4, 0 + shadowOffset, size.width*0.4, 20 + shadowOffset);
    pathShadow.arcToPoint(Offset(size.width*0.6, 20 + shadowOffset), radius: Radius.circular(10),
      clockwise: false,);
    pathShadow.quadraticBezierTo(size.width*0.6, 0 + shadowOffset, size.width*0.65, 0 + shadowOffset);
    pathShadow.quadraticBezierTo(size.width*0.8, 0 + shadowOffset, size.width, 20 + shadowOffset);
    pathShadow.lineTo(size.width, size.height);
    pathShadow.lineTo(0, size.height);
    pathShadow.close();

    Paint paintShadow = Paint()..color = Colors.black.withAlpha(180)..maskFilter
      = MaskFilter.blur(BlurStyle.normal, 10.0)..style = PaintingStyle.stroke;
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
          Text('${mealName[0].toUpperCase()}${mealName.substring(1)}', style: TextStyle(fontSize: 24.0),),
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

class FloatingMenuItem extends StatelessWidget {

  FloatingMenuItem({
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.textColor,
    required this.onClick,
    required this.visible,
  });

  final double width;
  final double height;
  final Color color;
  final String text;
  final Color textColor;
  final Function onClick;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: AnimatedContainer(
          duration: Duration(seconds: 2),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Material( //The Inkwell needs to be wrapped in Material widget so the ripple effect shows
            color: Colors.transparent,
            child: InkWell( //This is a widget that provides onTap functionality
                onTap: () => onClick(),
                child: Column( // We wrap the text in a column here to center the text vertically
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text, style: TextStyle(color: textColor, fontSize: height*0.5), textAlign: TextAlign.center),
                  ],
                ),
            ),
          ),
        ),
    );
  }
}