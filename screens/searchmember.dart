import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muthamizh/components/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:muthamizh/middleware/bloc.dart';
import 'package:muthamizh/middleware/events.dart';
import 'package:muthamizh/middleware/storeStringBloc.dart';
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  TextInputType keyboardType = TextInputType.text;
  late List<dynamic> _productsFuture = [];
  bool? indicator = false;
  bool? noData = false;

  @override
  void initState() {

    super.initState();
  }

  void searchUser() async {
    // setState(() {
    //   noData == false;
    // });
    // final prefs = await SharedPreferences.getInstance();
    print('search');
    try {
      final data ={
        "work" : _searchController.text.trim(),
      };
      final response = await http.post(
        Uri.parse("https://justcalltest.onrender.com/api/users/getprofilebywork"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successfully sent data

        final fetch = json.decode( response.body);
        // print('search fetch : ${fetch }');

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
            _productsFuture = checkUser;
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
      width:  widthSize,
      padding: EdgeInsets.all( isMobile ? 8 : 15),
      child: Column(
        children: [
          Navbar(),
          SizedBox(height: 30,),
          Container(
            height: 100,
            color: Colors.deepOrange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 50,),
                Container(
                  width: widthSize * 0.50,
                  padding: EdgeInsets.all(2),
                  child: Material(
                    child:
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        labelText: "Please Enter a Keywords",
                        prefixIcon: Icon(Icons.search),
                        border: UnderlineInputBorder(
                        ),
                        labelStyle: GoogleFonts.josefinSans(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      // keyboardType: keyboardType,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter vaild search';
                        }
                        return null;
                      },
                    ),



                  ),

                ),
                SizedBox(width: 50,),
                Container(
                  height: 50,
                  width: 200,
                  child:
                  ElevatedButton(
                    onPressed: () {
                      // productDialog(context);
                      setState(() {
                        indicator = true;
                      });
                      searchUser();
                    },

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0),

                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(
                      //       0), // Set the border radius to 0 for a rectangular shape
                      // ),
                      backgroundColor: Colors.white,
                    ),
                    child:indicator == true
                        ? Center(
                        child: SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepOrange),
                            strokeWidth: 2.0,
                          ),
                        ))
                        :  Text(
                      "Search",
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
          SizedBox(height: 20,),
          noData == true ?
              Container(
                child: Text("Sorry, your request is not available",style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                  decoration: TextDecoration.none,
                )),
              ):
          Container(
            width: widthSize,
            height: heightSize * 0.60,

            child:   _productsFuture.isNotEmpty ?
            ListView.builder(
                itemCount: _productsFuture!.length,
                itemBuilder: (context, index) {
                  int serialNumber = index + 1;
                  return Container(
                    padding: EdgeInsets.all(20),
                    margin:  EdgeInsets.all(10) ,

                    decoration: BoxDecoration(
                      color: Color(0xFFFEFFD2),
                      borderRadius: BorderRadius.circular(0.0),
                      border: Border.all(
                        color: Colors.deepOrangeAccent,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: widthSize * 0.05,
                          child: Text('${serialNumber}',style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),

                        ),
                        Container(
                          width: widthSize * 0.20,
                          child: Text(_productsFuture![index]["firstname"] as String,style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),

                        ),
                        Container(
                          width: widthSize * 0.25,
                          child: Text(_productsFuture![index]["company"] as String,style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),

                        ),
                        Container(
                          // color: Colors.deepOrangeAccent,
                          width: widthSize * 0.25,
                          child: Text(_productsFuture![index]["work"] as String,style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),

                        ),
                        // Container(
                        //   width: heightSize * 0.20,
                        //   child: Text(_productsFuture![index]["url"] as String,style: GoogleFonts.poppins(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.black,
                        //     decoration: TextDecoration.none,
                        //   )),
                        //
                        // ),
                        // Container(
                        //   width: 100,
                        //   child: Text("Price",style: GoogleFonts.josefinSans(
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.green,
                        //     decoration: TextDecoration.none,
                        //   )),
                        // ),
                        // Container(
                        //   width: 100,
                        //   child: _productsFuture![index]["Image"] != null
                        //       ?
                        //
                        //   Image.memory(base64Decode(_productsFuture![index]["Image"]!.contains(',')  ? _productsFuture![index]["Image"].split(',')[1] : _productsFuture![index]["Image"]),
                        //     // Image.network( "https://justcalltest.onrender.com/productimages/${_productsFuture![index]["img"]}",
                        //     width: 50,
                        //     height: 50,
                        //     fit: BoxFit.contain,
                        //     errorBuilder: (context, error, stackTrace) {
                        //       return Container(
                        //         width: 50,
                        //         height: 50,
                        //         color: Colors.grey,
                        //         child: Center(
                        //           child: Icon(Icons.broken_image),
                        //         ),
                        //       );
                        //     },
                        //   )
                        //       : Container(
                        //     width: 100,
                        //     height: 50,
                        //     color: Colors.grey,
                        //     child: Center(
                        //       child: Text('No image',style: GoogleFonts.josefinSans(
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white,
                        //         decoration: TextDecoration.none,
                        //       )),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          width: widthSize * 0.15,
                          child: Center(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: (){
                                  // context.read<StringBloc>().add(SetString("encodedString"));
                                  context.read<StringBloc>().add(SetString(_productsFuture![index]["email"] as String));

                                  // var encodedString = _productsFuture![index]["email"] as String;
                                   var encodedString = "email";
                                  context.go("/profile/${encodedString}");
                                },
                                child: Text("View Profile",style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  decoration: TextDecoration.none,
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            :
            SizedBox(),
          )
        ],
      ),

    );
  }
}
