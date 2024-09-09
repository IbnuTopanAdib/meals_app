import 'package:flutter/material.dart';
import 'package:meals_app/provider/favorite_provider.dart';
import 'package:meals_app/provider/filter_provider.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  String title = 'Food Category';

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const FilterScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final availableMeals = ref.watch(filterMealsProvider);

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
