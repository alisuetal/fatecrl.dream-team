import 'package:dream_team/components/bottom_navigation_bar_widget.dart';
import 'package:dream_team/screens/leagues_screen.dart';
import 'package:dream_team/screens/settings_screen.dart';
import 'package:dream_team/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'team_screen.dart';

class TabsScreen extends HookWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedScreenIndex = useState<int>(0);
    final List<Widget> screens = [
      TeamScreen(
        changePage: () {
          selectedScreenIndex.value = 2;
        },
      ),
      LeaguesScreen(
        changePage: () {
          selectedScreenIndex.value = 2;
        },
      ),
      const UserScreen(),
      SettingsScreen(
        changePage: () {
          selectedScreenIndex.value = 2;
        },
      ),
    ];
    return Stack(
      fit: StackFit.expand,
      children: [
        screens[selectedScreenIndex.value],
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: BottomNavigationBarWidget(
                onChange: (int index) => selectedScreenIndex.value = index,
                pageIndex: selectedScreenIndex.value,
              ),
            )
          ],
        )
      ],
    );
  }
}
