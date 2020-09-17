//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product.dart';
//import 'package:shop/screens/productdetailscreen.dart';
import 'package:shop/provider/cart.dart';

class ProductItem extends StatelessWidget {

//final String id;
//final String title;
//final String imageurl;
//ProductItem(this.id,this.title,this.imageurl);

  @override
  Widget build(BuildContext context) {
    final product= Provider.of<Product>(context,listen: false);
    final cart =Provider.of<Cart>(context,listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
            child: GridTile(
          child: GestureDetector( onTap: (){
            Navigator.of(context).pushNamed('/productdetails', arguments: product.id ,);
          },
            
            child: Image.network(product.imageurl, fit: BoxFit.cover,)),
          footer: GridTileBar(
            backgroundColor: Colors.black54,

            leading:Consumer<Product> (
      builder: (ctx,product,child)=>IconButton(
              icon: Icon(product.isfavourite? Icons.favorite: Icons.favorite_border), onPressed: ()
              {
                product.favStatus();
             },
            color: Colors.orange,),),
            title: Text(product.title,textAlign: TextAlign.center,) ,
            trailing: IconButton(
              icon: Icon( Icons.shopping_cart), onPressed: (){
                cart.additem(product.id, product.price, product.title,);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Add Item To Cart'),
                action: SnackBarAction(label: 'UNDO', onPressed: (){
                  cart.removeSingleItem(product.id);
                }),
                
                ));
              }, 
            color: Colors.orange,
      
          ),
          ),
        ),
      );
    
  }
}