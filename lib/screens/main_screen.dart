import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const Map<Filter, bool> selectedFilters = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String title = 'Food Category';
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = selectedFilters;

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

  void _setSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (context) => FilterScreen(
          filters: _selectedFilters,
        ),
      ));
      setState(() {
        _selectedFilters = result ?? selectedFilters;
      });
    }
  }

  void _toggleMealFavorite(Meal meal) {
    bool isInFavorite = _favoriteMeals.contains(meal);

    if (isInFavorite) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showSnackbar('Remove from favorites');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showSnackbar('Add to favorites');
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.gluttenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoryScreen(
      toggleMealFavorite: _toggleMealFavorite,
      availableMeals: availableMeals,
    );
    if (_selectedIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        toggleMealFavorite: _toggleMealFavorite,
      );
      title = 'Favorite Food';
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: MainDrawer(selectScreen: _setSelectScreen),
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
