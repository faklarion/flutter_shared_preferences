import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  Future<void> _loadCurrentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('savedEmail') ?? '';
      passwordController.text = ''; // Biarkan password kosong demi keamanan
    });
  }

  Future<void> _saveChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Simpan email dan password baru ke SharedPreferences
    await prefs.setString('savedEmail', emailController.text);

    if (passwordController.text.isNotEmpty) {
      await prefs.setString('savedPassword', passwordController.text);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Perubahan berhasil disimpan!')),
    );

    Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menyimpan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration:
                  InputDecoration(labelText: 'Password (untuk mengubah)'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
