import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveCancelButtons extends StatelessWidget {

  const SaveCancelButtons({
    super.key,
    this.onCancel,
    this.onSave,
    this.isSaving = false,
    this.isEditing = false,
    this.cancelText = 'Cancel',
    this.saveText = 'Save',
    this.primaryColor = const Color(0xFF1A202C),
    this.cancelBorderColor = const Color(0x331A202C),
    this.cancelTextColor = const Color(0xFF718096),
  });
  final VoidCallback? onCancel;
  final VoidCallback? onSave;
  final bool isSaving;
  final bool isEditing;
  final String cancelText;
  final String saveText;
  final Color primaryColor;
  final Color cancelBorderColor;
  final Color cancelTextColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Cancel Button
        TextButton(
          onPressed: isSaving ? null : onCancel,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(color: cancelBorderColor),
            ),
          ),
          child: Text(
            cancelText,
            style: TextStyle(
              fontSize: 14.sp,
              color: cancelTextColor,
            ),
          ),
        ),
        SizedBox(width: 12.w),

        // Save / Update Button
        ElevatedButton(
          onPressed: isSaving ? null : onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            disabledBackgroundColor: Colors.grey.shade300,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: isSaving
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  isEditing ? saveText.replaceAll('Save', 'Update') : saveText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }
}
