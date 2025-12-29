import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/orders/data/models/orders_model.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';

class CompleteOrderPage extends StatelessWidget {
  final OrderModel order;

  const CompleteOrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إتمام الطلب')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warehouse, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'هل تم تسليم المخلفات للمخزن؟',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('تم التسليم'),
                onPressed: () {
                  context.read<OrdersBloc>().add(
                        CompleteOrderEvent(order.id),
                      );

                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
