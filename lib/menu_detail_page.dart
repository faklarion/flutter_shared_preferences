import 'package:flutter/material.dart';

class MenuDetailPage extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final double price;

  MenuDetailPage({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gambar Menu
            Image.asset(
              image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),

            // Nama Menu
            Text(
              name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Deskripsi Menu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),

            // Harga Menu
            Text(
              'Harga: Rp ${price.toString()}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
