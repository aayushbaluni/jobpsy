import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final Map<String, dynamic> jobInfo;

  const JobCard({Key? key, required this.jobInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              jobInfo['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Text(
              'Company: ${jobInfo['company']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            child: Text(
              'Category: ${jobInfo['jobCategory']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            child: Text(
              'Location: ${jobInfo['location']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            child: Text(
              'Salary: ${jobInfo['salary']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
