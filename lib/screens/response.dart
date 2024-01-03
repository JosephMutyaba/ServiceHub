import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class Response extends StatelessWidget {
  const Response({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkout',
              textAlign: TextAlign.center,
              style: safeGoogleFont(
                'SF Pro Text',
                fontSize: 30,
                fontWeight: FontWeight.w600,
                height: 1.2941176471 * ffem / fem,
                letterSpacing: -0.4099999964 * fem,
              )),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              // checkoutscrollviewLE4 (33:700)
              padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 42 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfff6f5f5),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupuxqiHqS (9sMsqtiVizSREAKvkKUXqi)
                      margin: EdgeInsets.fromLTRB(
                          20 * fem, 25 * fem, 24.5 * fem, 18 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // titleQv4 (102:4206)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 152.5 * fem, 0 * fem),
                            child: Text(
                              'Payment method',
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
                          GestureDetector(
                            // onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => const Payment()));
                            // },
                            child: Container(
                              // changehuA (I102:4276;102:3868)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 2 * fem, 0 * fem, 0 * fem),
                              child: Text(
                                'CHANGE',
                                textAlign: TextAlign.center,
                                style: safeGoogleFont(
                                  'SF Pro Text',
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2 * ffem / fem,
                                  letterSpacing: -0.0099999998 * fem,
                                  color: const Color(0xff7103ff),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // cellrowviewBZS (102:4497)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 32 * fem),
                      padding: EdgeInsets.fromLTRB(
                          21 * fem, 15 * fem, 223 * fem, 15 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconcreditcardUoS (I102:4497;102:387)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 26 * fem, 0 * fem),
                            width: 22 * fem,
                            height: 16 * fem,
                            child: Image.asset(
                              'assets/screens/images/icon-credit-card.png',
                              width: 22 * fem,
                              height: 16 * fem,
                            ),
                          ),
                          Text(
                            // textarU (I102:4497;102:782)
                            '**** **** **** 4747',
                            style: safeGoogleFont(
                              'SF Pro Text',
                              fontSize: 17 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              letterSpacing: -0.4099999964 * fem,
                              color: const Color(0xff9586a8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupatjnJGg (9sMsxZC4Rhf2hBx2brATjN)
                      margin: EdgeInsets.fromLTRB(
                          20 * fem, 0 * fem, 24.5 * fem, 18 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // title1wn (102:285)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 159.5 * fem, 0 * fem),
                            child: Text(
                              'Delivery address',
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
                          Container(
                            // changeunG (I102:4136;102:3868)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 2 * fem, 0 * fem, 0 * fem),
                            child: Text(
                              'CHANGE',
                              textAlign: TextAlign.center,
                              style: safeGoogleFont(
                                'SF Pro Text',
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2 * ffem / fem,
                                letterSpacing: -0.0099999998 * fem,
                                color: const Color(0xff7103ff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // addressDnx (102:2131)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 200 * fem),
                      padding: EdgeInsets.fromLTRB(
                          23 * fem, 16 * fem, 182 * fem, 16 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // iconhomeY4Y (102:351)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 2 * fem, 28 * fem, 0 * fem),
                            width: 18 * fem,
                            height: 20 * fem,
                            child: Image.asset(
                              'assets/screens/images/icon-home-7FN.png',
                              width: 18 * fem,
                              height: 20 * fem,
                            ),
                          ),
                          Container(
                            // textqZS (102:321)
                            constraints: BoxConstraints(
                              maxWidth: 163 * fem,
                            ),
                            child: Text(
                              'Alexandra Smith\nCesu 31 k-2 5.st, SIA Chili\nRiga\nLV–1012\nLatvia\n',
                              style: safeGoogleFont(
                                'SF Pro Text',
                                fontSize: 17 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * ffem / fem,
                                letterSpacing: -0.4099999964 * fem,
                                color: const Color(0xff9586a8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      icon: const Icon(Icons.thumb_up_alt_outlined),
                      label: const Text('Confirm'),
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: buildFutureBuilder(context)
    );
  }
}
