import 'package:dream_team/components/navigation_bar_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BottomNavigationBarWidget extends HookWidget {
  final int pageIndex;
  final void Function(int index) onChange;
  const BottomNavigationBarWidget({
    Key? key,
    required this.onChange,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 72,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF2F2F2F),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavigationBarIconWidget(
                  icon: Icons.shopping_cart_rounded,
                  active: pageIndex == 0,
                  onClick: () => onChange(0),
                ),
                NavigationBarIconWidget(
                  icon: Icons.groups_rounded,
                  active: pageIndex == 1,
                  onClick: () => onChange(1),
                ),
                NavigationBarIconWidget(
                  icon: Icons.person_rounded,
                  active: pageIndex == 2,
                  onClick: () => onChange(2),
                ),
                NavigationBarIconWidget(
                  icon: Icons.settings_rounded,
                  active: pageIndex == 3,
                  onClick: () => onChange(3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
