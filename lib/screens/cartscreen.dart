//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/cart.dart' show Cart;
import 'package:shop/provider/order.dart';
import 'package:shop/widgets/cartitem.dart' ;

class CartScreen extends StatelessWidget {
  static const routename ='/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            
            margin: EdgeInsets.all(10),
          child:Padding(padding: EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('total' ,style: TextStyle(fontSize: 20),),
              Spacer(),
              SizedBox(width: 10,),
              Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}')),
              Orderbutton(cart: cart),
              
            ],
          ),),
            
          ),
          SizedBox(height: 20,),
          Expanded(child: ListView.builder(itemCount: cart.items.length,
          itemBuilder: (ctx,i)=>CartItem(cart.items.values.toList()[i].id,
          cart.items.keys.toList()[i],
          cart.items.values.toList()[i].price
          ,cart.items.values.toList()[i].quantity,
          cart.items.values.toList()[i].title)   ,))
        ],
      ),
      
    );
  }
}

class Orderbutton extends StatefulWidget {
  const Orderbutton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderbuttonState createState() => _OrderbuttonState();
}

class _OrderbuttonState extends State<Orderbutton> {
    var _isloading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton( onPressed: widget.cart.totalAmount <=0 || _isloading ? null: () async{
  setState(() {
    _isloading = true;
  });
    await Provider.of<Order>(context,listen: false).addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount);
      setState(() {
         _isloading = false;
      });
      widget.cart.clear();
    }
    
    
    
    , child: _isloading? CircularProgressIndicator(): Text('Order now',style: TextStyle(color: Colors.orange),));
  }
}