import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/cartscreen.dart';
//import 'package:shop/screens/orderscreen.dart';
import 'package:shop/widgets/appdrawer.dart';
import 'package:shop/widgets/badge.dart';
//import 'package:shop/provider/product.dart';
import 'package:shop/widgets/productsgrid.dart';
import '../provider/cart.dart';
import '../provider/products.dart';
enum Filteroption{
  Favourite,
  All,
}


class ProductOverviewScreen extends StatefulWidget {
  static const routeNeme = '/productoverviewscreen';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}
class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavourite= false;
  var _isinit = true;
  var _isloading = false;

 @override
  void initState() {
   // Provider.of<Products>(context).fetchandsetproducts(); //won't work
   //Future.delayed(Duration.zero).then((_){
    // Provider.of<Products>(context).fetchandsetproducts();
  // });
    super.initState();
  }
@override
  void didChangeDependencies() {
   if(_isinit){
     setState(() {
       _isloading=true;
     });
  Provider.of<Products>(context).fetchandsetproducts().then((_){
    setState(() {
      _isloading= false;
    });
  });
   }
   _isinit=false;

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('myShop'),
actions: <Widget>[
  PopupMenuButton(onSelected: (Filteroption selectedvalue){
  setState(() {
    if(selectedvalue==Filteroption.Favourite){
      _showOnlyFavourite = true;

    }else{
      _showOnlyFavourite= false;
    }
  });
    },
    icon: Icon(Icons.more_vert),
    itemBuilder: (_)=>[
  PopupMenuItem(child: Text('Show Favourites'),value: Filteroption.Favourite,),
   PopupMenuItem(child: Text('Show all'),value: Filteroption.All,
   ),
    ]
    ),
     Consumer<Cart>(builder: (_,cart,ch)=>
     Badge(child: ch, value: cart.itemCount.toString()),
     child:  IconButton(icon: Icon(Icons.shopping_cart),
      onPressed: (){
        Navigator.of(context).pushNamed(CartScreen.routename);
      }),
     ) 
 
],
      ),
      drawer: AppDrawer(),
      body: _isloading?Center(child:CircularProgressIndicator() ): ProductsGrid(_showOnlyFavourite),
      
    );
  }
}

