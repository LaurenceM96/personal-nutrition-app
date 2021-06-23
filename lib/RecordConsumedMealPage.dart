import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app/MealsProvider.dart';
import 'package:provider/provider.dart';

import 'ConsumedMealsProvider.dart';

class RecordConsumedMealPage extends StatefulWidget {
  @override
  _RecordConsumedMealPageState createState() => _RecordConsumedMealPageState();
}

class _RecordConsumedMealPageState extends State<RecordConsumedMealPage> {

  late List _allMeals;

  List _searchResults = new List.empty(growable: true);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final allMeals = Provider.of<MealsProvider>(context);
    _allMeals = allMeals.getAllMeals.keys.toList();
    _searchResults = List.from(_allMeals);
  }


    void searchOperation(String searchText) {
    setState(() {
      _searchResults = List.from(_allMeals);
      if (searchText.isNotEmpty) {
        _searchResults.clear();
        for (int i = 0; i < _allMeals.length; i++) {
          String data = _allMeals[i];
          if (data.toLowerCase().contains(searchText.toLowerCase())) {
            _searchResults.add(data);
          }
        }
      }
      print(_searchResults);
      print(_allMeals);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              "Choose meal to record",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            floating: true,
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double top = constraints.biggest.height;
                return FlexibleSpaceBar(
                    titlePadding: EdgeInsetsDirectional.only(top: 100),
                    collapseMode: CollapseMode.none,
                    centerTitle: true,
                    title:
                    //SizedBox(height: 90.0),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 10),
                      opacity: 1/(1+(top-197).abs()),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                          child: Container(
                              height: 30.0,
                              width: double.infinity,
                              child: CupertinoTextField(
                                keyboardType: TextInputType.text,
                                placeholder: 'Search for a meal',
                                placeholderStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16.0
                                ),
                                prefix: Padding(
                                    padding: const EdgeInsets.fromLTRB(9.0, 3.5, 9.0, 3.5),
                                    child: Icon(
                                        Icons.search,
                                        color: Colors.black
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.black26
                                ),
                                onChanged: searchOperation,
                              )
                          )
                      ),
                    )
                );
              }
            ),
          ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                    (context, index) => ListTile(title: Text(_searchResults[index])),
                // Builds 1000 ListTiles
                childCount: _searchResults.length,
              ),
          )
        ],
      )
    );
  }
}