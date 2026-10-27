class CartItem {
  CartItem(this.name, this.image, this.price, this.subtitle);

  final String name;
  final String image;
  final int price;
  final String subtitle; // e.g. "With Milk"
  int qty = 1;
}