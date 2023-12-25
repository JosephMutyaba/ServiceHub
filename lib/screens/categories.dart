import 'package:flutter/material.dart';
import 'package:myapp/screens/profile.dart';
import 'package:myapp/screens/vendors.dart';

import 'package:myapp/utils.dart';

import 'cart.dart';

class Scene extends StatelessWidget {
  const Scene({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories',
              style: safeGoogleFont(
                'SF Pro Display',
                fontSize: 34 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.2058823529 * ffem / fem,
                letterSpacing: 0.4099999964 * fem,
              )),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              // categoriesXiQ (33:699)
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfff6f5f5),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // autogroup8xegkja (9sMu9SNx7CSaNchM4q8Xeg)
                    padding: EdgeInsets.fromLTRB(
                        20 * fem, 27 * fem, 20 * fem, 0 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupyvwuiTS (9sMtWNcNpzfoLu3fFhYvWU)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          height: 211 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Vendor()));
                                  },
                                  child: Container(
                                    // itemcardpFa (100:1317)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 20 * fem, 0 * fem),
                                    width: 177 * fem,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // vegetablestWL (I100:1317;100:1313)
                                          left: 16 * fem,
                                          top: 150 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 91 * fem,
                                              height: 22 * fem,
                                              child: Text(
                                                'Plumbing',
                                                style: safeGoogleFont(
                                                  'Roboto',
                                                  fontSize: 18 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.1725 * ffem / fem,
                                                  color:
                                                      const Color(0xff2d0c57),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // mediaHHa (I100:1317;100:1315)
                                          left: 0 * fem,
                                          top: 0 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 177 * fem,
                                              height: 140 * fem,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffdbd8dd),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        8 * fem),
                                                    topRight: Radius.circular(
                                                        8 * fem),
                                                  ),
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                      '',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // cardborderKEG (I100:1317;100:1316)
                                          left: 0 * fem,
                                          top: 0 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 177 * fem,
                                              height: 211 * fem,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8 * fem),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffd8d0e3)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                // itemcardpRv (100:1361)
                                width: 177 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(8 * fem),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // fruitsjon (I100:1361;100:1313)
                                      left: 16 * fem,
                                      top: 150 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          // width: 50*fem,
                                          height: 22 * fem,
                                          child: Text(
                                            'Electrician',
                                            style: safeGoogleFont(
                                              'Roboto',
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1725 * ffem / fem,
                                              color: const Color(0xff2d0c57),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // media22C (I100:1361;100:1315)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 140 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xffdbd8dd),
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(8 * fem),
                                                topRight:
                                                    Radius.circular(8 * fem),
                                              ),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                  '',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // cardborderUun (I100:1361;100:1316)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 211 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8 * fem),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffd8d0e3)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // autogroupfbmibUc (9sMtickyYT79Zb17xgfbMi)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          height: 211 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // itemcarduVJ (100:1411)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 20 * fem, 0 * fem),
                                width: 177 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(8 * fem),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // breadQwr (I100:1411;100:1313)
                                      left: 16 * fem,
                                      top: 150 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          // width: 48*fem,
                                          height: 22 * fem,
                                          child: Text(
                                            'Mechanic',
                                            style: safeGoogleFont(
                                              'Roboto',
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1725 * ffem / fem,
                                              color: const Color(0xff2d0c57),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // mediaWEC (I100:1411;100:1315)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 140 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xffdbd8dd),
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(8 * fem),
                                                topRight:
                                                    Radius.circular(8 * fem),
                                              ),
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  '',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // cardbordermfv (I100:1411;100:1316)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 211 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8 * fem),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffd8d0e3)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // itemcardUKS (100:1412)
                                width: 177 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(8 * fem),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // sweetsymz (I100:1412;100:1313)
                                      left: 16 * fem,
                                      top: 150 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          // width: 60*fem,
                                          height: 22 * fem,
                                          child: Text(
                                            'Key Maker',
                                            style: safeGoogleFont(
                                              'Roboto',
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1725 * ffem / fem,
                                              color: const Color(0xff2d0c57),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // mediaFzQ (I100:1412;100:1315)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 140 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xffdbd8dd),
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(8 * fem),
                                                topRight:
                                                    Radius.circular(8 * fem),
                                              ),
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  '',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // cardborderM1r (I100:1412;100:1316)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 211 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8 * fem),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffd8d0e3)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // autogroupyfcuSoz (9sMtvXao855mQdBGyVYfcU)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          height: 211 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // itemcardBFn (100:1479)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 20 * fem, 0 * fem),
                                width: 177 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(8 * fem),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // pastaVGU (I100:1479;100:1313)
                                      left: 16 * fem,
                                      top: 150 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          // width: 47*fem,
                                          height: 22 * fem,
                                          child: Text(
                                            'Carpenter',
                                            style: safeGoogleFont(
                                              'Roboto',
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1725 * ffem / fem,
                                              color: const Color(0xff2d0c57),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // aHv (I100:1479;100:1314)
                                      left: 16 * fem,
                                      top: 180 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 22 * fem,
                                          height: 15 * fem,
                                          child: Text(
                                            '(43)',
                                            style: safeGoogleFont(
                                              'Roboto',
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: const Color(0xff9586a8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // mediafaG (I100:1479;100:1315)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 140 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xffdbd8dd),
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(8 * fem),
                                                topRight:
                                                    Radius.circular(8 * fem),
                                              ),
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  '',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // cardborder8ye (I100:1479;100:1316)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 211 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8 * fem),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffd8d0e3)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // itemcard3qi (100:1480)
                                width: 177 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(8 * fem),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // drinksBS8 (I100:1480;100:1313)
                                      left: 16 * fem,
                                      top: 150 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          // width: 52*fem,
                                          height: 22 * fem,
                                          child: Text(
                                            'Transport',
                                            style: safeGoogleFont(
                                              'Roboto',
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1725 * ffem / fem,
                                              color: const Color(0xff2d0c57),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // tLY (I100:1480;100:1314)
                                      left: 16 * fem,
                                      top: 180 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 22 * fem,
                                          height: 15 * fem,
                                          child: Text(
                                            '(43)',
                                            style: safeGoogleFont(
                                              'Roboto',
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: const Color(0xff9586a8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // mediaYvt (I100:1480;100:1315)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 140 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xffdbd8dd),
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(8 * fem),
                                                topRight:
                                                    Radius.circular(8 * fem),
                                              ),
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  '',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // cardborderQTJ (I100:1480;100:1316)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 177 * fem,
                                          height: 211 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8 * fem),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffd8d0e3)),
                                            ),
                                          ),
                                        ),
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
                  MaterialPageRoute(builder: (context) => const Profile()));
            }
          },
        ));
  }
}
