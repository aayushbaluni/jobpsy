import 'dart:convert';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jobpsy/components/CreateJob.dart';
import 'package:jobpsy/components/CreateResume.dart';
import 'package:jobpsy/components/RequestPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/AppliedJobs.dart';
import 'components/EmployerDetails.dart';
import 'components/Profile.dart';
import 'components/auth/Login.dart';
import 'components/jobsCard.dart';
import 'components/SwipePage.dart';
import 'Services/ApiService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? data = prefs.getString('userInfo');
  runApp(MyApp(data: data));
}

class MyApp extends StatelessWidget {
  final String? data;

  const MyApp({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jobpsy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: data == null ? LoginPage() : MainScreen(),
      // home:ResumeScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  dynamic? data;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    getSharedPref();
  }
  Future<void> getSharedPref()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? temp = prefs.getString('userInfo');
      if(temp!=null){
        data=jsonDecode(temp);
        print("ROLE + ${data['role']}");
      }
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobpsy'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body:data==null?Center(
        child: CircularProgressIndicator()  ,
      ) : PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          SwipePage(),
         data==null || data['role']=='user'?const AppliedJobs():CreateJob(),
          // Comment out this Container or adjust its size to ensure it doesn't cover the bottom navigation bar
          // Container(
          //   color: Colors.green,
          //   child: Center(
          //     child: Text('Chat Page', style: TextStyle(color: Colors.white)),
          //   ),
          // ),
          RequestPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          Icons.home,
          Icons.add,
          Icons.chat,
          Icons.person,
        ],
        activeIndex: _currentIndex,
        gapLocation: GapLocation.none,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index); // Jump to the selected page
          });
        },
      ),
    );
  }
}