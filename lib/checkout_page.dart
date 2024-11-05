import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'receipt_page.dart'; // Import the ReceiptPage

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cart;

  CheckoutPage({required this.cart});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _paymentController = TextEditingController();
  double _change = 0.0;

  @override
  void dispose() {
    _paymentController.dispose();
    super.dispose();
  }

  double _calculateTotal() {
    return widget.cart
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _submitOrder() {
    final total = _calculateTotal();
    final customerMoney = double.tryParse(_paymentController.text) ?? 0;

    if (customerMoney < total) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Uang pelanggan tidak cukup untuk membayar.')),
      );
      return;
    }

    setState(() {
      _change = customerMoney - total; // Calculate and set the change
    });

    // Navigate to the ReceiptPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPage(
          cart: widget.cart,
          total: total,
          customerMoney: customerMoney,
          change: _change,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {
                  final item = widget.cart[index];
                  return ListTile(
                    title: Text('${item.name} x${item.quantity}'),
                    subtitle: Text('Harga: Rp ${item.price * item.quantity}'),
                  );
                },
              ),
            ),
            TextField(
              controller: _paymentController,
              decoration: InputDecoration(labelText: 'Uang Pelanggan'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Text(
              'Total: Rp ${_calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitOrder,
                child: Text('Submit Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
