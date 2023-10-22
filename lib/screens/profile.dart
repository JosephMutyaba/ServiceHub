import 'package:flutter/material.dart';

import 'package:myapp/utils.dart';

import 'cart.dart';


class Profile extends StatelessWidget{
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
        title: Text('My Profile',

        style: safeGoogleFont (
        'SF Pro Display',
        fontSize: 34*ffem,
        fontWeight: FontWeight.w700,
        height: 1.2058823529*ffem/fem,
        letterSpacing: 0.4099999964*fem,)),
    backgroundColor: Colors.deepPurple,

    ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text('Name: John Doe'),
            ),
            ListTile(
              title: Text('Email: john.doe@example.com'),
            ),
            ListTile(
              title: Text('Phone: +1 (123) 456-7890'),
            ),
            // Add more user information as needed
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.deepPurple),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: Colors.deepPurple),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.deepPurple),
              label: 'Profile',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.deepPurple,
          onTap: (index) {
            if (index == 0) {
              Navigator.of(context).popUntil((route) => route.isFirst);            }
            else if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Cart()));
            }
            else if(index==2){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Profile()));
            }
          },
        )
    );
  }

}