import 'package:flutter/material.dart';
import 'cart_item.dart';

class ReceiptPage extends StatelessWidget {
  final List<CartItem> cart;
  final double total;
  final double customerMoney;
  final double change;

  ReceiptPage({
    required this.cart,
    required this.total,
    required this.customerMoney,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nota Pembelian',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Daftar Pesanan:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return ListTile(
                    title: Text('${item.name} x${item.quantity}'),
                    subtitle: Text('Harga: Rp ${item.price * item.quantity}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text('Total: Rp ${total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
            Text('Uang Pelanggan: Rp ${customerMoney.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
            Text('Kembalian: Rp ${change.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                      context,
                      (route) =>
                          route.isFirst); // Navigate back to the home page
                },
                child: Text('Kembali ke Beranda'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
