
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/auth/auth_page.dart';

import 'package:myapp/screens/updateProfile.dart';

import '../utils.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Colors.purple : Colors.accents.first;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)
      ),
      trailing: endIcon? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: const Icon(
              Icons.arrow_forward_ios,
              size: 18.0,
              color: Colors.grey)) : null,
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfileScreen> {
  late User _user;
  late Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('user')
          .where('email', isEqualTo: _user.email)
          .limit(1)
          .get();

      if (userData.docs.isNotEmpty) {
        if(mounted) {
          setState(() {
            _userData = userData.docs.first.data();
          });
        }
      } else {
        print('User data not found');
      }
    } catch (error) {
      print('Error loading user data: $error');
    }
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileScreen(userData: _userData),
      ),
    ).then((result) {
      if (result != null) {
        _loadUserData();
      }
    });
  }

  void _logout() async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("LOGOUT",),
          titleTextStyle: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text("Are you sure, you want to Logout?"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const AuthPage(),
                //   ),
                //       (route) => false,
                //   );
                if(!mounted) return;
                Navigator.of(context).popUntil((route) => route.isFirst);

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  side: BorderSide.none),
              child: const Text("Yes"),
            ),
            const SizedBox(width: 10,),
            OutlinedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("No")
            )],
          actionsAlignment: MainAxisAlignment.center,

        ));
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
            "Profile",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? Icons.dark_mode  : Icons.light_mode)
          )
        ],
      ),

      body:_userData.isNotEmpty
          ? SingleChildScrollView(
        child: Container(

          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                        radius: 50,
                      backgroundImage: _userData['imageUrl'] != null && _userData['imageUrl']!.isNotEmpty
                          ? NetworkImage(_userData['imageUrl']!)
                          : const AssetImage('assets/screens/profile.png') as ImageProvider<Object>,
                    )
                    ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                          color: Colors.purple,
                      ),
                      child: const IconButton(
                        icon:Icon(Icons.edit),
                        onPressed: null,
                        color: Colors.black,
                        iconSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(' ${_userData['fname']} ${_userData['lName']}',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text('Email: ${_userData['email']}', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              Text('Role: ${_userData['role']}', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                      _editProfile();
                    },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Settings", icon: Icons.settings, onPress: () {}),
              ProfileMenuWidget(title: "Billing Details", icon: Icons.wallet, onPress: () {}),
              ProfileMenuWidget(title: "User Management", icon: Icons.manage_accounts, onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: Icons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    _logout();
                  }),
            ],
          ),
        ),
      ): const Center(
    child: CircularProgressIndicator(),
    ),
        bottomNavigationBar: buildFutureBuilder(context)
    );
  }
}