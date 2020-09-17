import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/products.dart';


class ProductDetailScreen extends StatelessWidget {

//final String title;
//final double price;


//ProductDetailScreen(this.title,this.price);

//static const routeNamed = '/productdetails';

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context).settings.arguments as String;
   final loadedproducts = Provider.of<Products>(context,listen: false,).findById(productid);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedproducts.title),
      ),
      body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                 Container(
            width: double.infinity,
            child: Image.network(loadedproducts.imageurl, fit: BoxFit.cover,),
           

          ),
          SizedBox(height: 10,),
          Text('\$${loadedproducts.price}',style: TextStyle()),

          Container(
            child: Text(loadedproducts.description,textAlign: TextAlign.center,style: TextStyle(fontSize: 20, ),
          )
             ),   ],
        ),
      ),
      
    );
  }
}