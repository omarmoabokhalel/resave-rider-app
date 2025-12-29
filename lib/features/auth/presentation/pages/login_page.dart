import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../orders/presentation/pages/orders_page.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل دخول الرايدر')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // يمكنك اضافة Loading Indicator هنا اذا حبيت
            print('Loading...');
          }

          if (state is AuthSuccess) {
            print('Login Success, token: ${state.token}');
            // تنظيف الحقول
            emailController.clear();
            passwordController.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => OrdersPage()),
            );
          }

          if (state is AuthError) {
            print('Login Error: ${state.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'الإيميل',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('تسجيل الدخول'),
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('من فضلك املأ جميع الحقول'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return;
                    }

                    print('Login Event Sent');
                    context.read<AuthBloc>().add(
                          LoginRiderEvent(email, password),
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
