import 'package:flutter/material.dart';
import 'package:resave_rider/core/routes/app_router.dart';
import 'package:resave_rider/core/theme/app_colors.dart';
import 'package:resave_rider/core/widgets/custom_app_bar.dart';
import 'package:resave_rider/core/widgets/widgets.dart';
import '../widgets/section_title.dart';
import '../widgets/info_text.dart';
import '../widgets/waste_item_tile.dart';
import 'order_weight_page.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'تفاصيل الطلب'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InfoText(title: 'العميل', value: 'السيد أحمد'),
            const InfoText(title: 'المدينة', value: 'القاهرة'),

            const SectionTitle('عنوان العميل'),
            const InfoText(
              title: '',
              value: 'شارع النيل الأبيض – القاهرة',
            ),

            // Map placeholder
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Text('Map')),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('فتح الموقع على الخريطة'),
              ),
            ),

            const SectionTitle('المخلفات المطلوبة'),

            const WasteItemTile(name: 'بلاستيك', weight: '2 كجم'),
            const WasteItemTile(name: 'ورق', weight: '1 كجم'),
            const WasteItemTile(name: 'معادن', weight: '3 كجم'),

            const SizedBox(height: 24),

            CustomButton(text: 'بدا الاستلام',color:AppColors.textPrimary , onPressed: (){
              AppRouter.navigateTo(context, '/order-weight');
            })
          ],
        ),
      ),
    );
  }
}
