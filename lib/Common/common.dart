import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  String? data= prefs.getString('userInfo');
 if(data != null){
   var temp=json.decode(data);
   print(temp);
   return temp['token'];
 } else {
   return null;
 }
}

Map<String, String> setHeaders(token){
  var headers = <String, String>{
    'Authorization': 'Bearer $token'
  };
  return headers;
}