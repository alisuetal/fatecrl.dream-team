import 'package:flutter/material.dart';

class PlayerCardWidget extends StatelessWidget {
  final String imgSrc;
  final String name;
  final String team;
  final double variation;
  final int points;
  final Widget rightWidget;
  final int price;

  const PlayerCardWidget({
    Key? key,
    required this.imgSrc,
    required this.name,
    required this.team,
    required this.variation,
    required this.points,
    required this.rightWidget,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.only(right: 20),
        color: const Color(0xff2F2F2F),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    height: 80,
                    width: 64,
                    child: Image.network(
                      imgSrc,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProcess) =>
                          loadingProcess != null
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : child,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      team,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Row(
                    children: [
                      Icon(
                        variation > 0
                            ? Icons.arrow_drop_up_rounded
                            : Icons.arrow_drop_down_rounded,
                      ),
                      Text(
                        variation.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    points.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  "${price.toString()} \$",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            rightWidget,
          ],
        ),
      ),
    );
  }
}
