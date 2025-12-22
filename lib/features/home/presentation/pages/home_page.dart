import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resave_rider/core/routes/app_router.dart';
import 'package:resave_rider/core/theme/app_colors.dart';
import 'package:resave_rider/core/widgets/custom_app_bar.dart';
import 'package:resave_rider/features/home/presentation/widgets/order_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildOrdersList(String status) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return OrderCard(
          orderId: '${index + 1}',
          address: 'القاهرة - مدينة نصر',
          status: status,
          distance: '3.2 كم',
          onTap: () {
            AppRouter.navigateTo(context, '/order-details');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.primaryDark,
        appBar: CustomAppBar(title: "الطلبات المتاحة", showBack: false),
        body: Column(
          children: [
            SizedBox(height: 10.h),
            const TabBar(
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              isScrollable: false,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 3, color: Colors.blue),
              ),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "الطلبات المتاحة"),
                Tab(text: "الطلبات الجارية"),
                Tab(text: "الطلبات المكتملة"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildOrdersList("متاحة"),
                  _buildOrdersList("جارية"),
                  _buildOrdersList("مكتملة"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
