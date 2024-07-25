import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:justcall/screens/productdashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _LoginState();
}

class _LoginState extends State<Edit> {

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _workController = TextEditingController();
  final _websiteUrlController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _workController.dispose();
    _websiteUrlController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return
      Container(
      // margin: EdgeInsets.all,
      color: Color(0xFFE1F0DA),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFormField(
                controller: _firstNameController,
                label: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _lastNameController,
                label: 'Last Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _companyController,
                label: 'Company',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your company';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _workController,
                label: 'Work',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your work';
                  }
                  return null;
                },
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
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Submit'),
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
            labelStyle:GoogleFonts.josefinSans(
              fontSize : 18 ,
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
