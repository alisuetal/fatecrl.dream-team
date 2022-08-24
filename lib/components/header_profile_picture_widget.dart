import 'package:flutter/material.dart';

class HeaderProfilePictureWidget extends StatelessWidget {
  final String imgSrc;
  final void Function() function;

  const HeaderProfilePictureWidget({
    Key? key,
    required this.imgSrc,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onTap: () => function(),
        child: SizedBox(
          height: 32,
          width: 32,
          child: Image.network(
            imgSrc,
          ),
        ),
      ),
    );
  }
}
