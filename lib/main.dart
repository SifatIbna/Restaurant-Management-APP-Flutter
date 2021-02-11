import 'package:flutter/material.dart';
import 'package:food_app/dummy_data.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/filer_screen.dart';
import 'package:food_app/screens/meal_detail_screen.dart';
import 'package:food_app/screens/tab_screen_bottom.dart';

import './screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }

        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }

        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritesMeals.indexWhere((element) => element.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritesMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritesMeals.any((element) => element.id == id);
  }

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
        '/': (ctx) => BottomTabScreen(_favoritesMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilersScreen.routeName: (ctx) => FilersScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
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
