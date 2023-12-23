import 'package:flutter/material.dart';
import 'package:meal_app_t/categories_and_meals/models/meals_model.dart';
import 'package:meal_app_t/tabs_and_drawer/tabs.dart';

class MealDetail extends StatefulWidget {
  final MealModel mealModel;
  final Function(MealModel)? onMealToggle;
  const MealDetail({super.key, required this.mealModel, this.onMealToggle});

  @override
  State<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    isSelected = favoriteMeals.contains(widget.mealModel);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealModel.title),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.onMealToggle != null) {
                  widget.onMealToggle!(widget.mealModel);
                }
                setState(() {});
              },
              icon: Icon(
                Icons.favorite,
                color: isSelected ? Colors.purple : Colors.grey,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.mealModel.imageUrl,
              fit: BoxFit.fill,
              errorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) {
                return const Icon(Icons.error);
              },
            ),
            IngredientAndSteps(
                title: "Ingredients", listing: widget.mealModel.ingredients),
            IngredientAndSteps(title: "Steps", listing: widget.mealModel.steps),
          ],
        ),
      ),
    );
  }
}

class IngredientAndSteps extends StatelessWidget {
  final String title;
  final List<String> listing;
  const IngredientAndSteps(
      {super.key, required this.title, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.orange),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listing.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${index + 1}. ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        listing[index],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
