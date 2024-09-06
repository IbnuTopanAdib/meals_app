import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final void Function(String identifier) selectScreen;
  const MainDrawer({super.key, required this.selectScreen});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.orange.withOpacity(0.7),
                Colors.orange.withOpacity(0.8)
              ])),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Meals App',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.fastfood,
                    size: 28,
                  )
                ],
              )),
          Card(
            child: ListTile(
              onTap: () {
                selectScreen('meals');
              },
              leading: const Icon(Icons.restaurant_menu),
              title: Text(
                'Meals',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                selectScreen('filters');
              },
              leading: const Icon(Icons.settings),
              title: Text(
                'Filter by',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          )
        ],
      ),
    );
  }
}
