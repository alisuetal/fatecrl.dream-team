import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeonitasMarketWidget extends StatelessWidget {
  final int leonitas;

  const LeonitasMarketWidget({
    Key? key,
    required this.leonitas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          leonitas.toString(),
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white70,
              ),
        ),
        const SizedBox(
          width: 12,
        ),
        SvgPicture.asset(
          "assets/svg/logo.svg",
          height: 24,
          width: 24,
          color: Colors.white70,
        ),
      ],
    );
  }
}
