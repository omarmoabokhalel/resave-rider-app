import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resave_rider/core/widgets/custom_app_bar.dart';
import 'package:resave_rider/core/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 24.sp)),
      ),
    );
  }
}
