import 'package:flutter/material.dart';

import 'package:myapp/utils.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit / Debit card',
            style: safeGoogleFont(
              'SF Pro Display',
              fontSize: 30 * ffem,
              fontWeight: FontWeight.w700,
              height: 1.3666666667 * ffem / fem,
            )),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            // paymentDgC (33:701)
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xfff6f5f5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // cardzyn (95:36)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 25 * fem, 0 * fem, 24 * fem),
                  width: 374 * fem,
                  height: 240 * fem,
                  child: Image.asset(
                    'assets/screens/images/card.png',
                    width: 374 * fem,
                    height: 240 * fem,
                  ),
                ),
                SizedBox(
                  // takeaphotoiconVvY (116:2204)
                  width: 34 * fem,
                  height: 29 * fem,
                  child: Image.asset(
                    'assets/screens/images/take-a-photo-icon.png',
                    width: 34 * fem,
                    height: 29 * fem,
                  ),
                ),
                Container(
                  // autogroup4klqdG4 (9sMvjj4WXe6wn44qwi4kLQ)
                  padding: EdgeInsets.fromLTRB(
                      20 * fem, 13 * fem, 20 * fem, 65 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // textfieldjpt (102:5591)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 23 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // hintU1n (I102:5591;121:1003)
                              margin: EdgeInsets.fromLTRB(
                                  14 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: 77 * fem,
                              height: 22 * fem,
                              child: Center(
                                child: Text(
                                  'Name on card',
                                  style: safeGoogleFont(
                                    'SF Pro Text',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5714285714 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    color: const Color(0xff9586a8),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // autogroupvefawRA (9sMvvtQaZ8YRHNjZecvEFa)
                              padding: EdgeInsets.fromLTRB(
                                  13 * fem, 13 * fem, 13 * fem, 13 * fem),
                              width: double.infinity,
                              height: 48 * fem,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffd8d0e3)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(8 * fem),
                              ),
                              child: Container(
                                // text3DJ (I102:5591;121:970)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 237 * fem, 0 * fem),
                                width: 111 * fem,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Alexandra Smith',
                                    style: safeGoogleFont(
                                      'SF Pro Text',
                                      fontSize: 17 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2941176471 * ffem / fem,
                                      letterSpacing: -0.4099999964 * fem,
                                      color: const Color(0xff2d0c57),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // textfieldJuv (102:5622)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 23 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // hintFKN (I102:5622;121:1003)
                              margin: EdgeInsets.fromLTRB(
                                  14 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: 73 * fem,
                              height: 22 * fem,
                              child: Center(
                                child: Text(
                                  'Card number',
                                  style: safeGoogleFont(
                                    'SF Pro Text',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5714285714 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    color: const Color(0xff9586a8),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // autogroup6wit8PA (9sMw7oG4jF8r1TZoau6Wit)
                              padding: EdgeInsets.fromLTRB(
                                  13 * fem, 13 * fem, 16.65 * fem, 13 * fem),
                              width: double.infinity,
                              height: 48 * fem,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffd8d0e3)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(8 * fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // textdKv (I102:5622;121:970)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 164 * ffem, 0 * fem),
                                    width: 147 * fem,
                                    height: double.infinity,
                                    child: Center(
                                      child: Text(
                                        '4747  4747  4747  4747',
                                        style: safeGoogleFont(
                                          'SF Pro Text',
                                          fontSize: 17 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2941176471 * ffem / fem,
                                          letterSpacing: -0.4099999964 * fem,
                                          color: const Color(0xff2d0c57),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // mcsymbol1HvG (102:6189)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 2 * fem),
                                    width: 32.35 * fem,
                                    height: 20 * fem,
                                    child: Image.asset(
                                      'assets/screens/images/mcsymbol-1.png',
                                      width: 32.35 * fem,
                                      height: 20 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // autogroupqqdvauN (9sMvKEmK6jEFLg9vXjqQdv)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 55 * fem),
                        width: double.infinity,
                        height: 69 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // textfieldhUC (102:5934)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 22 * fem, 0 * fem),
                              width: 176 * fem,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // containerRf6 (I102:5934;102:5481)
                                    left: 0 * fem,
                                    top: 21 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 176 * fem,
                                        height: 48 * fem,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8 * fem),
                                            border: Border.all(
                                                color: const Color(0xffd8d0e3)),
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // textWgY (I102:5934;121:970)
                                    left: 13 * fem,
                                    top: 35 * fem,
                                    child: SizedBox(
                                      width: 38 * fem,
                                      height: 22 * fem,
                                      child: Center(
                                        child: Text(
                                          '07/21',
                                          style: safeGoogleFont(
                                            'SF Pro Text',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2941176471 * ffem / fem,
                                            letterSpacing: -0.4099999964 * fem,
                                            color: const Color(0xff2d0c57),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // hinto9r (I102:5934;121:1003)
                                    left: 14 * fem,
                                    top: 0 * fem,
                                    child: SizedBox(
                                      width: 61 * fem,
                                      height: 22 * fem,
                                      child: Center(
                                        child: Text(
                                          'Expiry date',
                                          style: safeGoogleFont(
                                            'SF Pro Text',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5714285714 * ffem / fem,
                                            letterSpacing: -0.4099999964 * fem,
                                            color: const Color(0xff9586a8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // textfieldgzL (102:5975)
                              width: 176 * fem,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // container3K6 (I102:5975;102:5481)
                                    left: 0 * fem,
                                    top: 21 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 176 * fem,
                                        height: 48 * fem,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8 * fem),
                                            border: Border.all(
                                                color: const Color(0xffd8d0e3)),
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // textwfN (I102:5975;121:970)
                                    left: 13 * fem,
                                    top: 35 * fem,
                                    child: SizedBox(
                                      width: 25 * fem,
                                      height: 22 * fem,
                                      child: Center(
                                        child: Text(
                                          '474',
                                          style: safeGoogleFont(
                                            'SF Pro Text',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2941176471 * ffem / fem,
                                            letterSpacing: -0.4099999964 * fem,
                                            color: const Color(0xff2d0c57),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // hintEeU (I102:5975;121:1003)
                                    left: 14 * fem,
                                    top: 0 * fem,
                                    child: SizedBox(
                                      width: 22 * fem,
                                      height: 22 * fem,
                                      child: Center(
                                        child: Text(
                                          'CVC',
                                          style: safeGoogleFont(
                                            'SF Pro Text',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5714285714 * ffem / fem,
                                            letterSpacing: -0.4099999964 * fem,
                                            color: const Color(0xff9586a8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // hintKfv (102:6289)
                                    left: 122.6666259766 * fem,
                                    top: 33.6667480469 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 36 * fem,
                                        height: 26 * fem,
                                        child: Image.asset(
                                          'assets/screens/images/hint.png',
                                          width: 36 * fem,
                                          height: 26 * fem,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          // group28RDA (102:4671)
                          width: double.infinity,
                          height: 56 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff0acf83),
                            borderRadius: BorderRadius.circular(8 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'USE THIS CARD',
                              textAlign: TextAlign.center,
                              style: safeGoogleFont(
                                'SF Pro Text',
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2 * ffem / fem,
                                letterSpacing: -0.0099999998 * fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
