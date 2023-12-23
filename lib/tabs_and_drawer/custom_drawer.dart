import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final void Function(String identifire) onSelectScreen;
  const CustomDrawer({super.key, required this.onSelectScreen});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
              ]),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  color: Theme.of(context).colorScheme.primary,
                  size: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Cooking Up !",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          DrawerListItem(title: "Meals",icon:Icons.restaurant,onTap: (){
            onSelectScreen("Meals");
          },),
          DrawerListItem(title: "Filters",icon:Icons.settings,onTap: (){
            onSelectScreen("Filters");
          },)
        ],
      ),
    );
  }
  
}

class DrawerListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  const DrawerListItem({super.key, required this.title, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon,color: Theme.of(context).colorScheme.onBackground,),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
