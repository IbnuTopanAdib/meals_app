import 'package:flutter/material.dart';

enum Filter {
  gluttenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterScreen extends StatefulWidget {
  final Map<Filter, bool> filters;
  const FilterScreen({super.key, required this.filters});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isSetGluttenFree = false;
  bool _isSetLactoseFree = false;
  bool _isSetVegetarian = false;
  bool _isSetVegan = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSetGluttenFree = widget.filters[Filter.gluttenFree]!;
    _isSetLactoseFree = widget.filters[Filter.lactoseFree]!;
    _isSetVegan = widget.filters[Filter.vegan]!;
    _isSetVegetarian = widget.filters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Screen'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.gluttenFree: _isSetGluttenFree,
            Filter.lactoseFree: _isSetLactoseFree,
            Filter.vegetarian: _isSetVegetarian,
            Filter.vegan: _isSetVegan,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _isSetGluttenFree,
              onChanged: (newValue) {
                setState(() {
                  _isSetGluttenFree = newValue;
                });
              },
              title: Text(
                'Glutten Free',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include glutten free',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isSetLactoseFree,
              onChanged: (newValue) {
                setState(() {
                  _isSetLactoseFree = newValue;
                });
              },
              title: Text(
                'Lactose Free',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include lactose free',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isSetVegetarian,
              onChanged: (newValue) {
                setState(() {
                  _isSetVegetarian = newValue;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include vegetarian',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isSetVegan,
              onChanged: (newValue) {
                setState(() {
                  _isSetVegan = newValue;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include vegan',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            )
          ],
        ),
      ),
    );
  }
}
