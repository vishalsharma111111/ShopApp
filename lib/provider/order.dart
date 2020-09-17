import 'package:flutter/material.dart';
import 'package:shop/provider/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class OrderItem {

final String id;
final double amount;
final List<CartItem> products;
final DateTime dateTime;


OrderItem({@required this.id,
 @required this.amount,
 @required this.products,
 @required this.dateTime,
 });
}
class Order with ChangeNotifier{
  List<OrderItem> _order = [];


  List<OrderItem> get orders {
    return [..._order];
  }
  Future <void> fetchandsetorder() async{
     const url = 'https://vish-df12e.firebaseio.com/orders.json';
    final response = await http.get(url);
    final List<OrderItem> loadedorder =[];
    final extracteddata = json.decode(response.body) as Map<String,dynamic>;
    if(extracteddata == null){
      return ;
    }
   extracteddata.forEach((orderid, orderdata){
  loadedorder.add(OrderItem(id: orderid,
   amount: orderdata['amount'],
   products: (orderdata['products'] as List <dynamic>).map((item)=>
   CartItem(id: item['id'], 
   title: item['title'],
    quantity: item['quantity'], 
    price: item['price'])
   ).toList() ,
    dateTime: DateTime.parse(orderdata['datetime'])));
   });
   _order = loadedorder.reversed.toList();
   notifyListeners();
  }


  
  Future <void> addOrder(List<CartItem> cartproducts, double total) async{
     const url = 'https://vish-df12e.firebaseio.com/orders.json';
     final timestamp = DateTime.now();
    final response = await http.post(url,body: json.encode({
       'amount': total,
       'datetime':timestamp.toIso8601String(),
       'products': cartproducts.map((cp) => {
       'id': cp.id ,
       'title': cp.title ,
       'quantity': cp.quantity ,
       'price': cp.price,
       }).toList()
       
     }));
  _order.insert(0, 
  OrderItem(id: json.decode(response.body)['name'], amount: total, dateTime: timestamp,products: cartproducts));

  notifyListeners();
  }




}