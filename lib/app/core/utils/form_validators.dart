import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:engaz_task/app/core/l10n/l10n.dart';

/// Validators for FormBuilder fields
/// All validators return a single validator function, not a list
class FormValidators {
  FormValidators._();

  /// Required field validator
  static String? Function(String?) required(
    BuildContext context,
    String fieldName,
  ) {
    return FormBuilderValidators.required(
      errorText: '$fieldName ${context.l10n.requiredField}',
    );
  }

  /// Numeric field validator (required, numeric, >= 0)
  static String? Function(String?) numeric(
    BuildContext context,
    String fieldName, {
    String? errorText,
  }) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: '$fieldName ${context.l10n.requiredField}',
      ),
      FormBuilderValidators.numeric(
        errorText: errorText ?? context.l10n.invalidPrice,
      ),
      FormBuilderValidators.min(
        0,
        errorText: errorText ?? context.l10n.invalidPrice,
      ),
    ]);
  }

  /// Integer field validator (required, integer, >= 0)
  static String? Function(String?) integer(
    BuildContext context,
    String fieldName, {
    String? errorText,
  }) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: '$fieldName ${context.l10n.requiredField}',
      ),
      FormBuilderValidators.integer(
        errorText: errorText ?? context.l10n.invalidQuantity,
      ),
      FormBuilderValidators.min(
        0,
        errorText: errorText ?? context.l10n.invalidQuantity,
      ),
    ]);
  }

  /// Date field validator (required)
  static String? Function(DateTime?) date(
    BuildContext context,
    String fieldName,
  ) {
    return (DateTime? value) {
      if (value == null) {
        return '$fieldName ${context.l10n.requiredField}';
      }
      return null;
    };
  }

  /// Optional field validator (no validation)
  static String? Function(String?)? optional() => null;
}

// Backward compatibility - mark as deprecated
@Deprecated('Use FormValidators.numeric instead')
List<String? Function(String?)> numericValidator(
  BuildContext context,
  String fieldName,
) {
  return [FormValidators.numeric(context, fieldName)];
}

@Deprecated('Use FormValidators.integer instead')
List<String? Function(String?)> integerValidator(
  BuildContext context,
  String fieldName,
) {
  return [FormValidators.integer(context, fieldName)];
}

@Deprecated('Use FormValidators.date instead')
String? Function(DateTime?)? dateValidator(
  BuildContext context,
  String fieldName,
) {
  return FormValidators.date(context, fieldName);
}

@Deprecated('Use FormValidators.required instead')
List<String? Function(String?)> requiredValidator(
  BuildContext context,
  String fieldName,
) {
  return [FormValidators.required(context, fieldName)];
}
