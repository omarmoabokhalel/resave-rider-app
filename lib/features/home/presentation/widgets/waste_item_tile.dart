import 'package:flutter/material.dart';

class WasteItemTile extends StatelessWidget {
  final String name;
  final String weight;

  const WasteItemTile({
    super.key,
    required this.name,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white)),
          Text(weight, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
