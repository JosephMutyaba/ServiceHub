import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/messaging/users_page.dart';
import 'package:myapp/screens/cart.dart';

import 'package:myapp/screens/profilePage.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

TextStyle safeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans 3",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}
class Utils {


  static toast(String message, {bool success = true}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: success ? Colors.green : Colors.red,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: source);
  if(file != null) {
    return await file.readAsBytes();
  }
  return Utils.toast("No image selected");
}

BottomNavigationBar bottomNavbar(BuildContext context, int selectedIndex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: selectedIndex,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.grey[600],
    selectedLabelStyle: safeGoogleFont(
      "Source Sans 3",
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: safeGoogleFont(
      "Source Sans 3",
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),

    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message_sharp),
        label: 'Chat',
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.shopping_cart),
      //   label: 'Cart',
      // ),
    ],

    onTap: (index) {
      if (index == 0) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }  else if (index == 1) {

          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));

      } else if (index == 2) {
        if (ModalRoute.of(context)?.settings.arguments is! UserPage) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
        }
       }
  // else if (index == 3) {
  //       if (ModalRoute.of(context)?.settings.arguments is! Cart) {
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
  //       }
  //     }
    },
  );
}
