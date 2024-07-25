import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FindMember extends StatefulWidget {
  const FindMember({super.key});

  @override
  State<FindMember> createState() => _ProfileState();
}

class _ProfileState extends State<FindMember> {
  Uint8List? _imageData;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      height: heightSize,
      width: widthSize,
      color: Color(0xFFE1F0DA),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Color(0xFFFFFFFF),
            width: widthSize * 0.60,
            height: heightSize * 0.80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: _imageData != null ? MemoryImage(_imageData!) : null,
                  child: _imageData == null ? Icon(Icons.person, size: 50) : null,
                  // backgroundImage:
                  // Image.memory(_imageData!, height: 100, width: 100),
                  // AssetImage("assets/t2.jpeg"), // Replace with your image path
                ),
                SizedBox(height: 10,),
                Container(
                  child: Center(
                    child: Text("EDIT PROFILE",
                        style: GoogleFonts.josefinSans(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        )),
                    // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Center(
                    child: Text("Phone",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        )),
                    // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Center(
                    child: Text("Phone",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        )),
                    // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                  ),
                ),
                SizedBox(height: 30,),


                Container(
                  child: Center(
                    child: Text("Address",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        )),
                    // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Center(
                    child: Text("url",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.deepOrange,
                          decoration: TextDecoration.none,
                        )),
                    // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
