import 'package:flutter/material.dart';
//import 'package:shop/models/product.dart';
import 'package:shop/widgets/productitem.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/products.dart';
class ProductsGrid extends StatelessWidget {
  final bool showfav;
 ProductsGrid(this.showfav);
 

  @override
  Widget build(BuildContext context) {


    final productData  =Provider.of<Products>(context );
    final products = showfav? productData.favouriteitems:productData.items;
    return GridView.builder(

     padding: EdgeInsets.all(10),
     itemCount: products.length,
     itemBuilder: (ctx,i)=> ChangeNotifierProvider.value(
       value: products[i],                //builder: (c)=>products[i],
            child: ProductItem(
          // products[i].id,
           //products[i].title,
          // products[i].imageurl,),
     ),),
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
        childAspectRatio: 3/2,crossAxisSpacing: 10,
        mainAxisSpacing: 10,),
     
    );
  }
}