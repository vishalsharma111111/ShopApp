//import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/auth.dart';

enum AuthMode{
  Register,
  Login,
  
}

class AuthScreen extends StatelessWidget {
  static const routename = 'authscreen';
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
   // final transformconfig= Matrix4.rotationZ(-8 * pi / 180);
  //  transformconfig.translate(-10.0);
    return Scaffold(

      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(215, 220, 130, 1).withOpacity(0.5),
             Color.fromRGBO(250, 170, 110, 1).withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              ),    
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: devicesize.height,
              width: devicesize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 94,),
                    transform: Matrix4.rotationZ(-8 * pi / 180) 
                    ..translate(-10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepOrange,
                      boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black54,
                        offset: Offset(0, 2),
                      )
                      ]
                    ),
                    child: Text('LIfeStyle',style: TextStyle( fontSize: 30),),

                  )),
                  Flexible(
                    flex: devicesize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                    )
                ],
              ),
            ),
          )
        ],
      ),
      
    );
  }
}
class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey <FormState> _formkey = GlobalKey();
  AuthMode _authmode = AuthMode.Login; 

    Map<String , String> _authdata = {
      'email': '',
      'password': '',
    };
    var _isloading = false;
    final _passwordcontroller = TextEditingController();
    Future <void>  _submit()async{
      if(!_formkey.currentState.validate()){

        return ;

      }
      _formkey.currentState.save();
      setState(() {
        _isloading = true;
      });
      if(_authmode== AuthMode.Login){
  await Provider.of<Auth>(context,listen: false).login(_authdata['email'],
       _authdata['password']);
      }else{
      await  Provider.of<Auth>(context,listen: false).register(_authdata['email'],
       _authdata['password']);

      }
      setState(() {
        _isloading = false;
      });
    }

void _switchauthmode(){
  if(_authmode == AuthMode.Login){
    setState(() {
      _authmode = AuthMode.Register;
    });
  }
  else{
    setState(() {
      _authmode = AuthMode.Login;
    });
  }
}


  @override
  Widget build(BuildContext context) {
      final devicesize = MediaQuery.of(context).size;
    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),

      ),
      elevation: 6.0,
      child: Container(
        height: _authmode ==AuthMode.Register ? 320 : 260,
        constraints: BoxConstraints(
          minHeight: _authmode ==AuthMode.Register ? 320 : 260, ),
          width: devicesize.height * 0.65,
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value.isEmpty || !value.contains('@')){
                        return 'invalid emailaddress';
                      }  
                    },
                    onSaved: (value){
                      _authdata['email']= value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                    controller: _passwordcontroller,
                    validator: (value){
                      if(value.isEmpty || value.length < 5){
                        return 'Password is short';
                      }     
                    },
                    onSaved: (value){
                      _authdata['password']= value;
                    },
                  ),
                  if(_authmode == AuthMode.Register)
                  TextFormField(
                    enabled: _authmode == AuthMode.Register,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                     ),
                     obscureText: true,
                     validator: _authmode == AuthMode.Register ? (value) {
                       if(value !=_passwordcontroller.text){
                         return ' Password do not match';
                       }
                     } : null,
              ),
              SizedBox(height: 20,),
              if(_isloading)
              CircularProgressIndicator()
              else
              RaisedButton(
                child: Text(_authmode== AuthMode.Login ? 'Login': 'Signup' ),
                
                
                
                onPressed: _submit, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                ),
                FlatButton(
                child: Text('${_authmode == AuthMode.Login ? 'Signup' :'Login' } INSTEAD'),
                onPressed: _switchauthmode, 
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
                

              
                ],
              ),
            ) ),
      ),
      
    );
  }
}