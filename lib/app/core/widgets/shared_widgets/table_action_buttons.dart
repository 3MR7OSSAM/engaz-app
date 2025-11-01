import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:engaz_task/app/core/l10n/l10n.dart';

class TableActionButtons extends StatelessWidget {
  const TableActionButtons({
    super.key,
    this.onView,
    this.onEdit,
    this.onDelete,
    this.onPrint,
  });
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onPrint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (onView != null)
            _ActionIcon(
              icon: FontAwesomeIcons.eye,
              color: AppColors.primary,
              tooltip: context.l10n.viewDetails,
              onPressed: onView!,
            ),
          if (onEdit != null)
            _ActionIcon(
              icon: FontAwesomeIcons.penToSquare,
              color: AppColors.warning.withValues(alpha: 0.7),
              tooltip: context.l10n.edit,
              onPressed: onEdit!,
            ),
          if (onDelete != null)
            _ActionIcon(
              icon: FontAwesomeIcons.trash,
              color: AppColors.danger.withValues(alpha: 0.7),
              tooltip: context.l10n.delete,
              onPressed: onDelete!,
            ),
          if (onPrint != null)
            _ActionIcon(
              icon: FontAwesomeIcons.print,
              color: AppColors.success.withValues(alpha: 0.7),
              tooltip: context.l10n.print,
              onPressed: onPrint!,
            ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        icon,
        size: 18.sp,
        color: color,
      ),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
