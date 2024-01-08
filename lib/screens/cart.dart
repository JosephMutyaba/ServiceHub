import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth/auth_page.dart';
import 'package:myapp/utils.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: safeGoogleFont(
            'SF Pro Display',
            fontSize: 34 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.2058823529 * ffem / fem,
            letterSpacing: 0.4099999964 * fem,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
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
            child: ListView(
              children: <Widget>[
                CartItem(title: 'Item 1', price: 10.99),
                CartItem(title: 'Item 2', price: 19.99),
                // Add more CartItems as needed
              ],
            ),
          ),
          BottomAppBar(
            child: ListTile(
              title: const Text('Total: \$30.98'), // Calculate the total price
              trailing: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const CheckOut()));
                  // // Implement checkout functionality
                },
                child: const Text('Checkout'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavbar(context, 3),
    );
  }
}

class CartItem extends StatelessWidget {
  final String title;
  final double price;

  CartItem({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('Price: \$${price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: const Icon(Icons.remove_shopping_cart),
        onPressed: () {
          // Implement item removal from the cart
        },
      ),
    );
  }
}
