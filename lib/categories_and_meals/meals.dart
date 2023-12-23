import 'package:flutter/material.dart';
import 'meal_detail.dart';
import 'models/meals_model.dart';

class Meals extends StatefulWidget {
  final String? title;
  final List<MealModel> meals;
  final Function(MealModel)? onMealToggle;

  const Meals({super.key, this.title, required this.meals, this.onMealToggle});

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  get _content {
    return widget.meals.isNotEmpty
        ? ListView.builder(
            itemCount: widget.meals.length,
            itemBuilder: (BuildContext context, int index) {
              return MealsItem(
                mealModel: widget.meals[index],
                onMealToggle: (meal) {
                  if (widget.onMealToggle != null) {
                    widget.onMealToggle!(meal);
                  }
                  setState(() {});
                },
              );
            },
          )
        : Center(
            child: Text(
              "No Meals Found",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return widget.title != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget.title!),
            ),
            body: _content,
          )
        : _content;
  }
}

class MealsItem extends StatelessWidget {
  final MealModel mealModel;
  final Function(MealModel)? onMealToggle;

  const MealsItem({super.key, required this.mealModel, this.onMealToggle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MealDetail(
                    mealModel: mealModel,
                    onMealToggle: onMealToggle,
                  );
                },
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                mealModel.imageUrl,
                fit: BoxFit.fill,
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stackTrace,
                ) {
                  return const Icon(Icons.error);
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        mealModel.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DetailTextRow(
                            iconData: Icons.monetization_on,
                            title: mealModel.affordability.name.toString()),
                        DetailTextRow(
                            iconData: Icons.work,
                            title: mealModel.complexity.name.toString()),
                        DetailTextRow(
                            iconData: Icons.watch_later,
                            title: mealModel.duration.toString()),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailTextRow extends StatelessWidget {
  final IconData iconData;
  final String title;
  const DetailTextRow({super.key, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.white,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title.capitalize(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
