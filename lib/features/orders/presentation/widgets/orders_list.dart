import 'package:flutter/material.dart';
import 'package:resave_rider/features/orders/data/models/orders_model.dart';
import 'package:resave_rider/features/orders/presentation/pages/order_details_page.dart';
import 'package:resave_rider/features/orders/presentation/pages/weighing_page.dart';

class OrdersList extends StatelessWidget {
  final List<OrderModel> orders;
  final bool isMine;

  const OrdersList({
    super.key,
    required this.orders,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text('لا يوجد طلبات'),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return Card(
          child: ListTile(
            title: Text('طلب #${order.id}'),
            subtitle: Text('الحالة: ${order.status}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              if (isMine) {
                // لو الرايدر أخده قبل كده
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        WeighingPage(order: order),
                  ),
                );
              } else {
                // لسه متاح
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        OrderDetailsPage(order: order),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
