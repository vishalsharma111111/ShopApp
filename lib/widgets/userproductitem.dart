import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/products.dart';
import 'package:shop/screens/editproductscreen.dart';
class UserProductItem extends StatelessWidget {
    final String id;
  final String title;
  final String imageurl;

 
UserProductItem(  this.id  ,this.title,this.imageurl,);


  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile (title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageurl),),
      trailing: Container(
        width: 100,
              child: Row(children: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: (){
      Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
          }),
          IconButton(icon: Icon(Icons.delete), onPressed: () async{
            try{
           await  Provider.of<Products>(context,listen: false).deleteproduct(id);
            }
            catch(error){
         scaffold.showSnackBar(SnackBar(content: Text('deleting Products failed')));
            }
          
          }),
        ],),
      ),
      
    );
  }
}