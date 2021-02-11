import 'package:flutter/cupertino.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoritesMeals;

  FavoritesScreen(this.favoritesMeals);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void _removeMeal(String mealId) {
    setState(() {
      widget.favoritesMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favoritesMeals.isEmpty) {
      return Center(
        child: Text('The Favorites'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: widget.favoritesMeals[index].id,
            title: widget.favoritesMeals[index].title,
            imageUrl: widget.favoritesMeals[index].imageUrl,
            duration: widget.favoritesMeals[index].duration,
            complexity: widget.favoritesMeals[index].complexity,
            affordability: widget.favoritesMeals[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: widget.favoritesMeals.length,
      );
    }
  }
}
