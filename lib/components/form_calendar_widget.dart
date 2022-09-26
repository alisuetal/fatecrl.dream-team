import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormCalendarWidget extends StatefulWidget {
  DateTime? selectedDate;
  final Function(DateTime) onDateChanged;

  FormCalendarWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  State<FormCalendarWidget> createState() => _FormCalendarWidgetState();
}

class _FormCalendarWidgetState extends State<FormCalendarWidget> {
  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }
      widget.onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Data Nascimento",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: const Color(0xffAAAAAA)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: SizedBox(
              height: 64,
              child: Stack(
                children: [
                  TextFormField(
                    controller: TextEditingController(
                      text: widget.selectedDate != null
                          ? DateFormat('dd/MM/y').format(widget.selectedDate!)
                          : "",
                    ),
                    maxLength: 120,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xff2F2F2F),
                      counterText: "",
                      contentPadding: EdgeInsets.only(
                        top: 24,
                        left: 24,
                        bottom: 18,
                        right: 48,
                      ),
                      hintText: "Data Nascimento",
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                    cursorColor: Colors.white,
                    readOnly: true,
                    onTap: () => _showDatePicker(context),
                    validator: (birthDay) {
                      final birthday = birthDay ?? "";
                      if (birthday.isEmpty) {
                        return "Digite sua data de nascimento";
                      }
                      final DateTime dataMinima = DateTime(
                        DateTime.now().year - 18,
                        DateTime.now().month,
                        DateTime.now().day,
                      );
                      if (widget.selectedDate!.isAfter(dataMinima)) {
                        return "Precisa ser maior de 18 anos";
                      }

                      return null;
                    },
                  ),
                  if (widget.selectedDate != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => setState(() {
                                  widget.selectedDate = null;
                                }),
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: Colors.white.withOpacity(0.08),
                                  ),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
