import 'package:flutter/foundation.dart';

import 'cart_item.dart';


class CartModel extends ChangeNotifier {
  CartModel._();
  static final CartModel instance = CartModel._();

  static const int shippingFee = 6;

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  bool get isEmpty => _items.isEmpty;

  
  int get itemCount => _items.fold(0, (sum, i) => sum + i.qty);

  int get subTotal => _items.fold(0, (sum, i) => sum + i.price * i.qty);
  int get shipping => _items.isEmpty ? 0 : shippingFee;
  int get total => subTotal + shipping;

  
  void add({
    required String name,
    required String image,
    required int price,
    required String subtitle,
  }) {
    final index = _items.indexWhere((i) => i.name == name);
    if (index >= 0) {
      _items[index].qty++;
    } else {
      _items.add(CartItem(name, image, price, subtitle));
    }
    notifyListeners();
  }

  void increase(CartItem item) {
    item.qty++;
    notifyListeners();
  }

  /// Lowers the quantity; at 1 it removes the item.
  void decrease(CartItem item) {
    if (item.qty > 1) {
      item.qty--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void remove(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}


final cart = CartModel.instance;