//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Product with ChangeNotifier{

final String id;
final String title;
final String description;
final double price;
final String imageurl;
bool isfavourite;

Product({

@required this.id,
@required this.title,
@required this.description,
@required this.price,
@required this.imageurl,
this.isfavourite = false,


 });
  void favStatus() async{
    final oldstatus = isfavourite;
    if(isfavourite){
      isfavourite=false;
    }else{
      isfavourite=true;
    }
//    isfavourite = !isfavourite;
    notifyListeners();
    final url = 'https://vish-df12e.firebaseio.com/products/$id.json';
    try{
  final response = await  http.patch(url,body: json.encode({
   'isfavourite': isfavourite,
    }));
    if(response.statusCode >= 400){
        isfavourite = oldstatus;

    }

    }
    catch(error){
      isfavourite = oldstatus;
      notifyListeners();
    }
 
  }



}