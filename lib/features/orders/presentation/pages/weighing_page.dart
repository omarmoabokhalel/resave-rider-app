import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';

import '../../data/models/orders_model.dart';


class WeighingPage extends StatefulWidget {
  final OrderModel order;

  const WeighingPage({super.key, required this.order});

  @override
  State<WeighingPage> createState() => _WeighingPageState();
}

class _WeighingPageState extends State<WeighingPage> {
  final Map<int, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.order.items) {
      controllers[item.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void submitWeights() {
    final items = <Map<String, dynamic>>[];

    controllers.forEach((orderItemId, controller) {
      if (controller.text.isNotEmpty) {
        items.add({
          'order_item_id': orderItemId,
          'actual_quantity': double.parse(controller.text),
        });
      }
    });

    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('من فضلك أدخل وزن عنصر واحد على الأقل')),
      );
      return;
    }

    context.read<OrdersBloc>().add(
          UpdateWeightEvent(widget.order.id, items),
        );

    Navigator.pop(context); // رجوع لصفحة الطلبات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تأكيد الاستلام'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ⚠️ تنبيه
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'يرجى إدخال الوزن بدقة، سيتم حساب النقاط بناءً عليه',
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            /// 📦 العناصر
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.items.length,
                itemBuilder: (context, index) {
                  final item = widget.order.items[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.itemName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'الكمية المتوقعة: ${item.estimatedQuantity}',
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: controllers[item.id],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'الوزن الفعلي',
                              suffixText: 'كجم',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// ✅ تأكيد
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                ),
                child: Text(
                  'تأكيد الاستلام',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: submitWeights,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
