import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealsFavorite(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      // Correctly filter and update the state
      state = state.where((m) => m.id != meal.id).toList();
      return true; // Returning true if it was removed
    } else {
      // Adding the meal to favorites
      state = [...state, meal];
      return false; // Returning false if it was added
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
