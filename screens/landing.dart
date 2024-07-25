import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  var banner = {
    "assets/a7.jpeg",
    "assets/a1.jpeg",
    "assets/a2.jpeg",
    "assets/a3.jpeg",
    // "assets/a4.jpeg",
    // "assets/a6.jpeg",
    // "assets/a8.jpeg",

  } ;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      // height: heightSize,
      // : isMobile ? 100 : 250,

      width:  widthSize,
      padding: EdgeInsets.all( isMobile ? 8 : 15),
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: banner
                    .map((item) =>
                    Container(
                      width: widthSize,

                      child: Image.network(
                        item.toString(),
                        fit: BoxFit.fill,

                        errorBuilder: (context, error,
                            stackTrace) {
                          return Container(
                            // width: 100,
                            // height: 100,
                            color: Colors.grey,
                            child: Center(
                              child: Icon(
                                  Icons.broken_image),
                            ),
                          );
                        },
                      ),
                    ),
                ).toList(),
                options: CarouselOptions(
                  height: isMobile ? screenSize.height*0.50 : screenSize.height*0.85, // Customize the height of the carousel
                  // autoPlay: true, // Enable auto-play
                  // enlargeCenterPage: true, // Increase the size of the center item
                  // enableInfiniteScroll: true, // Enable infinite scroll
                  // onPageChanged: (index, reason) {
                  // },
                  // height: MediaQuery.of(context).size.height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: false,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 80),
                      Text(
                        'WELCOME TO',
                        style: GoogleFonts.josefinSans(
                          fontSize: 36,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'MUTHAMIZH',
                        style: GoogleFonts.lexendMega(
                          fontSize: 90,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'VARTHAGARGAL',
                        style: GoogleFonts.lexendMega(
                          fontSize: 90,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            // productDialog(context);
                          },

                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),

                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(
                            //       0), // Set the border radius to 0 for a rectangular shape
                            // ),
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                          child: Text(
                            "Join Us",
                            style: GoogleFonts.josefinSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
            
          ),
          SizedBox(height: 40,),
          Container(
            padding: EdgeInsets.all(20),
            height: heightSize / 1.3,
            width: widthSize,
            // color: Colors.deepOrangeAccent,
            color: Color(0xFFFFFDCB),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(40),
                  width: widthSize/2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        "The Largest International Organization for Referral Networking",
                        style: GoogleFonts.josefinSans(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "               Welcome to MUTHAMIZH VARTHAGARGAL, the largest international organization for referral networking. Our mission is to connect professionals across the globe, fostering valuable business relationships. With a vast network of members, we provide unparalleled opportunities for growth and collaboration. Join MUTHAMIZH VARTHAGARGAL and experience the benefits of being part of a thriving business community. Together, we achieve success through the power of referrals.",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          decoration: TextDecoration.none,
                        ),
                      ),

                    ],
                  )

                ),
                Expanded(
                  child: Container(
                    width: widthSize/2,
                    child: Image.asset("assets/a1.jpeg", fit: BoxFit.contain),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 40,),
          Container(
            height: 100,
            width: widthSize,
            padding: EdgeInsets.all( isMobile ? 8 : 15),
            color: Colors.deepOrange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "BE A PART OF OUR ORGANIZATION",
                  style: GoogleFonts.josefinSans(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                Container(
                  height: 50,
                  width: 200,
                  child:
                  ElevatedButton(
                    onPressed: () {
                      // productDialog(context);
                    },

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),

                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(
                      //       0), // Set the border radius to 0 for a rectangular shape
                      // ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      "Join Us",
                      style: GoogleFonts.josefinSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          Container(
            padding: EdgeInsets.all(20),
            height: heightSize / 1.3,
            width: widthSize,
            // color: Colors.deepOrangeAccent,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: widthSize/2,
                    child: Image.asset("assets/a7.jpeg", fit: BoxFit.contain),
                  ),
                ),
                Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset("assets/b1.png", fit: BoxFit.fill),
                    ),
                    Container(
                      padding: EdgeInsets.all(40),
                      width: widthSize/2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(
                            "Enhance Your Business Growth",
                            style: GoogleFonts.josefinSans(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Discover how 'MUTHAMIZH VARTHAGARGAL' can enhance your business growth. Our network offers strategic insights, collaborative opportunities, and expert guidance tailored to your unique goals. Join us to leverage exclusive resources, foster meaningful connections, and accelerate your professional journey. Whether you're expanding your reach or exploring new markets, 'MUTHAMIZH VARTHAGARGAL' empowers you to achieve sustainable growth and innovation. Elevate your business strategy with a community dedicated to your success.",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              decoration: TextDecoration.none,
                            ),
                          ),

                        ],
                      )

                  ),
                      ]
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(20),
            height: heightSize / 1.3,
            width: widthSize,
            // color: Colors.deepOrangeAccent,
            child: Row(
              children: [
                Stack(
                  children:[
                    Positioned.fill(
                      child: Image.asset("assets/b1.png", fit: BoxFit.fill),
                    ),
                   Container(
                      padding: EdgeInsets.all(40),
                      width: widthSize/2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(
                            "Establish Professional Connections",
                            style: GoogleFonts.josefinSans(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Become a part of 'MUTHAMIZH VARTHAGARGAL' and establish professional connections that will elevate your business. Our organization offers a vibrant community where you can network with industry leaders and like-minded professionals. Gain access to exclusive events, collaborative opportunities, and invaluable insights that drive success. Enhance your professional journey by leveraging the collective knowledge and experience within our network. Let 'MUTHAMIZH VARTHAGARGAL' be your gateway to building lasting and impactful relationships",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              decoration: TextDecoration.none,
                            ),
                          ),

                        ],
                      )

                  ),
    ]
                ),
                Expanded(
                  child: Container(
                    width: widthSize/2,
                    child: Image.asset("assets/a8.jpeg", fit: BoxFit.contain),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(20),
            height: heightSize / 1.3,
            width: widthSize,
            // color: Colors.deepOrangeAccent,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: widthSize/2,
                    child: Image.asset("assets/a6.jpeg", fit: BoxFit.contain),
                  ),
                ),
                Stack(
                  children:[
                    Positioned.fill(
                      child: Image.asset("assets/b1.png", fit: BoxFit.fill),
                    ),
                    Container(
                      padding: EdgeInsets.all(40),
                      width: widthSize/2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(
                            "Improve Your Proficiencies",
                            style: GoogleFonts.josefinSans(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Engage with 'MUTHAMIZH VARTHAGARGAL' to improve your proficiencies and elevate your professional capabilities. Our organization is dedicated to providing a rich environment for skill enhancement and knowledge exchange. Through our diverse network, you'll gain access to expert insights, advanced training programs, and collaborative opportunities that drive personal and professional growth. Strengthen your competencies, broaden your horizons, and achieve excellence with 'MUTHAMIZH VARTHAGARGAL' as your partner in development.",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              decoration: TextDecoration.none,
                            ),
                          ),

                        ],
                      )

                  ),
               ]
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.all(40),
            color: Color(0xFFD8EFD3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MouseRegion(
                  child: GestureDetector(
                    onTap:(){context.go("/search");},
                    child: Container(
                      height: 100,
                      width: widthSize * 0.30,
                      // color: Colors.deepOrange,
                      child: Stack(
                        children:[
                          Positioned.fill(
                            child: Image.asset("assets/d3.png", fit: BoxFit.fill),
                          ),
                          Center(
                          child: Text(
                            "FIND YOUR CONSTITUENT",
                            style: GoogleFonts.josefinSans(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        ]
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: widthSize * 0.30,
                  // color: Colors.deepOrange,
                  child: Stack(
                      children:[
                        Positioned.fill(
                          child: Image.asset("assets/d1.png", fit: BoxFit.fill),
                        ),
                        Center(
                          child: Text(
                            "OUR EVENTS",
                            style: GoogleFonts.josefinSans(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
                Container(
                  height: 100,
                  width: widthSize * 0.30,
                  // color: Colors.deepOrange,
                  child: Stack(
                      children:[
                        Positioned.fill(
                          child: Image.asset("assets/d1.png", fit: BoxFit.fill),
                        ),
                        Center(
                          child: Text(
                            "THE LATEST UPDATES",
                            style: GoogleFonts.josefinSans(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 30,),
          Container(
            height: heightSize,
            width: widthSize,
            padding: EdgeInsets.all(40),
            color: Color(0xFFF5F5DC),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text(
                  "Words from our community",
                  style: GoogleFonts.josefinSans(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: widthSize/3,
                      height: heightSize/ 1.5,
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage("assets/t2.jpeg"), // Replace with your image path
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "As a member of MUTHAMIZH VARTHAGARGAL, I've experienced unparalleled opportunities for networking and growth. The organization's commitment to fostering meaningful connections and professional development is truly commendable. Through their events and resources, I've expanded my business reach and forged valuable partnerships. MUTHAMIZH VARTHAGARGAL has not only enhanced my visibility in the industry but also provided a supportive community of like-minded professionals. Joining this organization has been instrumental in accelerating my career and expanding my horizons. I highly recommend MUTHAMIZH VARTHAGARGAL to anyone looking to thrive in their professional journey.",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Member Name",
                            style: GoogleFonts.josefinSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: widthSize/3,
                      height: heightSize/ 1.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage("assets/t1.jpeg"), // Replace with your image path
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "As a member of MUTHAMIZH VARTHAGARGAL, I've experienced unparalleled opportunities for networking and growth. The organization's commitment to fostering meaningful connections and professional development is truly commendable. Through their events and resources, I've expanded my business reach and forged valuable partnerships. MUTHAMIZH VARTHAGARGAL has not only enhanced my visibility in the industry but also provided a supportive community of like-minded professionals. Joining this organization has been instrumental in accelerating my career and expanding my horizons. I highly recommend MUTHAMIZH VARTHAGARGAL to anyone looking to thrive in their professional journey.",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Member Name",
                            style: GoogleFonts.josefinSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30,),
          Container(
            height: 100,
            width: widthSize,
            padding: EdgeInsets.all( isMobile ? 8 : 15),
            color: Color(0xFF5A72A0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "BE A PART OF OUR ORGANIZATION",
                  style: GoogleFonts.josefinSans(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                Container(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // productDialog(context);
                    },

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),

                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(
                      //       0), // Set the border radius to 0 for a rectangular shape
                      // ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      "Join Us",
                      style: GoogleFonts.josefinSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Container(
            height: heightSize,
            width: widthSize,
            padding: EdgeInsets.all(40),
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text(
                  "Our Latest Updates",
                  style: GoogleFonts.josefinSans(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: widthSize * 0.3,
                      height: heightSize/ 1.5,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        color: Color(0xFFFFFFFF),
                        // borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            height: 150,
                            width: widthSize * 0.3,
                            child: Image.asset("assets/a1.jpeg", fit: BoxFit.fill),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "Business Meet on 27/07/24",
                            style: GoogleFonts.josefinSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "     We are excited to announce the upcoming business meet of 'MUTHAMIZH VARTHAGARGAL' on 27th July 2024. Join us for an enriching session of networking and collaboration with like-minded professionals. This event is designed to foster growth, share innovative ideas, and explore new business opportunities. Don't miss the chance to connect and elevate your business. Mark your calendars and prepare for an inspiring and productive day!",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: widthSize * 0.3,
                      height: heightSize/ 1.5,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        color: Color(0xFFFFFFFF),
                        // borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            height: 150,
                            width: widthSize * 0.3,
                            child: Image.asset("assets/a8.jpeg", fit: BoxFit.fill),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "Business Meet on 27/07/24",
                            style: GoogleFonts.josefinSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "     We are excited to announce the upcoming business meet of 'MUTHAMIZH VARTHAGARGAL' on 27th July 2024. Join us for an enriching session of networking and collaboration with like-minded professionals. This event is designed to foster growth, share innovative ideas, and explore new business opportunities. Don't miss the chance to connect and elevate your business. Mark your calendars and prepare for an inspiring and productive day!",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: widthSize * 0.3,
                      height: heightSize/ 1.5,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        color: Color(0xFFFFFFFF),
                        // borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            height: 150,
                            width: widthSize * 0.3,
                            child: Image.asset("assets/a7.jpeg", fit: BoxFit.fill),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "Business Meet on 27/07/24",
                            style: GoogleFonts.josefinSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "     We are excited to announce the upcoming business meet of 'MUTHAMIZH VARTHAGARGAL' on 27th July 2024. Join us for an enriching session of networking and collaboration with like-minded professionals. This event is designed to foster growth, share innovative ideas, and explore new business opportunities. Don't miss the chance to connect and elevate your business. Mark your calendars and prepare for an inspiring and productive day!",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: widthSize,
            height: 250,
            color: Colors.deepOrange,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About US",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Contact US",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "FAQS",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 1,height: 100, color:Colors.white),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Team",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Blog & News",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "The Latest Updates",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 1,height: 100, color:Colors.white),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Find Constituents",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Our Events",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Join Us",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 1,height: 100, color:Colors.white),
                      Container(
                        child:Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Subscribe to get latest updates",
                                  style: GoogleFonts.teko(
                                    fontSize : 22 ,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),),
                                SizedBox(width: 20,),
                                Container(

                                  width: 250,
                                  child: Material(
                                    child: TextField(

                                      decoration: InputDecoration(
                                        // hintText: 'Email', // Placeholder text
                                        labelText: 'Email', // Label text
                                        labelStyle: TextStyle(color: Colors.black45, fontSize: 14)
                                        // Border shape
                                        // border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // Login logic goes here
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF5A72A0),

                                  ),
                                  child: Text('Subscribe',style: TextStyle(
                                      color: Colors.white
                                  ),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          )

        ],
      ) ,
    );
  }
}
