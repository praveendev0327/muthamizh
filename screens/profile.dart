import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:muthamizh/components/imagepicker.dart';
import 'package:muthamizh/components/jobpost.dart';
import 'package:muthamizh/components/navbar.dart';
import 'package:muthamizh/middleware/bloc.dart';
import 'package:muthamizh/middleware/state.dart';
import 'dart:html' as html;
import 'package:muthamizh/middleware/storeStringBloc.dart';

class Profile extends StatefulWidget {
  final String id;
  const Profile({super.key, required this.id});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Uint8List? _imageData;
  final ScrollController _scrollController = ScrollController();
  List<dynamic> bannersData = [];
  late List<dynamic> jobPostedList = [];
  String? storedString;
  late String name = "";
  late String com = "";
  // late String work = "";
  late String url = "";
  late String pro = "";
  late String add = "";
  late String img = "";
  late int screens = 1;
  File? _file;
  html.File? _selectedFiles;
  String? base64Image;
  Uint8List? _imageValue;
  bool? noData = false;
  bool? indicator = false;

  @override
  void initState() {
    super.initState();
    // _focusNode.addListener(() {
    //   print('Focus: ${_focusNode.hasFocus}');
    // });
    // Start the timer when the widget is initialized//
    // _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
    //   setState(() {
    //     // Update the current index to display the next image//
    //     _currentIndex = (_currentIndex + 1) % _imageUrls.length;
    //   });
    // });

    //CURRENT LOGED USER DETAILS//
    // User? currentUser = FirebaseAuth.instance.currentUser;
    // // print(' user: ${currentUser}');
    // if (currentUser != null) {
    //   // print('Current user: ${currentUser.email}');
    //   FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(currentUser!.uid)
    //       .get()
    //       .then((DocumentSnapshot documentSnapshot) {
    //     if (documentSnapshot.get('role') == "Admin") {
    //       // print("Login by Admin => ${documentSnapshot.get('role')}");
    //     }else{
    //       print("Login by User");
    //     }
    //   });
    //
    // } else {
    //   print('No user signed in');
    // }
    final stringBloc = BlocProvider.of<StringBloc>(context);
    final currentState = stringBloc.state;

    // Check if the state is StringLoaded and get the value
    if (currentState is StringLoaded) {
      setState(() {
        storedString = currentState.value;
      });
    }
    getUserProfile();
    getBanners();
  }

  void getUserProfile() async {
    // final prefs = await SharedPreferences.getInstance();Software Developer
    // print('getUserProfile : ${storedString}');
    try {
      final data = {
        // "email" : Uri.decodeComponent(widget.id) ,
        // "email" : storedString,
        "email": "praveen@gmail.com",
      };
      final response = await http.post(
        Uri.parse("https://justcalltest.onrender.com/api/users/getprofilebyid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successfully sent data
        // print('login successfully');
        final fetch = json.decode(response.body);
        // print('login fetch : ${fetch }');
        // print('login successfully : ${fetch["data"][0] }');
        final checkUser = fetch["data"][0];
        // print('fetch : ${checkUser["email"] }');

        setState(() {
          // getData = checkUser;
          name = checkUser["firstname"];
          com = checkUser["company"];
          add = checkUser["address"];
          pro = checkUser['work'];
          url = checkUser["url"];
          img = checkUser['image'];
        });
      } else {
        // Error occurred while sending data
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
    }
  }

  void getBanners() async {

    try {
      final data ={
        "email" : "praveen@gmail.com",
      };
      final response = await http.post(
        Uri.parse("https://justcalltest.onrender.com/api/users/getprofilebyemail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successfully sent data

        final fetch = json.decode( response.body);

        final resData = fetch["data"];
        // print('fetch : ${checkUser["email"] }');

        setState(() {
          bannersData = resData ;
        });
      } else {// Error occurred while sending data
        print('Failed to send data: ${response.statusCode}');

      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
      // setState(() {
      //   noData = true;
      // });
      // setState(() {
      //   indicator = false;
      // });
    }
  }

  void getJobPost() async {
    // setState(() {
    //   noData == false;
    // });
    // final prefs = await SharedPreferences.getInstance();
    print('search');
    try {
      final data ={
        "email" : "praveen@gmail.com",
      };
      final response = await http.post(
        Uri.parse("https://justcalltest.onrender.com/api/users/getjobpostbyemail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successfully sent data

        final fetch = json.decode( response.body);
        print('search fetch : ${fetch }');

        final checkUser = fetch["data"];
        // print('fetch : ${checkUser["email"] }');
        // print('Search successfully : ${checkUser[0] }');
        setState(() {
          // getData = checkUser;
          if(checkUser.isEmpty){
            print('search successfully');
            noData = true;
          }else{
            noData = false;
            jobPostedList = checkUser;
          }

        });
        setState(() {
          indicator = false;
        });
      } else {// Error occurred while sending data
        print('Failed to send data: ${response.statusCode}');
        setState(() {
          noData = true;
        });
        setState(() {
          indicator = false;
        });
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
      // setState(() {
      //   noData = true;
      // });
      // setState(() {
      //   indicator = false;
      // });
    }
  }



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      // height: heightSize,
      width: widthSize,
      color: Color(0xFFE1F0DA),
      child:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Navbar(),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Color(0xFFFFFFFF),
                width: widthSize * 0.60,
                height: heightSize * 0.80,
                child: img == ''
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: img != null
                                ? MemoryImage(base64Decode(
                                    img!.contains(',') ? img.split(',')[1] : img))
                                : null,
                            child: _imageData == null && img == null
                                ? Icon(Icons.person, size: 50)
                                : null,
                            // backgroundImage:
                            // Image.memory(_imageData!, height: 100, width: 100),
                            // AssetImage("assets/t2.jpeg"), // Replace with your image path
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Center(
                              child: Text("${name}",
                                  style: GoogleFonts.josefinSans(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  )),
                              // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Center(
                              child: Text("${com}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  )),
                              // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Center(
                              child: Text("${pro}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  )),
                              // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showPopup(context);
                                },
                                child: Text("+Add Post",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.deepOrange,
                                      decoration: TextDecoration.none,
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: (){
                                  showJobPost(context);
                                },
                                child: Text("+Add Job Post",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.deepOrange,
                                      decoration: TextDecoration.none,
                                    )),
                              ),


                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                size: 25,
                                color: Colors.deepOrangeAccent,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(
                                Icons.messenger,
                                size: 25,
                                color: Colors.deepOrangeAccent,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(
                                Icons.calendar_today,
                                size: 25,
                                color: Colors.deepOrangeAccent,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Center(
                              child: Text("${add}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  )),
                              // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Center(
                              child: Text("${url}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.deepOrange,
                                    decoration: TextDecoration.none,
                                  )),
                              // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap : (){
                                  setState(() {
                                    // indicator = true;
                                    screens = 1;
                                  });
                                  getBanners();
                                },
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  color: Colors.deepOrange,
                                  child: Center(
                                    child: Text("Post",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                        )),
                                    // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    indicator = true;
                                    screens = 2;
                                  });
                                  getJobPost();
                                },
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  color: Colors.deepOrange,
                                  child:
                                  indicator == true ?
                                  Center(child:
                                  SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      strokeWidth: 2.0,
                                    ),
                                  )) :
                                  Center(
                                    child: Text("Job Post",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                        )),
                                    // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    screens = 3;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  color: Colors.deepOrange,
                                  child: Center(
                                    child: Text("CV's",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                        )),
                                    // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              screens == 2 ?
                Container(
                  width: widthSize * 0.60,
                  height: heightSize ,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: jobPostedList!.length,
                      itemBuilder: (context, index) {
                        return
                          Container(
                            width: widthSize * 0.60,
                            height: heightSize * 0.70,

                            color: Color(0xFFFEFFD2),
                            padding: EdgeInsets.all(10),
                            margin:EdgeInsets.all(10) ,
                            child:
                            indicator == true ?
                            Center(child:
                            SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                                strokeWidth: 2.0,
                              ),
                            )) :
                            SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${jobPostedList[index]["title"]}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("${jobPostedList[index]["description"]}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87,
                                        decoration: TextDecoration.none,
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showPopup(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 200,
                                      color: Colors.deepOrange,
                                      child: Center(
                                        child: Text("Apply",
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                            )),
                                        // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                      }
                  ),
                )
                  :  SizedBox(),
              screens == 1 && bannersData.isNotEmpty ?
              Container(
                width: widthSize * 0.60,
                height: heightSize * 0.80,

                    child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widthSize < 600 ? 3 : widthSize < 1120 ? 2 :   2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          // childAspectRatio: isMobile ? 1.2 / 3 : 2/3,
                        ),
                        // itemCount: collectionListData.length  > maxItems ? maxItems : collectionListData.length,
                        itemCount: bannersData!.length  ,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            Container(
                              height: heightSize * 0.3,
                              width: widthSize,
                              // color: Colors.blue,
                              child:
                              // Image.asset(
                              //   collectionListData[index].img as String,
                              //   fit: BoxFit.contain,)
                              Image.memory(base64Decode(bannersData![index]["image"]!.contains(',')  ? bannersData![index]["image"].split(',')[1] : bannersData![index]["image"])),
                            );

                        }
                    )


              )
                  : SizedBox()
          
            ],
          ),
        ),

    );
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:ImagePicker()
        );
      },
    );
  }
  void showJobPost(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content:JobPost()
        );
      },
    );
  }

}
// if (_imageData != null) ...[
// SizedBox(height: 20),
// Image.memory(_imageData!, height: 100, width: 100),
// ], Navigator.of(context).pop();
