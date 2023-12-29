import 'package:flutter/material.dart';

class ProfessionalDetailsPage extends StatelessWidget {
  final Map<String, dynamic> professionalData;

  const ProfessionalDetailsPage({Key? key, required this.professionalData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${professionalData['fname']} ${professionalData['lName']}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            width: double.infinity,
            height: 896,
            decoration: BoxDecoration(
              color: const Color(0xfff6f5f5),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 281,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 37, 20, 65),
                    width: 414,
                    height: 615,
                    decoration: BoxDecoration(
                      color: const Color(0xfff6f5f5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 90, 8),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                child: Text(
                                  'Labour:  UGX ${professionalData['hourlyRate']}',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff2d0c57),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Display other details dynamically
                        // ...

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Implement like functionality
                                },
                                icon: const Icon(Icons.favorite_border),
                                label: const Text('Like'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Implement add to cart functionality
                                },
                                icon: const Icon(Icons.shopping_cart),
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
    );
  }
}
