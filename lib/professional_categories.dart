import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/professionals_list.dart';
import 'package:myapp/utils.dart';

class MyApp24 extends StatelessWidget {
  const MyApp24({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Profession Categories',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 23.0,
                fontFamily: 'Poppins'
              )
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app,
                  color: Colors.white),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
            backgroundColor: const Color(0xFF755DC1),
        ),
        body: ProfessionsGrid(),
          bottomNavigationBar: bottomNavbar(context,0)

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
                    profession), 
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
                  style:  TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple.shade700,
                    fontFamily: 'Poppins'
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


