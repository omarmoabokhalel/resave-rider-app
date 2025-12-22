import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String address;
  final String status;
  final String distance;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.address,
    required this.status,
    required this.distance,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2233),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلب #$orderId',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Address
            Text(
              address,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 12),

            // Distance
            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.blue),
                const SizedBox(width: 4),
                Text(
                  distance,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
