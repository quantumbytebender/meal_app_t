import 'package:flutter/material.dart';
import 'package:meal_app_t/categories_and_meals/meals.dart';
import 'package:meal_app_t/categories_and_meals/models/category_model.dart';
import 'package:meal_app_t/dummy_data.dart';
import 'models/meals_model.dart';

class Categories extends StatelessWidget {
  final Function(MealModel)? onMealToggle;
  final List<MealModel> availableMeals;

  const Categories(
      {super.key, this.onMealToggle, required this.availableMeals});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (var category in availableCategories) {
      List<MealModel> meals = [];
      for (var meal in availableMeals) {
        if (meal.categories.contains(category.id)) {
          meals.add(meal);
        }
      }
      children.add(GridViewItem(
        categoryModel: category,
        meals: meals,
        onMealToggle: onMealToggle,
      ));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 3 / 2),
        children: [...children],
      ),
    );
  }
}

class GridViewItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function(MealModel)? onMealToggle;
  final List<MealModel> meals;

  GridViewItem(
      {super.key,
      required this.categoryModel,
      this.onMealToggle,
      required this.meals});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Meals(
                title: categoryModel.title,
                meals: meals,
                onMealToggle: onMealToggle,
              );
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              categoryModel.color.withOpacity(0.8),
              categoryModel.color.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryModel.title,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
