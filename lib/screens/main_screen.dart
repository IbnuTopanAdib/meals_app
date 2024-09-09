import 'package:flutter/material.dart';
import 'package:meals_app/provider/favorite_provider.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Map<Filter, bool> selectedFilters = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  String title = 'Food Category';

  Map<Filter, bool> _selectedFilters = selectedFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
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



  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
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

      availableMeals: availableMeals,
    );
    if (_selectedIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
 
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
