import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({Key key,@required this.child , @required this.value, this.color})
  :super(key: key);
  final Widget child;
  final String value;
 final Color color;
 @override
  Widget build(BuildContext context) {
  
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child, Positioned( right: 8 , top: 8, 
        child:Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color!=null  ?color:Colors.orange,
          ),
          constraints: BoxConstraints(
            minHeight: 16,minWidth: 16,
            
          ),
          child: Text(value,textAlign: TextAlign.center,),
        ) )
      ],
    );
  }

}