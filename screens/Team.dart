import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muthamizh/components/navbar.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Column(
      children: [
        Navbar(),
        Container(
          height: heightSize * 0.80,
          width: widthSize,
          padding: EdgeInsets.all(40),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                width: widthSize * 0.30,
                height: heightSize * 0.80,
                child:
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                            width: widthSize * 0.30,
                            height: heightSize * 0.60,
                            child: Image.asset("assets/t1.jpeg", fit: BoxFit.contain)),
                        Text(
                          "MV SPONSOR",
                          style: GoogleFonts.josefinSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
              ),
              Container(
                width: widthSize * 0.30,
                height: heightSize * 0.80,
                child:
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        width: widthSize * 0.30,
                        height: heightSize * 0.60,
                        child: Image.asset("assets/t2.jpeg", fit: BoxFit.contain)),
                    Text(
                      "MV BOARD MEMBER",
                      style: GoogleFonts.josefinSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: widthSize * 0.30,
                height: heightSize * 0.80,
                child:
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        width: widthSize * 0.30,
                        height: heightSize * 0.60,
                        child: Image.asset("assets/t1.jpeg", fit: BoxFit.contain)),
                    Text(
                      "MV SPONSOR",
                      style: GoogleFonts.josefinSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
