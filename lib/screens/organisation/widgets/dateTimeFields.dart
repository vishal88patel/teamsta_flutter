import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:teamsta/constants/export_constants.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({
    Key? key,
    required this.dateController,
    required this.timeController,
    this.dateHint, 
    this.timeHint,
  }) : super(key: key);

  final TextEditingController dateController;
  final TextEditingController timeController;
  final String? dateHint;
  final String? timeHint;

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  double phoneWidth() {
    double result = mobileWidth / 3;
    return result;
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date and Time",
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date",
                  style: Theme.of(context).textTheme.headline3,
                ),
                InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      theme: DatePickerTheme(
                          cancelStyle: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                          doneStyle: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                          itemStyle: Theme.of(context).textTheme.headline3!,
                          headerColor: customPurple),
                      minTime: DateTime(2022, 1, 1),
                      maxTime: DateTime(2030, 12, 31),
                      onConfirm: (date) {
                        widget.dateController.text =
                            "${date.day}/${date.month}/${date.year}";
                        setState(() {});
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: customLightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    width: phoneWidth(),
                    child: Text(widget.dateController.text),
                  ),
                ),
                Text(
                  "Time",
                  style: Theme.of(context).textTheme.headline3,
                ),
                InkWell(
                  onTap: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      showSecondsColumn: false,
                      theme: DatePickerTheme(
                          cancelStyle: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                          doneStyle: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                          itemStyle: Theme.of(context).textTheme.headline3!,
                          headerColor: customPurple),
                      onConfirm: (time) {
                        widget.timeController.text = time.asString;

                        // if (time.minute < 10 && time.hour >= 10) {
                        //   widget.timeController.text =
                        //       "${time.hour}:0${time.minute}";
                        // } else if (time.hour < 10 && time.minute >= 10) {
                        //   widget.timeController.text =
                        //       "0${time.hour}:${time.minute}";
                        // } else if (time.hour < 10 && time.minute < 10) {
                        //   widget.timeController.text =
                        //       "0${time.hour}:0${time.minute}";
                        // } else {
                        //   widget.timeController.text =
                        //       "${time.hour}:${time.minute}";
                        // }

                        setState(() {});
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: customLightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    width: phoneWidth(),
                    child: Text(widget.timeController.text),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
