import 'package:flutter/material.dart';

import '../data/cart_item.dart';
import '../data/cart_model.dart';
import '../theme.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _coupon = TextEditingController();

  @override
  void dispose() {
    _coupon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListenableBuilder(
        listenable: cart,
        builder: (context, _) {
          final items = cart.items;
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
            children: [
              _header(),
              const SizedBox(height: 24),
              Text('My Order', style: poppins(22, weight: FontWeight.w600)),
              const SizedBox(height: 16),
              if (items.isEmpty)
                _emptyState()
              else ...[
                for (final item in items) _itemTile(item),
                _summaryCard(),
                const SizedBox(height: 28),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CheckoutScreen(items: cart.items),
                      ),
                    ),
                    child: Text('Finalize Order',
                        style: poppins(18, weight: FontWeight.w600)),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text('Cart', style: poppins(20, weight: FontWeight.w600)),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: widget.onBack,
              icon: const Icon(Icons.chevron_left,
                  color: AppColors.card, size: 32),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none,
                  color: Colors.white, size: 26),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: [
          const Icon(Icons.shopping_cart_outlined,
              color: AppColors.card, size: 56),
          const SizedBox(height: 16),
          Text('Your cart is empty',
              style: poppins(18, weight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('Add some coffee from the Home screen',
              style: poppins(12, weight: FontWeight.w300)),
        ],
      ),
    );
  }

  Widget _itemTile(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: ObjectKey(item),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => cart.remove(item),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
        ),
        child: Container(
          height: 78,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 84,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset('assets/images/${item.image}',
                      fit: BoxFit.contain),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: poppins(15, weight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text('\$${item.price}',
                        style: poppins(15,
                            weight: FontWeight.w600, color: AppColors.dark)),
                  ],
                ),
              ),
              _qtyButton(Icons.remove, () => cart.decrease(item)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('${item.qty}', style: poppins(14)),
              ),
              _qtyButton(Icons.add, () => cart.increase(item)),
              const SizedBox(width: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                        BorderSide(color: AppColors.dark, width: 1)),
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(8)),
                  ),
                  child: TextField(
                    controller: _coupon,
                    style: poppins(12, color: AppColors.dark),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      hintText: 'Enter Coupon Code here',
                      hintStyle: poppins(10, color: AppColors.dark),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {}, 
                child: Container(
                  height: 40,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.dark,
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(8)),
                  ),
                  child: Text('Apply', style: poppins(14)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _line('Sub-total', '\$${cart.subTotal}'),
          _line('Shipping', '\$${cart.shipping}'),
          _line('Total', '\$${cart.total}'),
        ],
      ),
    );
  }

  Widget _line(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(label, style: poppins(11, color: AppColors.dark)),
          const SizedBox(width: 6),
          const Expanded(
            child: SizedBox(
              height: 14,
              child: CustomPaint(painter: _DotsPainter()),
            ),
          ),
          const SizedBox(width: 6),
          Text(value,
              style: poppins(12, weight: FontWeight.w500, color: AppColors.dark)),
        ],
      ),
    );
  }
}

class _DotsPainter extends CustomPainter {
  const _DotsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.dark;
    for (double x = 0; x < size.width; x += 3) {
      canvas.drawCircle(Offset(x, size.height - 3), 0.6, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
