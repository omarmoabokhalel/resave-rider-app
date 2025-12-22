import 'package:flutter/material.dart';
import 'package:resave_rider/features/home/presentation/pages/home_page.dart';
import 'package:resave_rider/features/home/presentation/pages/order_details_page.dart';
import 'package:resave_rider/features/home/presentation/pages/order_weight_page.dart';
import 'package:resave_rider/features/login/presentation/pages/login_page.dart';
import 'package:resave_rider/features/main/presentation/pages/main_page.dart';
import 'package:resave_rider/features/profile/presentation/pages/profile_page.dart';
import 'package:resave_rider/features/wallet/presentation/pages/wallet_page.dart';
import 'routes.dart';


/// Application Router
class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return _buildRoute(const HomePage(), settings);
      case Routes.login:
        return _buildRoute(const LoginPage(), settings);
      case Routes.wallet:
        return _buildRoute(const WalletPage(), settings);
      case Routes.profile:
        return _buildRoute(const ProfilePage(), settings);
      case Routes.main:
        return _buildRoute(const MainPage(), settings);
      case Routes.orderDetails:
        return _buildRoute(const OrderDetailsPage(), settings);
      case Routes.orderWeight:
        return _buildRoute(const OrderWeightPage(), settings);
      default:
        return _buildRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
        );
    }
  }

  static PageRouteBuilder _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static void navigateTo(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void navigateAndReplace(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void navigateAndRemoveUntil(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
