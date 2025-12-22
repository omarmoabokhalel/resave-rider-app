import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String title;
  final String value;

  const InfoText({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
