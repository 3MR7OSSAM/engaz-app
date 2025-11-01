// import 'package:flutter/material.dart';
// import 'package:engaz_task/core/constants/app_colors.dart';

// extension BottomAlertExtension on BuildContext {
//   void showBottomAlert(String message, {int duration = 500}) {
//     showModalBottomSheet<void>(
//       context: this,
//       backgroundColor: Colors.transparent,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.all(8),
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             padding: const EdgeInsets.all(16),
//             child: Text(
//               message,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.greenLight,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
