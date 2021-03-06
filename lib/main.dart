import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app/ConsumedMealsProvider.dart';
import 'package:nutrition_app/FloatingMenuItem.dart';
import 'package:nutrition_app/CustomShapedNavBar.dart';
import 'package:nutrition_app/RossButton.dart';
import 'package:provider/provider.dart';

import 'MealsProvider.dart';
import 'RecordConsumedMealPage.dart';

void main() => runApp(MyApp());

class RecordConsumedMealPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MealsProvider>(
      create: (_) {
        return MealsProvider();
      },
      child: RecordConsumedMealPage(),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final navigationBarHeight = size.height / 7.5;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MealsProvider()),
        ChangeNotifierProvider(create: (context) => ConsumedMealsProvider()),
      ],
      child: Scaffold(
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
                Consumer2<MealsProvider, ConsumedMealsProvider>(
                  builder: (context, meals, consumedMeals, child) {
                    return SliverList(
                      // Use a delegate to build items as they're scrolled on screen.
                      delegate: SliverChildBuilderDelegate(
                        // The builder function returns a ListTile with a title that
                        // displays the index of the current item.
                            (context, index) =>
                            ConsumedMealListItem(
                              mealName: consumedMeals.getConsumedMeals[index],
                              calories:
                              meals.getAllMeals[consumedMeals.getConsumedMeals[index]]
                                  .toString()
                                  .split(',')
                                  .first,
                              protein:
                              meals.getAllMeals[consumedMeals.getConsumedMeals[index]]
                                  .toString()
                                  .split(',')
                                  .last,
                            ),
                        childCount: consumedMeals.getConsumedMeals.length,
                      ),
                    );
                  }
                ),
              ],
            ),
            CustomShapedNavBar(
                navBarHeight: navigationBarHeight,
                navBarWidth: size.width,
                menuItems: [
                  FloatingMenuItem(
                      width: size.width * 0.9,
                      height: navigationBarHeight/2,
                      color: Colors.orange,
                      text: "Record consumed meals",
                      textColor: Colors.white,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return RecordConsumedMealPageProvider();
                            },
                          ),
                        );
                      }
                  ),
                  FloatingMenuItem(
                      width: size.width * 0.9,
                      height: navigationBarHeight/2,
                      color: Colors.orange,
                      text: "Create new meals",
                      textColor: Colors.white,
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondRoute()),
                        );
                      }
                  )
                ]
            )
          ],
        ),
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

        body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [

          Container(
              child: Padding(
                  padding: EdgeInsets.only(top: 10, left:33.333, bottom: 10),
                  child: NewButton(
                      text: "Breakfast",
                      onPressed: () {}
                  )
              )
          ),

          Container(
              child: Padding(
              padding: EdgeInsets.only(top: 10, left:33.333, bottom: 10),
              child: NewButton(
                  text: "  Lunch  ",
                  onPressed: () {}
              )
              )
          ),


          Container(
              child: Padding(
                  padding: EdgeInsets.only(top: 10, left:33.333, bottom: 10),
                  child: NewButton(
                      text: "  Dinner  ",
                      onPressed: () {}
                  )
              )
          ),

          Container(
              child: Padding(
                  padding: EdgeInsets.only(top: 10, left:33.333, bottom: 20),
                  child: NewButton(
                      text: "  Other  ",
                      onPressed: () {}
                  )
              )
          ),

        ]
      )
    );
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
