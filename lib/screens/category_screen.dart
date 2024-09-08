import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {
  final void Function(Meal meal) toggleMealFavorite;
  final List<Meal> availableMeals;
  const CategoryScreen({super.key, required this.toggleMealFavorite, required this.availableMeals});

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          toggleMealFavorite: toggleMealFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: availableCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        final category = availableCategories[index];
        return CategoryItem(
          category: category,
          selectCategory: () {
            _selectCategory(context, category);
          },
        );
      },
    );
  }
}
