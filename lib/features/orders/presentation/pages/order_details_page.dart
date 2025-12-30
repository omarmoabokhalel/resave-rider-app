import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';
import 'package:resave_rider/features/orders/presentation/pages/weighing_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/orders_model.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

  // دالة لعرض الصورة بحجم كبير
  void _showImageDialog(BuildContext context, String imageUrl, String itemName) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // زر الإغلاق
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            // الصورة
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      padding: EdgeInsets.all(40),
                      color: Colors.grey[800],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.error_outline, color: Colors.white, size: 60),
                          SizedBox(height: 16),
                          Text(
                            'فشل تحميل الصورة',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      padding: EdgeInsets.all(60),
                      color: Colors.grey[800],
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            // اسم العنصر
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                itemName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng location = LatLng(order.latitude ?? 0, order.longitude ?? 0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[700],
          centerTitle: true,
          title: Text(
            'تفاصيل الطلب #${order.id}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بطاقة الموقع
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.blue[700],
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'عنوان التسليم',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                order.address ?? 'لا يوجد عنوان',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.map, size: 20),
                        label: Text('فتح الموقع على الخريطة'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue[700],
                          side: BorderSide(color: Colors.blue[700]!),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          final url =
                              'https://www.google.com/maps/search/?api=1&query=${order.latitude},${order.longitude}';
                          launchUrl(Uri.parse(url));
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // عناصر الطلب مع الصور
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2,
                          color: Colors.blue[700],
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'عناصر الطلب',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${order.items.length} عنصر',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // قائمة العناصر مع الصور
                    ...order.items.map((item) {
                      final hasImage = item.image != null && item.image!.isNotEmpty;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            // الصورة أو الأيقونة
                            GestureDetector(
                              onTap: hasImage
                                  ? () => _showImageDialog(context, item.image!, item.itemName)
                                  : null,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: hasImage ? Colors.grey[200] : Colors.green[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border: hasImage
                                      ? Border.all(color: Colors.grey[300]!, width: 1)
                                      : null,
                                ),
                                child: hasImage
                                    ? Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(9),
                                            child: Image.network(
                                              item.image!,
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Center(
                                                  child: Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey[400],
                                                    size: 30,
                                                  ),
                                                );
                                              },
                                              loadingBuilder: (context, child, loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                      Colors.blue[700]!,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          // أيقونة التكبير
                                          Positioned(
                                            bottom: 4,
                                            left: 4,
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.6),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Icon(
                                                Icons.zoom_in,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Icon(
                                        Icons.recycling,
                                        color: Colors.green[700],
                                        size: 32,
                                      ),
                              ),
                            ),
                            SizedBox(width: 12),
                            
                            // التفاصيل
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.itemName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.scale,
                                        size: 14,
                                        color: Colors.grey[600],
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'الكمية المتوقعة: ${item.estimatedQuantity} كجم',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (hasImage) ...[
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          size: 14,
                                          color: Colors.green[600],
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'يوجد صورة توضيحية',
                                          style: TextStyle(
                                            color: Colors.green[600],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            
                            // سهم للعناصر التي لها صور
                            if (hasImage)
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey[400],
                                size: 16,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                icon: Icon(Icons.play_arrow, size: 24),
                label: Text(
                  'بدء الاستلام',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.read<OrdersBloc>().add(AcceptOrderEvent(order.id));

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
        ),
      ),
    );
  }
}