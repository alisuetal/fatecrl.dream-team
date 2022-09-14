import 'package:flutter/material.dart';

class SquareInformationWidget extends StatelessWidget {
  final String info;
  final String label;

  const SquareInformationWidget({
    Key? key,
    required this.info,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: const Color(0xff2F2F2F),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Text(
                    info,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                          fontSize: 48,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 2,
                    ),
                    child: Text(
                      info,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.white,
                            fontSize: 48,
                          ),
                    ),
                  ),
                ],
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
