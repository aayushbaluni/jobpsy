
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobpsy/Services/ApiService.dart';
import 'package:jobpsy/components/auth/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../SwipePage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigate to forgot password page
                    // You should implement the forgot password page separately
                  },
                  child: Text('Forgot Password?'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                     try{
                       var data={
                         'email':_emailController.text.toString(),
                         'password':_passwordController.text.toString()
                       };
                       var res=await loginUser(data);
                       var resBody=jsonDecode(res!.body);
                       if(res!.statusCode==200){
                         String responseBody = jsonEncode(resBody);

                         // Store the JSON response body string in SharedPreferences
                         SharedPreferences prefs = await SharedPreferences.getInstance();
                         await prefs.setString('userInfo', responseBody);

                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                             content: Text(resBody['message']),
                           ),
                         );
                         Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(
                             builder: (context) => MainScreen(),
                           ),
                         );
                       } else {
                         showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             return AlertDialog(
                               title: Text('Error Logged In'),
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
                             title: Text('Error Logging In'),
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
                  child: Text('Login'),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to registration page
                    // You should implement the registration page separately
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                  },
                  child: Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}