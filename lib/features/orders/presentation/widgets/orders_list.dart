import 'package:flutter/material.dart';
import 'package:resave_rider/features/orders/data/models/orders_model.dart';
import 'package:resave_rider/features/orders/presentation/pages/complete_order_page.dart';
import 'package:resave_rider/features/orders/presentation/pages/order_details_page.dart';
import 'package:resave_rider/features/orders/presentation/pages/weighing_page.dart';

class OrdersList extends StatelessWidget {
  final List<OrderModel> orders;
  final bool isMine;

  const OrdersList({super.key, required this.orders, required this.isMine});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(child: Text('لا يوجد طلبات'));
    }

    return ListView.builder(

      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Card(
          
            child: ListTile(
              
              title: Text('طلب #${order.id}'),
              subtitle: Text('الحالة: ${order.status}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                if (order.status == 'pending') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailsPage(order: order),
                    ),
                  );
                } else if (order.status == 'assigned') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailsPage(order: order),
                    ),
                  );
                } else if (order.status == 'collected') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CompleteOrderPage(order: order),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
