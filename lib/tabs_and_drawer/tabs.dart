import 'package:flutter/material.dart';
import 'package:meal_app_t/categories_and_meals/categories.dart';
import 'package:meal_app_t/categories_and_meals/meals.dart';
import 'package:meal_app_t/tabs_and_drawer/custom_drawer.dart';
import 'package:meal_app_t/tabs_and_drawer/settings.dart';
import '../categories_and_meals/models/meals_model.dart';
import '../dummy_data.dart';

final List<MealModel> favoriteMeals = [];

enum Filters { glutenFree, lactoseFree, vegetarianOnly, veganOnly }

Map<Filters, bool> kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarianOnly: false,
  Filters.veganOnly: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  String _appBarTitle = "Categories";
  int _selectedTabIndex = 0;
  late Widget _selectedTab;

  List<MealModel> availableMeals = [];

  @override
  void initState() {
    checkFilters();
    _tabIndexChanged(0);
    super.initState();
  }

  void _tabIndexChanged(int index) {
    if (index == 0) {
      _appBarTitle = "Categories";
      _selectedTabIndex = index;
      _selectedTab = Categories(
        availableMeals: availableMeals,
        onMealToggle: _onFavoriteToggle,
      );
    } else {
      _appBarTitle = "Favorites Meals";
      _selectedTabIndex = index;
      _selectedTab = Meals(
        meals: favoriteMeals,
        onMealToggle: _onFavoriteToggle,
      );
    }
    setState(() {});
  }

  void _onFavoriteToggle(MealModel meal) {
    debugPrint("Clicked On Button");
    if (favoriteMeals.contains(meal)) {
      favoriteMeals.remove(meal);
      debugPrint("Meals Removed");
    } else {
      favoriteMeals.add(meal);
      debugPrint("Meals Added");
    }
    setState(() {});
  }

  void checkFilters() {
    availableMeals.clear();
    debugPrint("Tabs Filter => $kInitialFilters");
    for (var meal in dummyMeals) {
      if (kInitialFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
        debugPrint("Inside glutenFree If And Breaking");
        continue;
      }
      if (kInitialFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        continue;
      }
      if (kInitialFilters[Filters.vegetarianOnly]! && !meal.isVegetarian) {
        continue;
      }
      if (kInitialFilters[Filters.veganOnly]! && !meal.isVegan) {
        continue;
      }
      availableMeals.add(meal);
    }
    debugPrint("It Waited According to me");
    debugPrint("Available Meals ===> ${availableMeals.length}");
    _tabIndexChanged(_selectedTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      drawer: CustomDrawer(
        onSelectScreen: (value) async {
          if (value == "Meals") {
          } else {
            Navigator.pop(context);
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const FilterScreen();
                },
              ),
            );
            // kInitialFilters = result;
            checkFilters();
          }
        },
      ),
      body: _selectedTab,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _tabIndexChanged,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_sharp), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites"),
        ],
      ),
    );
  }
}
