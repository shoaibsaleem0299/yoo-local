import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';

class ItemCounter extends StatefulWidget {
  final int initialQuantity;

  const ItemCounter({
    Key? key,
    required this.initialQuantity,
  }) : super(key: key);

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            color: AppColors.primaryColor,
            size: 26,
          ),
          onPressed: _decreaseQuantity,
        ),
        Text(
          quantity.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle,
            color: AppColors.primaryColor,
            size: 26,
          ),
          onPressed: _increaseQuantity,
        ),
      ],
    );
  }
}
