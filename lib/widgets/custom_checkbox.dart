import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    required this.value,
    required this.function,
    required this.isExtra,
    required this.heading,
    required this.subHeading,
  }) : super(key: key);

  final RxBool value;
  final void Function(bool?) function;
  final bool isExtra;
  final String heading;
  final String subHeading;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment:
            isExtra ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.5,
            child: Checkbox(value: value.value, onChanged: function),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: isExtra,
            replacement: Text(
              heading,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  subHeading,
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
