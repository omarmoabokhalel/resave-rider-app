import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resave_rider/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({super.key, required this.title, this.showBack = true, this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryDark,
      automaticallyImplyLeading: showBack,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: AppColors.textOnPrimary, fontSize: 25.sp),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
