import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:html' as html;

import 'package:google_fonts/google_fonts.dart';
class FilePickers extends StatefulWidget {
  const FilePickers({super.key});

  @override
  State<FilePickers> createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePickers> {
  String? base64Image;
  File? _file;
  html.File? _selectedFiles;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx']);

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_file == null) return;

    final bytes = await _file!.readAsBytes();
    final base64String = base64Encode(bytes);
    final filename = _file!.path.split('/').last;

    final uri = Uri.parse('http://localhost:3000/upload');
    // final response = await http.post(
    //   uri,
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({'base64String': base64String, 'filename': filename}),
    // );
    //
    // if (response.statusCode == 200) {
    //   print('File uploaded successfully');
    // } else {
    //   print('File upload failed');
    // }
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
              // // showPopup(context);
              // _pickImage();
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
            },
            child: Container(
              height: 40,
              width: 200,
              color: Colors.deepOrange,
              child: Center(
                child: Text("Upload",
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
