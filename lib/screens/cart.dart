import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth/auth_page.dart';
import 'package:myapp/utils.dart';

class Cart extends StatelessWidget {
  final List<Map<String, dynamic>> requestList;

  const Cart({super.key, required this.requestList});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sent Requests',
          style: safeGoogleFont(
            'SF Pro Display',
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w500,
            height: 1.2058823529 * ffem / fem,
            letterSpacing: 0.4099999964 * fem,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade100,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: requestList.length,
              itemBuilder: (context, index) {
                return CartItem(
                  title: requestList[index]['description'] ?? '',
                  price: requestList[index]['budget'] ?? 0.0,
                );
              },
          ),
          )],
      ),
      bottomNavigationBar: buildFutureBuilder(context),
    );
  }
}


class CartItem extends StatelessWidget {
  final String title;
  final double price;

  const CartItem({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('Price: UGX ${price.toStringAsFixed(0)}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Implement item removal from the cart

        },
      ),
    );
  }
}
