import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobpsy/Services/ApiService.dart';
import 'package:jobpsy/components/Profile.dart';
import 'package:jobpsy/components/auth/Login.dart';

class Register extends StatelessWidget {
  const Register({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController=TextEditingController();
  String _role = 'user'; // Default role is user

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Name';
                          }
                          // You can add more email validation here if needed
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add more email validation here if needed
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          // You can add more password validation here if needed
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Radio buttons for selecting role
                      ListTile(
                        title: Text('User'),
                        leading: Radio(
                          value: 'user',
                          groupValue: _role,
                          onChanged: (value) {
                            setState(() {
                              _role = value.toString();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Employer'),
                        leading: Radio(
                          value: 'employer',
                          groupValue: _role,
                          onChanged: (value) {
                            setState(() {
                              _role = value.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                          try{
                            var data={
                          "name":_nameController.text.toString(),
                          "email":_emailController.text.toString(),
                          "password":_passwordController.text.toString(),
                          "role":_role.toString()
                          };
                            var res=await registerUser(data);
                            var resBody=jsonDecode(res!.body);
                            if(res?.statusCode==200){

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(resBody['message']),
                                ),
                              );
                              Navigator.push  (
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Error Registering User'),
                                    content: Text(resBody['message'].toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } catch(e){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Error Registering User'),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );

                          }

                          }
                        },
                        child: Text('Register'),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                          // You should implement the login page separately
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Text('Already have an account? Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
