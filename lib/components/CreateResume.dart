import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_resume_template/flutter_resume_template.dart';
import 'package:path_provider/path_provider.dart';

import '../data/data.dart';

class ResumeScreen extends StatefulWidget {
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  var index = 0;
  late TemplateTheme theme =list[index];

  List<TemplateTheme> list = [
    TemplateTheme.modern,
    TemplateTheme.technical,
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index1) {
    setState(() {
        _selectedIndex = index1;
      if (_selectedIndex == 0) {
        // ScaffoldMessenger.of(context).showSnackBar(
          // const SnackBar(content: Text('Download tapped')),
        // );
      } else if (_selectedIndex == 1) {
        // ScaffoldMessenger.of(context).showSnackBar(
          // const SnackBar(content: Text('Next tapped')),

        // );
        // Increment index and handle looping back to the first item
        print(index);
        index = (index + 1) % list.length;
        theme = list[index];
        print(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resume Builder'),
        ),
        body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FlutterResumeTemplate(
              data: data,
              templateTheme: theme,
              mode: TemplateMode.onlyEditableMode,
              showButtons: false,
              imageBoxFit: BoxFit.cover,
              
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.file_download),
              label: 'Download',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigate_next),
              label: 'Next',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
