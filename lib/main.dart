import 'package:flutter/material.dart';
import 'package:shop/provider/auth.dart';
import 'package:shop/provider/cart.dart';
import 'package:shop/provider/order.dart';
import 'package:shop/screens/authscreen.dart';
import 'package:shop/screens/cartscreen.dart';
import 'package:shop/screens/editproductscreen.dart';
import 'package:shop/screens/orderscreen.dart';
import 'package:shop/screens/productoverviewscreen.dart';
import 'package:shop/screens/productdetailscreen.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/products.dart';
import 'package:shop/screens/userproductscreen.dart';
 
 

 void main() => runApp(MyApp());


 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MultiProvider(providers:  [
 ChangeNotifierProvider.value(
      value: Auth(),),

ChangeNotifierProvider.value(
      value: Products(),),
      ChangeNotifierProvider.value(
      value: Cart(),),
      ChangeNotifierProvider.value(value: Order(),),
     
     ], 
            child: MaterialApp(
         debugShowCheckedModeBanner: false,
         theme: ThemeData( primarySwatch: Colors.orange),
         home: AuthScreen(),
         routes: {
           ProductOverviewScreen.routeNeme : (ctx)=> ProductOverviewScreen(),
           '/productdetails': (ctx)=> ProductDetailScreen(),
           CartScreen.routename :(ctx)=> CartScreen(),
           OrderScreen.routeName: (ctx) => OrderScreen(),
           UserProductScreen.routeName: (ctx)=> UserProductScreen(),
           EditProductScreen.routeName : (ctx)=> EditProductScreen(),
           
         },
            
       ),
     );
   }
 }