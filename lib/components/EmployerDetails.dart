import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobpsy/Services/ApiService.dart';

class EmployerDetails extends StatefulWidget {
  final int index;
  final String id;

  const EmployerDetails({Key? key, required this.index, required this.id}) : super(key: key);

  @override
  _EmployerDetailsState createState() => _EmployerDetailsState();
}

class _EmployerDetailsState extends State<EmployerDetails> {
  var jobDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getJobDetails();
  }

  void getJobDetails() async {
    var res = await getJobById(widget.id);
    if (res?.statusCode == 200) {
      var responseBody = jsonDecode(res!.body);

      setState(() {
        jobDetails = responseBody['data'];
        isLoading = false;
      });
    } else {
      print(res?.body);
    }
  }

  Future<bool> handleApplyJob() async {
    var res = await applyJob(widget.id);
    if (res?.statusCode == 200) {
      var resBody = jsonDecode(res!.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['message']),
        ),
      );
      return true;
    } else {
      print(res!.body);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Employer Details'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200],
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  jobDetails['title'],
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Text(
                  "Company: ${jobDetails['company']}",
                  style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                ),
                Text(
                  jobDetails['description'],
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Location: ${jobDetails['location']}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  "Expected Salary: ${jobDetails['salary']}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  "Qualification Required: ${jobDetails['qualification']}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  "Job Type: ${jobDetails['jobType']}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  "Experience Required: ${jobDetails['experience']}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false); // Navigate back without changing the index
                  },
                  child: Text('Go Back'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    var hasApplied = await handleApplyJob();
                    if (hasApplied) {
                      Navigator.pop(context, true); // Navigate back and increase the index
                    }
                  },
                  child: Text('Apply!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
