import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/professionals_list.dart';
import 'package:myapp/screens/cart.dart';
import 'package:myapp/screens/profile.dart';

class MyApp24 extends StatelessWidget {
  const MyApp24({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profession Categories'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                
              },
            ),
          ],
        ),
        body: ProfessionsGrid(),
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
        ),
      ),
    );
  }
}

class ProfessionsGrid extends StatelessWidget {
  final List<String> professions = [
    'electrician',
    'Doctor',
    'Teacher',
    'Lawyer',
    'Artist',
    'Scientist',
    'Police Officer',
    'Firefighter',
    'Architect',
    'Writer',
    'Graphic Designer',
    'Nurse',
    'Pilot',
    'Actor',
    'Musician',
    'Journalist',
    'Software Developer',
    'Entrepreneur',
    'Dentist',
    'Psychologist',
    'plumbing',
    'mechanic',
    'Social Worker',
    'carpenter',
    'key',
    'transport',
    'chef',
  ];

  ProfessionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: professions.length,
        itemBuilder: (context, index) {
          return ProfessionCard(profession: professions[index]);
        },
      ),
    );
  }
}

class ProfessionCard extends StatelessWidget {
  final String profession;

  const ProfessionCard({super.key, required this.profession});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessionalListPage(
                selectedProfession:
                    profession), // Replace with your destination page
          ),
        );
      },
      child: Container(
        width: 177.0,
        height: 210.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xffd8d0e3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 125.0,
              decoration: BoxDecoration(
                color: const Color(0xffdbd8dd),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/screens/images/$profession.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  profession,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2d0c57),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


