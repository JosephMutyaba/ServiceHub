import 'package:flutter/material.dart';

import 'package:myapp/screens/item.dart';
import 'package:myapp/screens/profile.dart';
import 'package:myapp/utils.dart';

import 'cart.dart';

class Vendor extends StatelessWidget {
  final String title = 'Kibirige Martin';
  const Vendor({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.67;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Vendors',
            style: safeGoogleFont(
              'SF Pro Display',
              fontSize: 25,
              fontWeight: FontWeight.w700,
              height: 1.3666666667 * ffem / fem,
              letterSpacing: 0.4099999964 * fem,
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              // vegetablesLRW (33:697)
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfff6f5f5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Item()));
                    },
                    child: Container(
                      // itemrowviewZ6Y (33:458)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 8 * fem),
                      padding: EdgeInsets.fromLTRB(
                          20 * fem, 16 * fem, 20 * fem, 16 * fem),
                      width: double.infinity,
                      height: 160 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // mediaSAL (I33:458;31:1)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 20 * fem, 0 * fem),
                            width: 177 * fem,
                            height: 128 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8 * fem),
                              color: const Color(0xffdbd8dd),
                              image: const DecorationImage(
                                image: AssetImage(
                                  '',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            // autogroupbewaJyE (9sMrhFxrhtGJZt6vD2bEwA)
                            width: 177 * fem,
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // bostonlettucemrp (I33:458;31:2)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 15 * fem, 0 * fem, 5 * fem),
                                  child: Text(
                                    'Kibirige Martin\n',
                                    style: safeGoogleFont(
                                      'SF Pro Text',
                                      fontSize: 27 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2222222222 * ffem / fem,
                                      letterSpacing: -0.4099999964 * fem,
                                      color: const Color(0xff2d0c57),
                                    ),
                                  ),
                                ),
                                Container(
                                  // price4b2 (I33:458;102:5201)
                                  margin: EdgeInsets.fromLTRB(
                                      1 * fem, 0 * fem, 52.5 * fem, 15 * fem),
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // zUg (I33:458;56:15970)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 2 * fem, 0 * fem),
                                        child: Text(
                                          'Labour: UGX 20,000',
                                          style: safeGoogleFont(
                                            'SF Pro Text',
                                            fontSize: 22 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1 * ffem / fem,
                                            letterSpacing: -0.4099999964 * fem,
                                            color: const Color(0xff2d0c57),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // autogroupzpzaCak (9sMrn6A9AVwtypvqkazPZA)
                                  margin: EdgeInsets.fromLTRB(
                                      1 * fem, 0 * fem, 11.5 * fem, 0 * fem),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.favorite_border)),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.shopping_cart_outlined),
                                          label: const Text('Add'))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // itemrowviewkkg (33:456)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                    padding: EdgeInsets.fromLTRB(
                        20 * fem, 16 * fem, 20 * fem, 16 * fem),
                    width: double.infinity,
                    height: 160 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // mediaTQC (I33:456;31:1)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 20 * fem, 0 * fem),
                          width: 177 * fem,
                          height: 128 * fem,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(6.2169289589 * fem),
                            color: const Color(0xffdbd8dd),
                            image: const DecorationImage(
                              image: AssetImage(
                                '',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          // autogrouph8jiYgY (9sMrDgvTmzdMBEDRdvh8ji)
                          width: 177 * fem,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // bostonlettucemrp (I33:458;31:2)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 15 * fem, 0 * fem, 5 * fem),
                                child: Text(
                                  'Kibirige Martin\n',
                                  style: safeGoogleFont(
                                    'SF Pro Text',
                                    fontSize: 27 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2222222222 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    color: const Color(0xff2d0c57),
                                  ),
                                ),
                              ),
                              Container(
                                // price4b2 (I33:458;102:5201)
                                margin: EdgeInsets.fromLTRB(
                                    1 * fem, 0 * fem, 52.5 * fem, 15 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // zUg (I33:458;56:15970)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 2 * fem, 0 * fem),
                                      child: Text(
                                        'Labour: UGX 20,000',
                                        style: safeGoogleFont(
                                          'SF Pro Text',
                                          fontSize: 22 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1 * ffem / fem,
                                          letterSpacing: -0.4099999964 * fem,
                                          color: const Color(0xff2d0c57),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // autogroupzpzaCak (9sMrn6A9AVwtypvqkazPZA)
                                margin: EdgeInsets.fromLTRB(
                                    1 * fem, 0 * fem, 11.5 * fem, 0 * fem),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon:
                                            const Icon(Icons.favorite_border)),
                                    ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.shopping_cart_outlined),
                                        label: const Text('Add'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
              Navigator.of(context).popUntil((route) => route.isFirst);
            } else if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Cart()));
            } else if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            }
          },
        ));
  }
}
