import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:jobpsy/Services/ApiService.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({Key? key});

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  late List<dynamic> appliedJobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getJobs();
  }

  void getJobs() async {
    var res = await getAppliedJobs();
    if (res?.statusCode == 200) {
      var resBody = jsonDecode(res!.body);
      setState(() {
        appliedJobs = resBody['data'];
        print(appliedJobs);
        isLoading = false; // Set isLoading to false when data is fetched
      });
    } else {
      print('Error + ${res?.body}');
      setState(() {
        isLoading = false; // Set isLoading to false in case of error
      });
    }
  }

  String calculateDaysAgo(String createdAt) {
    DateTime createdAtDate = DateTime.parse(createdAt);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(createdAtDate);
    int days = difference.inDays;
    if(days==0){
      return 'Today';
    }
    if (days == 1) {
      return '1 day ago';
    } else {
      return '$days days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(), // Show loader while fetching data
      )
          : appliedJobs.isEmpty
          ? Center(
        child: Text(
          'No jobs available',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.separated(
        itemCount: appliedJobs.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          var job = appliedJobs[index]['job'];
          return ListTile(
            title: Text(
              job['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job['company'],
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                appliedJobs[index]['appliedOn']!=null? Text(
                  'Applied ${calculateDaysAgo(appliedJobs[index]['appliedOn'])}',
                  style: TextStyle(color: Colors.grey[600]),
                ):SizedBox(

               ),
              ],
            ),
            onTap: () {
              // Handle tapping on the job tile
            },
          );
        },
      ),
    );
  }
}
