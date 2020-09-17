import 'dart:convert';
//import 'dart:ffi';
//import 'dart:ffi';
import 'package:http/http.dart'as http;

import 'package:flutter/cupertino.dart';
import 'package:shop/models/httpexception.dart';

class Auth with ChangeNotifier{
String _token;
DateTime _expirydate;
String userid;

Future <void> _authanticate(String email , String password,String urlsegment ) async{
  final url ='https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key=AIzaSyDrsPpFyXEVGxj-GvSW7Ib3_uzyGIW7JsI';
  try{
     final response = await http.post(url,
  body:json.encode({
   'email': email,
   'password': password,
   'returnSecureToken': true,
 }));
final responsedata = json.decode(response.body);
if(responsedata['error'] !=null){
  throw HttpExecption();
}
  }catch(error){
    throw error;
  }


}

Future<void> register(String email , String password) async{
  //const signinURL='https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDrsPpFyXEVGxj-GvSW7Ib3_uzyGIW7JsI';
 return _authanticate(email, password,'signUp');
}
Future<void> login(String email , String password) async{
  //const signinURL='https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDrsPpFyXEVGxj-GvSW7Ib3_uzyGIW7JsI';
   return _authanticate(email, password,'signInWithPassword');
}
}