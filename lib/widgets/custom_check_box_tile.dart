import 'package:book_my_table_app/utils/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../exports.dart';

class CustomCheckboxTile extends StatelessWidget {
  final double? scale;
  final void Function(bool?)? onChanged;
  final String? title;
  final TextStyle? titleStyle;
  final RxBool isSelected;
  final bool readOnly;
  final WidgetStateProperty<Color?>? fillColor;
  final Color? borderColor;

  const CustomCheckboxTile({super.key, this.scale, this.onChanged, this.title, this.titleStyle, required this.isSelected, this.readOnly = false, this.fillColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    Widget myCheckbox = Obx(
      () => Transform.scale(
        scale: scale ?? 1.2,
        child: Checkbox(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
          side: BorderSide(color: borderColor ?? Theme.of(context).primaryColor.withAppOpacity(readOnly ? 0.4 : 1)),
          activeColor: Theme.of(context).primaryColor,
          value: isSelected.value,
          onChanged: (val) {
            if (readOnly == false) {
              onTap();
            }
          },
        ),
      ),
    );

    if (!isValEmpty(title)) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (readOnly == false) ? onTap : () {},
        child: Row(
          children: [
            myCheckbox,
            Flexible(child: Text(title ?? "", style: titleStyle)),
          ],
        ),
      );
    } else {
      return myCheckbox;
    }
  }

  VoidCallback get onTap => () {
    onChanged != null ? onChanged!(isSelected.value) : null;
    isSelected.value = !isSelected.value;
  };
}
