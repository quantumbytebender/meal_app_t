import 'package:flutter/material.dart';
import 'package:meal_app_t/tabs_and_drawer/tabs.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  static bool _isGlutenFree = false;
  static bool _isLactoseFree = false;
  static bool _isVegetarianOnly = false;
  static bool _isVeganOnly = false;

  @override
  void initState() {
    _isGlutenFree = kInitialFilters[Filters.glutenFree]!;
    _isLactoseFree = kInitialFilters[Filters.lactoseFree]!;
    _isVegetarianOnly = kInitialFilters[Filters.vegetarianOnly]!;
    _isVeganOnly = kInitialFilters[Filters.veganOnly]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Filters",
        ),
      ),
      body: PopScope(
        onPopInvoked: (bool h) {
          kInitialFilters[Filters.lactoseFree] = _isLactoseFree;
          kInitialFilters[Filters.glutenFree] = _isGlutenFree;
          kInitialFilters[Filters.veganOnly] = _isVeganOnly;
          kInitialFilters[Filters.vegetarianOnly] = _isVegetarianOnly;
          setState(() {});
          /*WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context, {
              Filters.glutenFree: _isGlutenFree,
              Filters.lactoseFree: _isLactoseFree,
              Filters.vegetarianOnly: _isVegetarianOnly,
              Filters.veganOnly: _isVeganOnly,
            });
          });*/
        },
        child: Column(
          children: [
            CustomSwitchListTile(
              value: _isGlutenFree,
              onTap: (value) {
                _isGlutenFree = value;
                setState(() {});
              },
              title: "Gluten-Free",
              subTitle: "Only include gluten free meals",
            ),
            CustomSwitchListTile(
              value: _isLactoseFree,
              onTap: (value) {
                _isLactoseFree = value;
                setState(() {});
              },
              title: "Lactose-Free",
              subTitle: "Only include lactose free meals",
            ),
            CustomSwitchListTile(
              value: _isVegetarianOnly,
              onTap: (value) {
                _isVegetarianOnly = value;
                setState(() {});
              },
              title: "Vegetarian",
              subTitle: "Show only vegetarian meals",
            ),
            CustomSwitchListTile(
              value: _isVeganOnly,
              onTap: (value) {
                _isVeganOnly = value;
                setState(() {});
              },
              title: "Vegan",
              subTitle: "Show only vegan meals",
            ),
          ],
        ),
      ),
    );
  }

/*  @override
  void dispose() {
    kInitialFilters[Filters.lactoseFree] = _isLactoseFree;
    kInitialFilters[Filters.glutenFree] = _isGlutenFree;
    kInitialFilters[Filters.veganOnly] = _isVeganOnly;
    kInitialFilters[Filters.vegetarianOnly] = _isVegetarianOnly;
    super.dispose();
  }*/
}

class CustomSwitchListTile extends StatelessWidget {
  final bool value;
  final Function(bool) onTap;
  final String title;
  final String subTitle;
  const CustomSwitchListTile(
      {super.key,
      required this.value,
      required this.onTap,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onTap,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
