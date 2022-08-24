import 'package:dream_team/tools/color_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScreenHolderWidget extends StatelessWidget {
  final Widget content;

  const ScreenHolderWidget({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorUtilities.backgroundColor,
        systemNavigationBarColor: ColorUtilities.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: ColorUtilities.backgroundColor,
      body: SafeArea(
        child: content,
      ),
    );
  }
}
