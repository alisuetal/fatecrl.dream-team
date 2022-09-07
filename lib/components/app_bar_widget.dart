import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final Widget? leftWidget;
  final Widget? rightWidget;

  const AppBarWidget({
    required this.title,
    this.leftWidget,
    this.rightWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (leftWidget != null) leftWidget!,
              if (leftWidget != null)
                const SizedBox(
                  width: 16,
                ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
          if (rightWidget != null) rightWidget!,
        ],
      ),
    );
  }
}
