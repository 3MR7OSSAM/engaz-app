import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:engaz_task/app/core/utils/screen_style.dart';

/// Generic table column definition
class TableColumnConfig<T> {
  const TableColumnConfig({
    required this.header,
    required this.cellBuilder,
    this.flex = 1,
    this.headerStyle,
  });

  final String header;
  final Widget Function(T item) cellBuilder;
  final int flex;
  final TextStyle? headerStyle;
}

/// Generic data table widget
class GenericDataTable<T> extends StatelessWidget {
  const GenericDataTable({
    required this.items,
    required this.columns,
    this.leadingBuilder,
    this.trailingBuilder,
    this.onRowTap,
    this.emptyStateWidget,
    super.key,
  });

  final List<T> items;
  final List<TableColumnConfig<T>> columns;
  final Widget Function(T item)? leadingBuilder;
  final Widget Function(T item)? trailingBuilder;
  final void Function(T item)? onRowTap;
  final Widget? emptyStateWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Header
          _buildHeader(context),

          // Table Rows or Empty State
          if (items.isEmpty && emptyStateWidget != null)
            emptyStateWidget!
          else
            ...List.generate(items.length, (index) {
              final item = items[index];
              return _buildRow(context, item, index);
            }),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.primary20),
        ),
      ),
      child: Row(
        children: [
          // Leading space (for avatar, checkbox, etc.)
          if (leadingBuilder != null) SizedBox(width: 40.w),

          // Column Headers
          ...columns.map((column) {
            return Expanded(
              flex: column.flex,
              child: Text(
                column.header,
                style: column.headerStyle ?? headerStyle,
              ),
            );
          }),

          // Trailing space (for action buttons)
          if (trailingBuilder != null) SizedBox(width: 140.w),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, T item, int index) {
    final row = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        border: index < items.length - 1
            ? const Border(
                bottom: BorderSide(color: AppColors.primary20),
              )
            : null,
      ),
      child: Row(
        children: [
          // Leading widget (avatar, checkbox, etc.)
          if (leadingBuilder != null) ...[
            leadingBuilder!(item),
            SizedBox(width: 12.w),
          ],

          // Column Cells
          ...columns.map((column) {
            return Expanded(
              flex: column.flex,
              child: column.cellBuilder(item),
            );
          }),

          // Trailing widget (action buttons)
          if (trailingBuilder != null) trailingBuilder!(item),
        ],
      ),
    );

    // Wrap with InkWell if onRowTap is provided
    if (onRowTap != null) {
      return InkWell(
        onTap: () => onRowTap!(item),
        child: row,
      );
    }

    return row;
  }
}

/// Helper widget builders for common table elements
class TableWidgets {
  /// Build an avatar with first letter
  static Widget buildAvatar(
    String text, {
    Color? backgroundColor,
    Color? textColor,
  }) {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: backgroundColor ?? Colors.blue.shade100,
      child: Text(
        text.isNotEmpty ? text.substring(0, 1).toUpperCase() : '?',
        style: TextStyle(
          color: textColor ?? Colors.blue.shade700,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Build a two-line cell (title + subtitle)
  static Widget buildTwoLineCell(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryBackground,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }

  /// Build a simple text cell
  static Widget buildTextCell(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? cellStyle,
    );
  }

  /// Build a highlighted text cell
  static Widget buildHighlightedCell(
    String text, {
    Color? color,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      style: cellStyle.copyWith(
        color: color ?? AppColors.primary,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}
