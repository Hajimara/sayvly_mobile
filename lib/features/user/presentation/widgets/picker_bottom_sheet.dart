import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

DateTime _clampDate(DateTime value, DateTime min, DateTime max) {
  if (value.isBefore(min)) return min;
  if (value.isAfter(max)) return max;
  return value;
}

Future<DateTime?> showBirthDatePickerBottomSheet({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  String title = '생년월일 선택',
}) async {
  var selected = _clampDate(initialDate, firstDate, lastDate);

  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: AppSpacing.borderRadiusBottomSheet,
    ),
    builder: (context) {
      return SafeArea(
        child: SizedBox(
          height: 360,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('취소'),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTypography.body3Bold(),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(selected),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selected,
                  minimumDate: firstDate,
                  maximumDate: lastDate,
                  onDateTimeChanged: (value) {
                    selected = _clampDate(value, firstDate, lastDate);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<TimeOfDay?> showTimePickerBottomSheet({
  required BuildContext context,
  required TimeOfDay initialTime,
  String title = '시간 선택',
}) async {
  final now = DateTime.now();
  var selected = DateTime(
    now.year,
    now.month,
    now.day,
    initialTime.hour,
    initialTime.minute,
  );

  final result = await showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: AppSpacing.borderRadiusBottomSheet,
    ),
    builder: (context) {
      return SafeArea(
        child: SizedBox(
          height: 320,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('취소'),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTypography.body3Bold(),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(selected),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  initialDateTime: selected,
                  onDateTimeChanged: (value) {
                    selected = value;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  if (result == null) return null;
  return TimeOfDay(hour: result.hour, minute: result.minute);
}
