import 'package:dream_team/components/small_button_widget.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String text, bool success) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PopUpWidget(
        title: title,
        text: text,
        success: success,
      );
    },
  );
}

class PopUpWidget extends StatelessWidget {
  final String title;
  final String text;
  final bool success;

  const PopUpWidget({
    required this.title,
    required this.text,
    required this.success,
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
            Icon(
              success ? Icons.check_circle_rounded : Icons.cancel_rounded,
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
                  width: 156,
                  child: SmallButtonWidget(
                    text: "OK",
                    function: () {
                      Navigator.of(context).pop();
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
