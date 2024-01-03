import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/screens/cart.dart';
import 'package:myapp/screens/profilePage.dart';

import 'package:myapp/screens/providersCart.dart';
import 'package:myapp/screens/providersResponse.dart';
import 'package:myapp/screens/response.dart';


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

// void load() async{
//
//   try {
//     late User? _user = FirebaseAuth.instance.currentUser;
//
//     QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
//         .instance
//         .collection('user')
//         .where('email', isEqualTo: _user?.email)
//         .limit(1)
//         .get();
//     late Map<String, dynamic> _userData = userData.docs.first.data();
//   }catch(e){
//     print(e);
//   }
//
// }

Future load() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('user')
          .where('email', isEqualTo: user.email)
          .limit(1)
          .get();

      if (userData.docs.isNotEmpty) {
        Map<String, dynamic> usersData = userData.docs.first.data();
        // Do something with _userData
        return usersData;
      } else {
        print("User not found");
        // Handle the case where the user data is not found
      }
    } else {
      print("User not authenticated");
      // Handle the case where the user is not authenticated
    }
  } catch (e) {
    print("Error: $e");
    // Handle other exceptions that may occur during the process
  }
}

// class UserData extends StatefulWidget {
//   const UserData({super.key});
//
//   @override
//   State<UserData> createState() => _UserDataState();
// }

// class _UserDataState extends State<UserData> {
//   late User? _user = FirebaseAuth.instance.currentUser;
//
//   QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
//       .instance
//       .collection('user')
//       .where('email', isEqualTo: _user.email)
//       .limit(1)
//       .get();
//   late Map<String, dynamic> _userData = userData.docs.first.data();
//
//   @override
//   void initState() {
//     super.initState();
//     _user = FirebaseAuth.instance.currentUser!;
//     _loadUserData();
//   }
//
//   // Future<void> _loadUserData() async {
//   //   try {
//   //     QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
//   //         .instance
//   //         .collection('user')
//   //         .where('email', isEqualTo: _user.email)
//   //         .limit(1)
//   //         .get();
//   //
//   //     if (userData.docs.isNotEmpty) {
//   //       if(mounted) {
//   //         setState(() {
//   //           _userData = userData.docs.first.data();
//   //         });
//   //       }
//   //     } else {
//   //       print('User data not found');
//   //     }
//   //   } catch (error) {
//   //     print('Error loading user data: $error');
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


// Future<BottomNavigationBar> bottomNavbar (BuildContext context) async {
//   Map<String, dynamic>? userData = await load();
//
//   return BottomNavigationBar(
//     items: const <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home, color: Colors.deepPurple),
//         label: 'Home',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.outgoing_mail, color: Colors.deepPurple),
//         label: 'Out',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.call_received, color: Colors.deepPurple),
//         label: 'Cart',
//       ),
//
//       BottomNavigationBarItem(
//         icon: Icon(Icons.person, color: Colors.deepPurple),
//         label: 'Profile',
//       ),
//
//     ],
//     currentIndex: 0,
//     selectedItemColor: Colors.deepPurple,
//     unselectedItemColor: Colors.blue,
//     onTap: (index) {
//       if (index == 0) {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//       } else if (index == 1) {
//         if (userData != null) {
//           if(userData['role']=='common_user'){
//               if (ModalRoute.of(context)?.settings.arguments is! Cart) {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
//               }else{
//                 if (ModalRoute.of(context)?.settings.arguments is! Cart) {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ProvidersCart()));
//                 }
//               }
//           }
//           // Access _userData here
//           print(userData);
//         } else {
//           print("User data is not available");
//         }
//       } else if (index == 2) {
//         if (ModalRoute.of(context)?.settings.arguments is! ProfileScreen) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
//         }
//       }
//       else if (index == 3) {
//         if (ModalRoute.of(context)?.settings.arguments is! ProfileScreen) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
//         }
//       }
//     },
//   );}

Future<BottomNavigationBar> bottomNavbar(BuildContext context) async {
  Map<String, dynamic>? userData = await load();

  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.deepPurple),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.outgoing_mail, color: Colors.deepPurple),
        label: 'Out',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.call_received, color: Colors.deepPurple),
        label: 'Cart',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person, color: Colors.deepPurple),
        label: 'Profile',
      ),
    ],
    currentIndex: 0,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.blue,
    onTap: (index) => _handleNavigation(context, index, userData),
  );
}

void _handleNavigation(BuildContext context, int index, Map<String, dynamic>? userData) {
  switch (index) {
    case 0:
      Navigator.of(context).popUntil((route) => route.isFirst);
      break;
    case 1:
      _navigateToCart(context, userData);
      break;
    case 2:
      _navigateToResponse(context, userData);
      break;
    case 3:
      _navigateToProfileScreen(context);
      break;
  }
}

void _navigateToCart(BuildContext context, Map<String, dynamic>? userData) {
  if (userData != null) {
    if (userData['role'] == 'common_user') {
      final isCart = ModalRoute.of(context)?.settings.arguments is Cart;

      isCart ? null : Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  const Cart(requestList: []) ,
        ),
      );

      // Access userData here
      print(userData);
    } else {
      // If the user role is not common_user, navigate to ProvidersCart
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProvidersCart()),
      );
    }
  } else {
    print("User data is not available");
  }
}

void _navigateToResponse(BuildContext context, Map<String, dynamic>? userData) {
  if (userData != null) {
    if (userData['role'] == 'common_user') {
      final isResponse = ModalRoute.of(context)?.settings.arguments is Response;

      isResponse ? null : Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  const Response() ,
        ),
      );

      // Access userData here
      print(userData);
    } else {
      // If the user role is not common_user, navigate to ProvidersCart
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProvidersResponse()),
      );
    }
  } else {
    print("User data is not available");
  }
}




void _navigateToProfileScreen(BuildContext context) {
  if (ModalRoute.of(context)?.settings.arguments is! ProfileScreen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
  }
}

FutureBuilder<BottomNavigationBar> buildFutureBuilder(BuildContext context) {
  return FutureBuilder<BottomNavigationBar>(
    future: bottomNavbar(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // If the Future is still running, display a circular progress indicator
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        );
      } else if (snapshot.hasError) {
        // If an error occurred, handle it here
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        // If the Future is complete and data is available, return the BottomNavigationBar
        return snapshot.data!;
      } else {
        // If the Future is complete but no data is available, you can display an appropriate message or UI
        return const Center(
          child: Text('No data available'),
        );
      }
    },
  );
}



