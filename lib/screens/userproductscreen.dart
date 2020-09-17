//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/products.dart';
import 'package:shop/widgets/userproductitem.dart';
import '../screens/editproductscreen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userproductscreen';

  Future<void> _refreshproducts ( BuildContext context)async{
 await Provider.of<Products>(context).fetchandsetproducts();
  }
 
  @override
  Widget build(BuildContext context) {
     final productsData = Provider.of<Products>(context);
    return RefreshIndicator(
      onRefresh: () => _refreshproducts(context),
          child: Scaffold(
        appBar: AppBar(title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.add), onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          }),
        ],
        ),

        body: Padding(padding: 
        EdgeInsets.all(8),
        child: ListView.builder( itemCount: productsData.items.length, itemBuilder: (_, i)=>
          UserProductItem(productsData.items[i].id,productsData.items[i].title, productsData.items[i].imageurl, ),
        ),
        ),
        
      ),
    );
  }
}