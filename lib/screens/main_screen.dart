import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showSnackbar(message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavorite(Meal meal) {
    bool isInFavorite = _favoriteMeals.contains(meal);

    if (isInFavorite) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showSnackbar('Add to favorites');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showSnackbar('Remove from favorites');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoryScreen(
      toggleMealFavorite: _toggleMealFavorite,
    );
    if (_selectedIndex == 1) {
      activeScreen = MealsScreen(
        title: 'FavoriteScreen',
        meals: _favoriteMeals,
        toggleMealFavorite: _toggleMealFavorite,
      );
    }
    return Scaffold(
        body: activeScreen,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.orange,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _selectPage(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
          ],
        ));
  }
}
