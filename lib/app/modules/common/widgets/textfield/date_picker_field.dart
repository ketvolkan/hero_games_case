// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_games_case/core/variables/colors.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/utils.dart';
import '../buttons/custom_inkwell.dart';
import '../texts/custom_text.dart';

class DatePickerField extends StatelessWidget {
  final String? label;
  final DateTime? selectedDate;
  final DateTime? initialDate;
  final bool isRequired;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime selectedDate)? onChanged;
  final List<int>? disabledWeekdays;
  final bool isArrowBackIcon;
  final bool isForwardIcon;
  final VoidCallback? arrowBackOnTap;
  final VoidCallback? forwardOnTap;
  final bool isDisabled;
  final String? hintText;

  const DatePickerField({
    Key? key,
    this.label,
    this.isRequired = false,
    this.selectedDate,
    this.onChanged,
    this.firstDate,
    this.lastDate,
    this.hintText,
    this.initialDate,
    this.disabledWeekdays,
    this.isArrowBackIcon = false,
    this.isForwardIcon = false,
    this.arrowBackOnTap,
    this.forwardOnTap,
    this.isDisabled = false,
  })  : assert(isArrowBackIcon ? arrowBackOnTap != null : arrowBackOnTap == null),
        assert(isForwardIcon ? forwardOnTap != null : forwardOnTap == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier _selectedDate = ValueNotifier<DateTime?>(selectedDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) labelText,
        SizedBox(
          width: Get.width,
          child: CustomInkwell(
            padding: EdgeInsets.zero,
            onTap: () => isDisabled ? null : getDateWithDatePicker(context, _selectedDate),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Utils.lowRadius))),
              child: Padding(
                padding: EdgeInsets.all(Utils.normalPadding),
                child: Row(
                  mainAxisAlignment: isArrowBackIcon ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                  children: [
                    if (isArrowBackIcon)
                      InkWell(
                        onTap: () => arrowBackOnTap!(),
                        child: const Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: ColorTable.getTextColor),
                        SizedBox(width: Utils.normalPadding),
                        ValueListenableBuilder(
                          valueListenable: _selectedDate,
                          builder: (context, value, child) => CustomText.custom(
                            value != null ? DateFormat("dd/MM/yyyy").format(value as DateTime) : hintText ?? "Tarih Seçiniz",
                          ),
                        ),
                      ],
                    ),
                    if (isForwardIcon)
                      InkWell(
                        onTap: () => forwardOnTap!(),
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding get labelText => Padding(
        padding: EdgeInsets.only(left: Utils.normalPadding),
        child: CustomText.high(
          label! + (isRequired ? '*' : ''),
          textColor: ColorTable.getTextColor,
        ),
      );

  Future<void> getDateWithDatePicker(BuildContext context, ValueNotifier selectedDate) async {
    final _selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value ?? initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(DateTime.now().year - 2),
        lastDate: lastDate ?? DateTime(DateTime.now().year + 2),
        selectableDayPredicate: (DateTime val) {
          return !(disabledWeekdays?.contains(val.weekday) ?? false);
        });
    if (_selectedDate != null) {
      selectedDate.value = _selectedDate;
      if (onChanged != null) onChanged!(selectedDate.value);
    }
  }
}
