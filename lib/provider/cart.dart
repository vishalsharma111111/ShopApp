//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:provider/provider.dart';
//import './products.dart';

class CartItem{

final String id;
final String title;

final int quantity;

final double price;


CartItem({
  @required this.id,
   @required this.title,
    @required this.quantity,
     @required this.price,  
  });

}

class Cart with ChangeNotifier{

  Map<String,CartItem> _items = {};
    Map<String,CartItem> get items{
      return {..._items};
    }

int get itemCount {
  return _items.length;

}

double get totalAmount {
  var total=0.0;
  _items.forEach((key,cartitem){
  total += cartitem.price*cartitem.quantity;
  });
return total;

}


  void additem(String productId,double price,String title,)
  {
  if(_items.containsKey(productId)){
    _items.update(productId, (existingCartItem)=>CartItem(id:existingCartItem.id,
    title: existingCartItem.title,
    price: existingCartItem.price,
    quantity: existingCartItem.quantity +1));

  }
  else{
    _items.putIfAbsent(productId,()=>
     CartItem(id: DateTime.now().toString(), 
     title: title,price: price,quantity: 1,),);
  }
  notifyListeners();
  }
  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();

  }
  
  void removeSingleItem(String productid){
    if(_items.containsKey(productid)){
      return;
    }if(_items[productid].quantity > 1)
    {
      _items.update(productid, (exitingCartItem)=> CartItem(id: exitingCartItem.id,
       title: exitingCartItem.title,
        price: exitingCartItem.price,
        quantity: exitingCartItem.quantity -1, 
       ));

    }
     
     else{
       _items.remove(productid);

     }
     notifyListeners();

  }
  void clear(){
    _items={};
    notifyListeners();
  }


}