import 'package:flutter/material.dart';

class OrderStatusPage extends StatelessWidget {
  final String status; // مثال: draft, pending, assigned, collected, delivered

  const OrderStatusPage({super.key, required this.status});

  static const steps = [
    'تم قبول الطلب',
    'في الطريق',
    'تم الاستلام',
    'تم التسليم'
  ];

  @override
  Widget build(BuildContext context) {
    int currentStep = 0;
    switch (status) {
      case 'pending':
        currentStep = 0;
        break;
      case 'assigned':
        currentStep = 1;
        break;
      case 'collected':
        currentStep = 2;
        break;
      case 'delivered':
        currentStep = 3;
        break;
      default:
        currentStep = 0;
    }

    return Scaffold(
      appBar: AppBar(title: Text('حالة الطلب')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: steps.asMap().entries.map((entry) {
            int idx = entry.key;
            String step = entry.value;
            bool completed = idx <= currentStep;

            return ListTile(
              leading: Icon(
                completed ? Icons.check_circle : Icons.radio_button_unchecked,
                color: completed ? Colors.green : Colors.grey,
              ),
              title: Text(step),
            );
          }).toList(),
        ),
      ),
    );
  }
}
