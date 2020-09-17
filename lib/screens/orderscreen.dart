import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/order.dart' show Order;
import 'package:shop/widgets/appdrawer.dart';
import '../widgets/orderitem.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orderscreen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isloading = false;
  @override
  void initState() {
   // Future.delayed(Duration.zero).then((_) async{
    _isloading = true;
     
    Provider.of<Order>(context,  listen: false).fetchandsetorder().then((_){
       setState(() {
        _isloading = false;
    });
      

    });
   //   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderdata = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Order'),),
      drawer: AppDrawer(),
      body:_isloading ? Center(child: CircularProgressIndicator(),): ListView.builder(
        itemCount: orderdata.orders.length,
        itemBuilder: (ctx,i) => OrderItem(orderdata.orders[i])) ,
      
    );
  }
}