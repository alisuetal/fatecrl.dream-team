import 'package:dream_team/components/amount_widget.dart';
import 'package:flutter/material.dart';

class AmountWithLabelWidget extends StatelessWidget {
  final String hint;
  final void Function() onDecrease;
  final void Function() onIncrease;
  final int? amount;

  const AmountWithLabelWidget({
    Key? key,
    required this.amount,
    required this.onDecrease,
    required this.hint,
    required this.onIncrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color(0xffAAAAAA), fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AmountWidget(
            amount: amount ?? 0,
            onDecrease: () => onDecrease(),
            onIncrease: () => onIncrease(),
          ),
        ),
      ],
    );
  }
}
