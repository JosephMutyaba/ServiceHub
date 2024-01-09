import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/send_work_request_page.dart';
import 'package:myapp/utils.dart';

class ProfessionalDetailsPage extends StatefulWidget {
  // final Map<String, dynamic> professionalData;

  // const ProfessionalDetailsPage({super.key, required this.professionalData});

  final Map<String, dynamic> professionalData;

  const ProfessionalDetailsPage({
    super.key,
    required this.professionalData,
  });

  @override
  State<ProfessionalDetailsPage> createState() =>
      _ProfessionalDetailsPageState();
}

class _ProfessionalDetailsPageState extends State<ProfessionalDetailsPage> {
  late int likes;
  bool toggle = false;

  @override
  void initState() {
    super.initState();
    // Initialize likes count when the page is loaded
    likes = widget.professionalData['likes'] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.professionalData['fname']} ${widget.professionalData['lName']}',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 23,
              fontFamily: 'Poppins'
            )
        ),
        backgroundColor: const Color(0xFF755DC1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            width: double.infinity,
            height: 896 * fem,
            decoration: const BoxDecoration(
              color: Color(0xfff6f5f5),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0 * fem,
                  top: 0 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 414 * fem,
                      height: 358 * fem,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffdbd8dd),
                          gradient: const LinearGradient(
                            begin: Alignment(0, -1),
                            end: Alignment(0, 1),
                            colors: <Color>[
                              Color(0x35000000),
                              Color(0x33000000),
                              Color(0x59000000),
                              Color(0x7f000000),
                              Color(0x99000000)
                            ],
                            stops: <double>[0, 0.587, 0.673, 0.859, 1],
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                widget.professionalData['imageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0 * fem,
                  top: 281 * fem,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        20 * fem, 37 * fem, 20 * fem, 65 * fem),
                    width: 414 * fem,
                    height: 615 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0xfff6f5f5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30 * fem),
                        topRight: Radius.circular(30 * fem),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 90 * fem, 8 * fem),
                          width: double.infinity,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hourly Rate: ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w600,
                                )
                                ),

                              Text(
                                'UGX ${widget.professionalData['hourlyRate']}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          child: const Icon(Icons.star_border,
                              semanticLabel: '5.0 Rating', color: Colors.amber),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 18 * fem),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description:',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${widget.professionalData['description']}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(

                                children: [

                                  Text(
                                    'Likes: ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22 * ffem,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(Icons.thumb_up_alt,color: Colors.deepPurple.shade700,),
                                  const SizedBox(width: 10),
                                  Text(
                                    '$likes',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22 * ffem,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 56 * fem,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      // Fetch the professional document based on email
                                      QuerySnapshot<Map<String, dynamic>>
                                          snapshot = await FirebaseFirestore
                                              .instance
                                              .collection('user')
                                              .where('email',
                                                  isEqualTo:
                                                      widget.professionalData[
                                                          'email'])
                                              .limit(1) // Limit to one document
                                              .get();

                                      if (snapshot.docs.isNotEmpty) {
                                        // Get the professional document
                                        DocumentSnapshot<Map<String, dynamic>>
                                            professionalDoc =
                                            snapshot.docs.first;

                                        // Toggle likes (increment if currently 0, decrement if currently 1)
                                        toggle = !toggle;
                                        int newLikes = 0;
                                        int currentLikes =
                                            professionalDoc['likes'] ?? 0;

                                        if (toggle) {
                                          newLikes = currentLikes + 1;
                                        } else {
                                          newLikes = currentLikes - 1;
                                        }

                                        // Update the likes field in Firestore
                                        await FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(professionalDoc.id)
                                            .update({'likes': newLikes});

                                        // Update the likes count in the UI
                                        setState(() {
                                          likes = newLikes;
                                        });
                                      }
                                    },
                                    icon:  Icon(!toggle ? Icons.favorite_border :
                                    Icons.favorite),

                                    label: Text(!toggle
                                        ? 'Like'
                                        : 'Unlike'),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xff755dc1),
                                      backgroundColor:Colors.deepPurple[50],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SendWorkRequestPage(
                                          professionalData:
                                              widget.professionalData),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.work),
                                label: const Text('Send Work Request',
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                        fontFamily: 'Poppins'
                                    )

                                ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xff755dc1),
                                  backgroundColor: Colors.deepPurple[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
