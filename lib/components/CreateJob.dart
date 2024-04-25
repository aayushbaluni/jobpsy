import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jobpsy/components/SwipePage.dart';
import 'package:jobpsy/main.dart';

import '../Services/ApiService.dart';

class CreateJob extends StatefulWidget {
  @override
  _CreateJobState createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';
  String location = '';
  String salary = '';
  String company = '';
  String jobCategory = '';
  String jobType = '';
  String experience = '';
  String qualification = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    title = value!;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value!;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    location = value!;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Salary'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a salary';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    salary = value!;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Company'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a company';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    company = value!;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Job Category'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a job category';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    jobCategory = value!;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Job Type'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a job type';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    jobType = value!;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Experience'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter experience level';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    experience = value!;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Qualification'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter qualification';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    qualification = value!;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final jobDetails = {
                        'title': title,
                        'description': description,
                        'location': location,
                        'salary': salary,
                        'company': company,
                        'jobCategory': jobCategory,
                        'jobType': jobType,
                        'experience': experience,
                        'qualification': qualification,
                      };
                        var res=await createJob(jobDetails);
                        if(res?.statusCode==200){
                          print(res?.body);
                          var resBody = jsonDecode(res!.body);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(resBody['message']),
                            ),
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                        } else {
                          print(res?.body);
                        }
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
