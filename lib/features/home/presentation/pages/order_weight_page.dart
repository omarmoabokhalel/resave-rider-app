import 'package:flutter/material.dart';
import 'package:resave_rider/core/widgets/custom_app_bar.dart';
import 'package:resave_rider/core/widgets/custom_button.dart';
import '../widgets/section_title.dart';

class OrderWeightPage extends StatelessWidget {
  const OrderWeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'الوزن والتأكيد'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle('تفاصيل الطلب'),

            _expectedWeight('بلاستيك', '2 كج'),
            _expectedWeight('ورق', '1 كج'),
            _expectedWeight('كرتون', '3 كج'),

            const SectionTitle('الوزن الفعلي لكل عنصر'),

            _weightField('الوزن الفعلي للبلاستيك (كج)'),
            _weightField('الوزن الفعلي للورق (كج)'),
            _weightField('الوزن الفعلي للكرتون (كج)'),

            const SectionTitle('تصوير المخلفات'),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt,color: Colors.white,),
              label: const Text('تصوير المخلفات',style: TextStyle(color: Colors.white),),
            ),

            const SizedBox(height: 8),
            const Text(
              'يجب إدخال الوزن بدقة',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            CustomButton(text: "تأكيد الاستلام", onPressed: (){

            })
          ],
        ),
      ),
    );
  }

  Widget _expectedWeight(String name, String weight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white)),
          Text(weight, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _weightField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
        ),
      ),
    );
  }
}
