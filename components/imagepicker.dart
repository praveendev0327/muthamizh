import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:html' as html;

import 'package:google_fonts/google_fonts.dart';
class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  String? base64Image;
  Uint8List? _imageValue;
  html.File? _selectedFiles;
  bool? indicator = false;
  void _pickImage() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        setState(() {
          _selectedFiles = files.first;
          _readImage(_selectedFiles!);
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

  void _readImage(html.File file) {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((e) {
      setState(() {
        _imageValue = reader.result as Uint8List?;
      });
    });
  }

  Future<void> uploadBanners() async {

    final Data = {

      "email" : "praven@gmail.com",
      "image" : base64Image,

    };
    // print('Data sent successfully');
    try {
      final uri = 'https://justcalltest.onrender.com/api/users/createBannersMV';

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
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Add Banners",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                )),
            // Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
          ),
          // if (_imageValue != null) ...[
          //   SizedBox(height: 20),
          //   Image.memory(_imageValue!, height: 100, width: 100),
          // ],
          base64Image != null ?
          Image.memory(base64Decode(base64Image!.split(',')[1]),width: 100,height: 100,) : SizedBox(),
          base64Image != null ? SizedBox()
          : Text("No Banner",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                decoration: TextDecoration.none,
              )),
          GestureDetector(
            onTap: () {
              // showPopup(context);
              _pickImage();
            },
            child: Container(
              height: 40,
              width: 200,
              color: Colors.grey,
              child: Center(
                child: Text("Choose Banner",
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
              // showPopup(context);
              setState(() {
                indicator = true;
              });
              uploadBanners();
            },
            child: Container(
              height: 40,
              width: 200,
              color: Colors.deepOrange,
              child: Center(
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
                    : Text("Upload Banner",
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
    );
  }
}
