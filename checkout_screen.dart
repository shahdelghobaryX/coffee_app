import 'package:flutter/material.dart';

import '../data/cart_item.dart';
import '../theme.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.items});

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _header(context),
              const SizedBox(height: 24),
              Text('Deliver Address',
                  style: poppins(18, weight: FontWeight.w500)),
              const SizedBox(height: 14),
              _addressRow(),
              const SizedBox(height: 32),
              Text('Product List', style: poppins(18, weight: FontWeight.w500)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: Colors.white12, height: 1),
                  itemBuilder: (_, i) => _productRow(items[i]),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment screen coming soon')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.card,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text('Continue Payment',
                      style: poppins(18,
                          weight: FontWeight.w600, color: AppColors.dark)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text('Checkout', style: poppins(20, weight: FontWeight.w600)),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.chevron_left,
                  color: AppColors.card, size: 32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addressRow() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.card,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.location_on_outlined,
              color: AppColors.dark, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Home', style: poppins(16, weight: FontWeight.w500)),
              Text('1910, wien stadt, At', style: poppins(10)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {}, 
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('Change',
                style: poppins(8, weight: FontWeight.w500, color: AppColors.dark)),
          ),
        ),
      ],
    );
  }

  Widget _productRow(CartItem item) {
    final qtyNote = item.qty > 1 ? '  ·  x${item.qty}' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 84,
            height: 84,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset('assets/images/${item.image}',
                fit: BoxFit.contain),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: poppins(16, weight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('${item.subtitle}$qtyNote', style: poppins(11)),
                const SizedBox(height: 6),
                Text('\$${item.price * item.qty}',
                    style: poppins(14, weight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
