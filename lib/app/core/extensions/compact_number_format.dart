import 'package:easy_localization/easy_localization.dart';

/// Extension on double to format numbers into compact representation
extension CompactNumberFormat on double {
  /// Returns a compact string representation (e.g., 5120 -> 5.1k)
  String toCompact({int decimals = 1}) {
    if (this >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(decimals)} ${'b'.tr()}';
    } else if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(decimals)} ${'m'.tr()}';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(decimals)} ${'k'.tr()}';
    } else {
      return toStringAsFixed(decimals);
    }
  }
}
