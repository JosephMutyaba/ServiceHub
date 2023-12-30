import 'package:flutter/material.dart';
import 'package:myapp/screens/profile.dart';

import 'package:myapp/utils.dart';
import 'cart.dart';

class Item extends StatelessWidget {
  const Item({super.key});



  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return
      Scaffold(
        appBar: AppBar(
        title:  Text('Kibirige Martin' ,
            style: safeGoogleFont (
              'SF Pro Display',
              fontSize: 34*ffem,
              fontWeight: FontWeight.w700,
              height: 1.2058823529*ffem/fem,
              letterSpacing: 0.4099999964*fem,),),
          backgroundColor: Colors.deepPurple,


    ),
    body:
    SingleChildScrollView(
    child: SizedBox(
      width: double.infinity,
      child: Container(
        // itemrfi (33:698)
        width: double.infinity,
        height: 896*fem,
        decoration: const BoxDecoration (
          color: Color(0xfff6f5f5),
        ),
        child: Stack(
          children: [
            Positioned(
              // media9ui (33:477)
              left: 0*fem,
              top: 0*fem,
              child: Align(
                child: SizedBox(
                  width: 414*fem,
                  height: 358*fem,
                  child: Container(
                    decoration: const BoxDecoration (
                      color: Color(0xffdbd8dd),
                      gradient: LinearGradient (
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                        colors: <Color>[Color(0x35000000), Color(0x33000000), Color(0x59000000), Color(0x7f000000), Color(0x99000000)],
                        stops: <double>[0, 0.587, 0.673, 0.859, 1],
                      ),
                      image: DecorationImage (
                        image: AssetImage (
                          '',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),


            Positioned(
              // backdropHY4 (896:288)
              left: 0*fem,
              top: 281*fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(20*fem, 37*fem, 20*fem, 65*fem),
                width: 414*fem,
                height: 615*fem,
                decoration: BoxDecoration (
                  color: const Color(0xfff6f5f5),
                  borderRadius: BorderRadius.only (
                    topLeft: Radius.circular(30*fem),
                    topRight: Radius.circular(30*fem),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      // pricepAc (102:5337)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 90*fem, 8*fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // wm2 (56:16894)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                            child: Text(
                              'Labour:  UGX 20,000',
                              style: safeGoogleFont (
                                'SF Pro Text',
                                fontSize: 32*ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3463542461*ffem/fem,
                                letterSpacing: -0.8029167056*fem,
                                color: const Color(0xff2d0c57),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      // textZnQ (102:5392)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 20*fem),
                      child: const Icon(
                        Icons.star_border,
                        semanticLabel: '5.0 Rating',
                        color: Colors.amber
                      ),

                    ),
                    Container(
                      // titlermW (102:4859)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 18*fem),
                      child: Text(
                        'Reviews',
                        style: safeGoogleFont (
                          'SF Pro Text',
                          fontSize: 22*ffem,
                          fontWeight: FontWeight.w700,
                          height: 1*ffem/fem,
                          letterSpacing: -0.4099999964*fem,
                          color: const Color(0xff2d0c57),
                        ),
                      ),
                    ),
                    Container(
                      // textmda (102:4862)
                      margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 30*fem),
                      constraints: BoxConstraints (
                        maxWidth: 362*fem,
                      ),
                      child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                        ListTile(
                          title: Text('To More',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,),),
                          subtitle: Text('This is a text styling page.....',),
                          trailing: Icon(Icons.arrow_drop_down),
                          leading: Icon(Icons.person),

                        ),
                            ListTile(
                              title: Text('To More',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,)),
                              subtitle: Text('This is a text styling page.....',),
                              trailing: Icon(Icons.arrow_drop_down),
                              leading: Icon(Icons.person),

                            ),
                            ListTile(
                              title: Text('To More',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,)),
                              subtitle: Text('This is a text styling page.....',),
                              trailing: Icon(Icons.arrow_drop_down),
                              leading: Icon(Icons.person),

                            ),
                      ],),
                    ),


                    SizedBox(
                      // autogroupemi8fDA (9sMsTQMy76L72h6qVQemi8)
                      width: double.infinity,
                      height: 56*fem,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(

                              onPressed: (){},
                              icon: const Icon(
                                Icons.favorite_border
                              ),
                              label: const Text('Like')),

                          ElevatedButton.icon(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart() ));
                              },
                              icon: const Icon(
                                Icons.shopping_cart
                              ),
                              label: const Text('Add to cart'),

                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
          ),
    ),
          bottomNavigationBar: bottomNavbar(context)
      );
              }
            }