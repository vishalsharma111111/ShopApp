import 'dart:convert';
import 'dart:io';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import './product.dart';
//import '../models/httpexception.dart';
class Products with ChangeNotifier {
  List <Product> _items= [
   /* Product(
 id : 'p1',
 title : 'Red Shirt',
 description :' A Red Shirt - it is a pretty loook',
 price : 599.9,
 imageurl: 'https://assets.myntassets.com/dpr_2,q_60,w_210,c_limit,fl_progressive/assets/images/2284527/2019/7/12/cca418b8-c5fc-4358-9d2b-2391741cd3b81562928750923-Roadster-Men-Red-Regular-Fit-Checked-Casual-Shirt-1141562928-1.jpg'
),
Product(
 id : 'p2',
 title : 'Blue jeans',
 description : 'WROGN Men Blue Slim Fit Acid Wash Clean Look Jeans',
 price : 599.9,
 imageurl: 'https://assets.myntassets.com/h_480,q_95,w_360/v1/assets/images/1502358/2016/11/9/11478687842321-WROGN-Men-Blue-Slim-Fit-Acid-Wash-Clean-Look-Jeans-5581478687842037-1.jpg',
),

Product(
id: 'p3',
title: 'T Stirt',
description : 'Roadster Men Black Solid Round Neck T-shirt',
price : 499.1,
imageurl : 'https://assets.myntassets.com/h_480,q_100,w_360/v1/assets/images/2297736/2018/3/10/11520676710686-Roadster-Men-Black-Solid-Round-Neck-T-shirt-9611520676710424-1.jpg'

),

Product(
  id: 'p4',
  title : 'Trouser',
  description : ' A pair of teal blue slim fit mid-rise trousers',
  price : 999,
  imageurl : 'https://i5.walmartimages.com/asr/05a51216-14b3-4198-9f15-248d589668ed_1.d68901cd479adb6f17e5dee8cf0b7fdd.jpeg?odnHeight=2000&odnWidth=2000&odnBg=ffffff',
),
Product(id: 'p5', title: 'Nike Shoes', description: 'NIB Nike Air Max AXIS Running Cross Training Shoes Reax Torch Sneaker', price: 1999, imageurl: 'https://i.ebayimg.com/images/g/AWgAAOSwoV5dI4kD/s-l640.jpg',),
Product(id: 'p6', title: 'Puma SHoes', description: 'Puma Sneakers at Journeys! FREE shipping on orders over and easy in-store returns. Shop the new Mens Puma Storm Origin ...', price: 3000, imageurl: 'https://images.journeys.com/images/products/1_568879_ZM_ALT2.JPG',),
*/
];
  List <Product> get items {
    return [..._items];

  }
  List <Product> get favouriteitems{
    return [...items].where((proditem)=>proditem.isfavourite).toList();
  }
   

  Product findById(String id){
    return _items.firstWhere((prod)=> prod.id==id);

  }

  Future <void> fetchandsetproducts() async{
const url = 'https://vish-df12e.firebaseio.com/products.json';
try{
final response = await http.get(url);

final extractdata = json.decode(response.body) as Map<String , dynamic>;
if (extractdata==null){
  return ;
}
final List<Product>  loadedproducts =[];
extractdata.forEach((prodid,proddata){
  loadedproducts.add(Product(
  id: prodid, 
  title: proddata['title'],
   description: proddata['description'],
   imageurl: proddata['imageurl'],
   price: proddata['price'],
   isfavourite: proddata['isfavourite']));

});
_items=loadedproducts;
notifyListeners();
}
catch(error){
  throw(error);
}

  }


Future<void> addProduct(Product product) async{
  const url = 'https://vish-df12e.firebaseio.com/products.json';
  try {
   final response = await http.post(url,body: json.encode({
    'title': product.title,
    'description': product.description,
    'imageurl': product.imageurl,
    'price': product.price,
    'isfavourite': product.isfavourite,
}));
final newproduct = Product(
   title: product.title, description:  product.description, price:  product.price,
    imageurl:  product.imageurl,id: json.decode(response.body)['name'],);
    _items.add(newproduct);

  notifyListeners();
  }
  catch(error){
    throw error;
  }
 
}

Future <void> updateproduct(String id, Product newproduct)async{
 final prodindex= _items.indexWhere((prod)=>prod.id == id);
 if(prodindex >= 0){
     final url = 'https://vish-df12e.firebaseio.com/products/$id.json';
     await http.patch(url, body: json.encode({
  'title' : newproduct.title,
  'description': newproduct.description,
  'imageurl' : newproduct.imageurl,
  'price': newproduct.price,
     }));
 _items[prodindex]= newproduct;
 notifyListeners();
 }
else{
print('...');
}
}
 Future<void> deleteproduct(String id) async {
    final url = 'https://flutter-update.firebaseio.com/products/$id';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
   
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 600) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    
    existingProduct = null;
  }
}