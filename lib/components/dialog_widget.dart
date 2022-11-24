import 'package:dream_team/components/small_button_widget.dart';
import 'package:flutter/material.dart';

Future<bool> showDialogWidget(
  BuildContext context,
  String title,
  String text,
  String leftText,
  String rightText,
) async {
  bool result = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return PopUpWidget(
        title: title,
        text: text,
        leftText: leftText,
        rightText: rightText,
      );
    },
  );
  return result;
}

class PopUpWidget extends StatelessWidget {
  final String title;
  final String text;
  final String leftText;
  final String rightText;

  const PopUpWidget({
    required this.title,
    required this.text,
    required this.leftText,
    required this.rightText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff222222),
      content: SizedBox(
        height: 256,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.question_mark_rounded,
              size: 48,
              color: Colors.white70,
            ),
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
            const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: GestureDetector(
                    child: Text(leftText),
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
                SizedBox(
                  width: 96,
                  child: SmallButtonWidget(
                    text: rightText,
                    function: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}
