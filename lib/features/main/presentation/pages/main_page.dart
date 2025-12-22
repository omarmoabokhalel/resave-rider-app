import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/home/presentation/pages/home_page.dart';
import 'package:resave_rider/features/profile/presentation/pages/profile_page.dart';
import 'package:resave_rider/features/wallet/presentation/pages/wallet_page.dart';
import '../cubit/main_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainCubit(),
      child: BlocBuilder<MainCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: _pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<MainCubit>().changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF0E1623),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'المحفظة',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'الملف الشخصي',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final List<Widget> _pages = [HomePage(), WalletPage(), ProfilePage()];
