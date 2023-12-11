import 'dart:io';

import 'package:flutter/material.dart';

class DetailsPageWidget extends StatefulWidget {
  final String name;
  final String age;
  final String cls;
  final String phone;
  final dynamic image;

  const DetailsPageWidget({
    Key? key,
    required this.name,
    required this.age,
    required this.cls,
    required this.phone,
    required this.image,
  }) : super(key: key);

  @override
  State<DetailsPageWidget> createState() => _DetailsPageWidgetState();
}

class _DetailsPageWidgetState extends State<DetailsPageWidget> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 223, 82),
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center( 
        child: Container(
          margin: EdgeInsets.all(90),
          child: Column(
            children: [
              CircleAvatar(
                    radius: 90,
                    backgroundImage: FileImage(File(widget.image))
              ),
              SizedBox(height: 20),
              Card(
                elevation: 7,
                color: Colors.amber,
                child: Text('Name: ${widget.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: Text('Age: ${widget.age}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Card(
                child: Text('Course: ${widget.cls}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Card(
                child: Text('Phone: ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Card(
                child: Text('${widget.phone}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}