import 'package:flutter/material.dart';

import '../data/cart_model.dart';
import '../theme.dart';

typedef _Product = ({String name, int price, String image, String subtitle});

const _products = <_Product>[
  (name: 'Arabica', price: 18, image: 'Arabica_coffee.png', subtitle: 'With Milk'),
  (name: 'Robusta', price: 20, image: 'Robusta_coffee.png', subtitle: 'With Milk'),
  (name: 'Excelsa', price: 15, image: 'Excelsa_coffee.png', subtitle: 'With Water'),
  (name: 'Liberica', price: 12, image: 'Liberica_coffee.png', subtitle: 'With water'),
  (name: 'Cirtus', price: 12, image: 'Cirtus.png', subtitle: 'With Lemon'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _addToCart(BuildContext context, _Product p) {
    cart.add(name: p.name, image: p.image, price: p.price, subtitle: p.subtitle);

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('${p.name} added to cart',
            style: poppins(13, color: AppColors.dark)),
        duration: const Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.card,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const _Header(),
            const SizedBox(height: 28),
            const _DiscountBanner(),
            const SizedBox(height: 28),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 110),
                itemCount: _products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.92,
                ),
                itemBuilder: (ctx, i) => _ProductCard(
                  product: _products[i],
                  onAdd: () => _addToCart(ctx, _products[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/Profile.png'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shahzaib', style: poppins(22, weight: FontWeight.w600)),
              Text('Good Morning!', style: poppins(16, weight: FontWeight.w300)),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.white, size: 26),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none,
              color: Colors.white, size: 26),
        ),
      ],
    );
  }
}

class _DiscountBanner extends StatelessWidget {
  const _DiscountBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.banner,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'Get 20% Discount\nOn your First Order!',
                style: poppins(16, weight: FontWeight.w600, height: 1.4),
              ),
            ),
          ),
          Image.asset(
            'assets/images/Discount_coffee.png',
            width: 130,
            height: 124,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onAdd});

  final _Product product;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/${product.image}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(product.name,
                      style: poppins(16, weight: FontWeight.w600)),
                  const Spacer(),
                  Text(
                    '\$${product.price}',
                    style: poppins(15,
                        weight: FontWeight.w600, color: AppColors.dark),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Lorem ipsum dolor sit\namet cons',
                style: poppins(9, color: AppColors.dark),
              ),
            ],
          ),
          
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onAdd,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: AppColors.dark,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
