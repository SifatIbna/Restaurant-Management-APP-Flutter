import 'package:flutter/material.dart';
import 'package:food_app/screens/meal_detail_screen.dart';
import 'package:food_app/screens/tab_screen_bottom.dart';

import 'file:///T:/WorkSpace/Developing/Flutter/food_app/lib/screens/category_meals_screen.dart';

import 'screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food APP',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 15,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => BottomTabScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },

      /// On Generate Route needed if some unexpected routing happens in
      /// the code. It's kind a fail safe

      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if(settings.arguments == '/meal-detail'){
        //   return ...
        // } else if(settings.arguments == '/something-else'){
        //   return ...
        // }

        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },

      ///UnknownRoute calls if flutter fails to call routes and onGenerateRoute
      /// it's making sure there's no exception generated

      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
