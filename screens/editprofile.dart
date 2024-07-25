import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:muthamizh/components/navbar.dart';
// import 'package:justcall/screens/productdashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _LoginState();
}

class _LoginState extends State<EditProfile> {
  late Timer _timer;
  int _currentIndex = 0;

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _workController = TextEditingController();
  final _websiteUrlController = TextEditingController();
  final _addressController = TextEditingController();
  String? base64Image;
  late final FirebaseAuth _firebaseAuth;
  final fn = FocusNode();
  bool screenChangeStatus = false;
  bool? indicator = false;
  Uint8List? _imageData;
  List<String> _imageUrls = [
    'assets/a7.jpeg',

    // 'assets/gr5.jpg'
    // Add more image URLs as needed
  ];
  html.File? _selectedFiles;
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _workController.dispose();
    _websiteUrlController.dispose();
    _addressController.dispose();
    super.dispose();
  }


  void _pickFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        setState(() {
          _selectedFiles = files.first;
          _readFile(_selectedFiles!);
        });
      }
    });

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsDataUrl(file);

        reader.onLoadEnd.listen((event) {
          setState(() {
            base64Image = reader.result as String?;
          });
        });
      }
    });
  }

  void _readFile(html.File file) {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((e) {
      setState(() {
        _imageData = reader.result as Uint8List?;
      });
    });
  }

  Future<void> createProfile(BuildContext context) async {

    final Data = {
      "firstname" : _firstNameController.text.trim(),
      "lastname" : _lastNameController.text.trim(),
      "email" : _emailController.text.trim(),
      "image" : base64Image,
      "company" : _companyController.text.trim(),
      "work" : _workController.text.trim(),
      "url" : _websiteUrlController.text.trim(),
      "address" : _addressController.text.trim()
    };
    // print('Data sent successfully');
    try {
      final uri = 'https://justcalltest.onrender.com/api/users/createProfileMV';

      final response = await  http.post(
        Uri.parse( uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Data),
      );

      if (response.statusCode == 200) {
        final fetch = json.decode( response.body);
        // print('login fetch : ${fetch[0] }');

        final value = fetch["data"];
        // Successfully sent data
        // context.go('/profile/${5}');
        context.go("/profile/${value}");
        print('Data sent successfully ');
        setState(() {
          indicator = false;
        });
      } else {
        // Error occurred while sending data
        print('Failed to send profile data: ${response.statusCode}');
        setState(() {
          indicator = false;
        });
      }
    } catch (e) {
      // Exception occurred
      setState(() {
        indicator = false;
      });
      print('Exception occurred: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 900;
    final FocusNode _focusNode = FocusNode();

    return Scaffold(
      body:Container(
        color: Color(0xFFE1F0DA),
        height: MediaQuery.of(context).size.height,
        width: isMobile ? widthSize : MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 40,
              // ),
              Navbar(),
              // Container(
              //   child: Center(
              //     child: Text("EDIT PROFILE",
              //         style: GoogleFonts.josefinSans(
              //           fontSize: 28,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black,
              //           decoration: TextDecoration.none,
              //         )),
              //     // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
              //   ),
              // ),
            SizedBox(
                      height: 0,
                    ),

              Container(
                width: isMobile ? widthSize : widthSize * 0.70,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // _imageData == null ?
                              // Container(
                              //     height: 50,
                              //     width: 50,
                              //     child: Icon(Icons.person)) :
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: _imageData != null ? MemoryImage(_imageData!) : null,
                                child: _imageData == null ? Icon(Icons.person, size: 50) : null,
                                // backgroundImage:
                                // Image.memory(_imageData!, height: 100, width: 100),
                                // AssetImage("assets/t2.jpeg"), // Replace with your image path
                              ),
                              GestureDetector(
                                onTap: _pickFile,
                                child: Container(
                                  height: 50,
                                    width: 50,
                                    child: Icon(Icons.edit)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: widthSize * 0.30,
                              child: _buildTextFormField(
                                controller: _firstNameController,
                                label: 'First Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: widthSize * 0.30,
                              child: _buildTextFormField(
                                controller: _lastNameController,
                                label: 'Last Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: widthSize * 0.30,
                              child: _buildTextFormField(
                                controller: _emailController,
                                label: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: widthSize * 0.30,
                              child: _buildTextFormField(
                                controller: _phoneController,
                                label: 'Phone Number',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your company';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                             width: widthSize * 0.30,
                             child: _buildTextFormField(
                               controller: _companyController,
                               label: 'Company Name',
                               validator: (value) {
                                 if (value == null || value.isEmpty) {
                                   return 'Please enter your company';
                                 }
                                 return null;
                               },
                             ),
                           ),
                           SizedBox(width: 10,),
                           Container(
                             width: widthSize * 0.30,
                             child: _buildTextFormField(
                               controller: _workController,
                               label: 'Professional',
                               validator: (value) {
                                 if (value == null || value.isEmpty) {
                                   return 'Please enter your work';
                                 }
                                 return null;
                               },
                             ),
                           ),
                         ],
                       ),
                        _buildTextFormField(
                          controller: _websiteUrlController,
                          label: 'Website URL',
                          keyboardType: TextInputType.url,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your website URL';
                            } else if (!Uri.parse(value).isAbsolute) {
                              return 'Please enter a valid URL';
                            }
                            return null;
                          },
                        ),
                        _buildTextFormField(
                          controller: _addressController,
                          label: 'Address',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            //   // print('login Successfully');
                            //   // screenChangeStatus ? _signUp() : _signIn();
                            //
                            //
                            // }
                            setState(() {
                              indicator = true;
                            });

                            createProfile( context);
                            // setState(() {
                            //   indicator = true;
                            // });
                            // loginUser();
                            // context.go("/admin");
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  0), // Set the border radius to 0 for a rectangular shape
                            ),
                            backgroundColor: Colors.deepOrange,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: indicator == true
                              ? Center(
                              child: SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 2.0,
                                ),
                              ))
                              : Text(
                            'Submit',
                            style: GoogleFonts.teko(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFE1F0DA),
            labelText: label,
            border: UnderlineInputBorder(),
            labelStyle: GoogleFonts.josefinSans(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
              decoration: TextDecoration.none,
            ),
          ),
          keyboardType: keyboardType,
          validator: validator,
        ),
      ),
    );
  }
}
