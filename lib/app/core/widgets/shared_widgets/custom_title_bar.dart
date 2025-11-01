import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:engaz_task/app/core/extensions/theme_extensions.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.primary,
      height: 50.h,
      child: Row(
        children: [
          Expanded(
            child: MoveWindow(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child:
                        const Text('Hi Amr'),
                  ),
                  Text(
                    'engaz_task',
                    style: context.textTheme.displaySmall!.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const WindowButtons(),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final baseButtonColors = WindowButtonColors(
      iconNormal: Colors.white,
      mouseOver: const Color(0xFFE81123),
      // Windows Red
      mouseDown: const Color(0xFFD50F25),
      iconMouseOver: context.colorScheme.primary,
      iconMouseDown: context.colorScheme.primary,
    );

    final closeButtonColors = WindowButtonColors(
      iconNormal: Colors.white,
      mouseOver: AppColors.danger.withValues(alpha: 0.8),
      mouseDown: AppColors.danger,
      iconMouseOver: Colors.white,
      iconMouseDown: Colors.white,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: baseButtonColors),
        MaximizeWindowButton(colors: baseButtonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
