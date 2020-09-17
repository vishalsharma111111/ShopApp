import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/cart.dart';
class CartItem extends StatelessWidget {

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  CartItem(this.id,this.productId,this.price,this.quantity,this.title);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(color: Colors.green,
      child: Icon(Icons.delete,color: Colors.white,size: 40, ) ,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5) 
      ,), 
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
       return showDialog(context: context, builder: (ctx) => AlertDialog(title: Text('Are you sure'),
        content: Text('Are you Sure you want to delete this item') ,
        actions: <Widget>[
          FlatButton(onPressed: (){
            Navigator.of(context).pop(false);
          }, child: Text('NO')),
          FlatButton(onPressed: (){
             Navigator.of(context).pop(true);
          }, child: Text('YES')),

        ],
        
        
        ));
      },
 onDismissed:(direction){ 
   Provider.of<Cart>(context).removeItem(productId);
 } ,
          child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
  child: Padding(padding: EdgeInsets.all(8),
  child:ListTile(
      leading: FittedBox(child: CircleAvatar(radius: 30,child: Text('\$${price.toString()}',style: TextStyle(color: Colors.orange),),)),
      title: Text(title),
      subtitle: Text('Total:\$${price * quantity}'),
      trailing: Text('$quantity x'),
  ) ,),
        
      ),
     
    );
  }
}