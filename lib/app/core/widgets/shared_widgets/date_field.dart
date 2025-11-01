import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:engaz_task/app/core/l10n/l10n.dart';
import 'package:engaz_task/app/core/services/theme_service.dart';

class DateField extends StatelessWidget {
  const DateField({
    required this.name,
    required this.label,
    super.key,
    this.validator,
  });

  final String name;
  final String label;
  final String? Function(DateTime?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.formFieldLabelStyle,
        ),
        SizedBox(height: 8.h),
        FormBuilderDateTimePicker(
          name: name,
          inputType: InputType.date,
          format: DateFormat('yyyy-MM-dd'),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          decoration: AppTheme.buildFormFieldDecoration(
            hintText: context.l10n.chooseDate,
            suffixIcon: Icon(
              Icons.calendar_today,
              size: 18.sp,
              color: AppColors.secondary,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
