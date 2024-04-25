import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: ProfileForm(),
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _jobRole = '';
   File _image=File('');

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    // Request permission to access the device's gallery
    var status = await Permission.photos.request();
    if (status.isGranted) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              onTap: () async {
                getImage();
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image) : null,
                child: _image == null ? Image.asset('assets/profile_placeholder.png') : null,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone'),
              onChanged: (value) {
                setState(() {
                  _phone = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Job Role'),
              onChanged: (value) {
                setState(() {
                  _jobRole = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to save profile
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
