// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class NavigationBarIconWidget extends StatelessWidget {
  final IconData icon; //icon to be shown when active
  final bool active; //if the tab is active
  final Function() onClick; //used to change screens

  const NavigationBarIconWidget({
    required this.icon,
    required this.active,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: active
                ? Theme.of(context).colorScheme.primary
                : const Color(0xff888888),
          ),
          const SizedBox(
            height: 4,
          ),
          if (active)
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Container(
                height: 4,
                width: 4,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
        ],
      ),
    );
  }
}
