import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resave_rider/core/routes/app_router.dart';
import 'package:resave_rider/core/utils/validators.dart';
import 'package:resave_rider/core/widgets/custom_app_bar.dart';
import 'package:resave_rider/core/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'تسجيل الدخول',
        showBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: emailController,
                hint: 'ادخل بريدك الالكتروني',
                label: 'البريد الالكتروني',
                validator: (value) => Validators.email(value),
              ),
              20.h.verticalSpace,
              CustomTextField(
                controller: passwordController,
                hint: 'ادخل كلمة المرور',
                label: 'كلمة المرور',
                obscureText: true,

                validator: (value) => Validators.password(value),
              ),
              30.h.verticalSpace,
              CustomButton(
                text: "تسجيل الدخول",
                onPressed: () {
                  AppRouter.navigateTo(context, '/main');
                },
                isOutlined: false,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
