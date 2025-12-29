import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resave_rider/features/orders/presentation/pages/weighing_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/orders_model.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final LatLng location = LatLng(order.latitude ?? 0, order.longitude ?? 0);

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الطلب #${order.id}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🧍 بيانات العميل
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'بيانات الطلب',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(order.address ?? 'لا يوجد عنوان'),
              subtitle: Text('العنوان'),
            ),

            /// 🗺️ الخريطة
            // Container(
            //   height: 200,
            //   margin: const EdgeInsets.symmetric(horizontal: 16),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(12),
            //     child: GoogleMap(
            //       initialCameraPosition: CameraPosition(
            //         target: location,
            //         zoom: 15,
            //       ),
            //       markers: {
            //         Marker(
            //           markerId: MarkerId('order_location'),
            //           position: location,
            //         ),
            //       },
            //       zoomControlsEnabled: false,
            //       myLocationButtonEnabled: false,
            //     ),
            //   ),
            // ),

            /// 🔗 فتح الموقع على Google Maps
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: Icon(Icons.map),
                label: Text('فتح الموقع على الخريطة'),
                onPressed: () {
                  final url =
                      'https://www.google.com/maps/search/?api=1&query=${order.latitude},${order.longitude}';
                  launchUrl(Uri.parse(url));
                },
              ),
            ),

            Divider(),

            /// 📦 عناصر الطلب
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'عناصر الطلب',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return ListTile(
                  leading: Icon(Icons.recycling),
                  title: Text(item.itemName),
                  subtitle: Text(
                    'الكمية المتوقعة: ${item.estimatedQuantity}',
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            /// ▶️ بدء الاستلام
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text(
                    'بدء الاستلام',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WeighingPage(order: order),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
