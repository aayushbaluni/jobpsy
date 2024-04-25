
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcard/tcard.dart';

import '../Services/ApiService.dart';
import 'EmployerDetails.dart';
import 'auth/Login.dart';
import 'jobsCard.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  TCardController _controller = TCardController();
  List cards=[] ;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var res=await getAllJobs();
    if(res?.statusCode==200){
      setState(() {
        var response=jsonDecode(res!.body);
        print(response['data']);
        cards=response['data'];
      });
    } else {

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: cards.length==0?Center(
          child: CircularProgressIndicator(),
        ):TCard(
          cards: cards.map((card) {
            return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: JobCard(jobInfo: card)
            );
          }).toList(),
          size: Size(300, 500),
          controller: _controller,
          onForward: (index, info) async {
            setState(() {
              _currentIndex = index;
            });
            if (info.direction == SwipDirection.Right) {
              var result=await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployerDetails(index: index,id: cards[index-1]['_id'],)),
              );
              if(!result){
                _controller.back();
              }
            }
          },
        ),
      ),
    );
  }
}




