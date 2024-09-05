import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  final String title;
  final List<Meal> meals;
  const MealsScreen({super.key, required this.title, required this.meals});

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return MealItem(meal: meal);
        });
    if (meals.isEmpty) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nothing here',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Please select different category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          )
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: content);
  }
}
