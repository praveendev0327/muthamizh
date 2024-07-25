import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:html' as html;

import 'package:google_fonts/google_fonts.dart';

class JobPost extends StatefulWidget {
  const JobPost({super.key});

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool? indicator = false;

  Future<void> addJobPost() async {

    final Data = {
      "email" : "praveen@gmail.com",
      "title" : titleController.text.trim(),
      "description" : descController.text.trim(),
    };
    // print('Data sent successfully');
    try {
      final uri = 'https://justcalltest.onrender.com/api/users/createJobPostMV';

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
        // context.go("/profile/${value}");
        print('Data sent successfully ');
        setState(() {
          indicator = false;
        });
        Navigator.of(context).pop();
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
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height * 0.60,
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Enter Details",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
            controller: titleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            controller: descController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
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
          // }
          addJobPost();
          setState(() {
            indicator = true;
          });

        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Set the border radius to 0 for a rectangular shape
          ), backgroundColor: Colors.deepOrange,
          minimumSize: Size(double.infinity, 50),
        ),
        child: indicator == true ?
        Center(child:
        SizedBox(
          height: 10,
          width: 10,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2.0,
          ),
        )) :
        Text('Submit',
          style: GoogleFonts.teko(
            fontSize : 22 ,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),),
      ),
        ],
      ),
    );
  }
}
