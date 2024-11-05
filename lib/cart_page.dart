import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cart;
  final Function(List<CartItem>) onCartUpdated; // Callback for cart updates

  CartPage({required this.cart, required this.onCartUpdated});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double _calculateTotal() {
    return widget.cart
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _removeFromCart(CartItem item) {
    setState(() {
      widget.cart.remove(item);
      widget.onCartUpdated(widget.cart); // Notify the cart update
    });
  }

  void _updateQuantity(CartItem item, int quantity) {
    setState(() {
      item.quantity = quantity;
      widget.onCartUpdated(widget.cart); // Notify the cart update
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: widget.cart.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.asset(
                            item.image,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.name),
                          subtitle: Text(
                            'Harga: Rp ${item.price}\nJumlah: ${item.quantity}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (item.quantity > 1) {
                                    _updateQuantity(item, item.quantity - 1);
                                  } else {
                                    _removeFromCart(item);
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _updateQuantity(item, item.quantity + 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total: Rp ${_calculateTotal().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CheckoutPage(cart: widget.cart),
                            ),
                          );
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
