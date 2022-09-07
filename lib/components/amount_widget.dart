import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {
  final int amount;
  final void Function() onIncrease;
  final void Function() onDecrease;
  const AmountWidget({
    required this.amount,
    required this.onDecrease,
    required this.onIncrease,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        color: const Color(0xff2F2F2F),
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => onDecrease(),
              child: Container(
                height: 56,
                width: 72,
                color: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.remove_rounded),
              ),
            ),
            Text(
              amount.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            GestureDetector(
              onTap: () => onIncrease(),
              child: Container(
                height: 56,
                width: 72,
                color: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.add_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
