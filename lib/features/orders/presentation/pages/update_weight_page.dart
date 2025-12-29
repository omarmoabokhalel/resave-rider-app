import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/orders/data/models/orders_model.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';


class UpdateWeightPage extends StatefulWidget {
  final OrderModel order;

  const UpdateWeightPage({required this.order});

  @override
  State<UpdateWeightPage> createState() => _UpdateWeightPageState();
}

class _UpdateWeightPageState extends State<UpdateWeightPage> {
  final Map<int, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.order.items) {
      controllers[item.id] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الوزن')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: widget.order.items.map((item) {
                return Card(
                  margin: EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.itemName,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        TextField(
                          controller: controllers[item.id],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'الوزن الفعلي (كجم)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('تأكيد الاستلام'),
              onPressed: () {
                final items = widget.order.items.map((item) {
                  return {
                    'order_item_id': item.id,
                    'actual_quantity':
                        double.parse(controllers[item.id]!.text),
                  };
                }).toList();

                context.read<OrdersBloc>().add(
                      UpdateWeightEvent(widget.order.id, items),
                    );

                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
