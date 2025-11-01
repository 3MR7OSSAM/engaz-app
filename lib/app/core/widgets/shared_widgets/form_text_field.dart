import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engaz_task/app/core/services/theme_service.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    required this.name,
    required this.label,
    required this.hint,
    this.validator,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  final String name;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType keyboardType;

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
        FormBuilderTextField(
          name: name,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: AppTheme.buildFormFieldDecoration(hintText: hint),
          validator: validator,
        ),
      ],
    );
  }
}
