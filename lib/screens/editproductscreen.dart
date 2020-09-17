import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product.dart';
import '../provider/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editproductscreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
 // TextEditingController controllerPrvate = TextEditingController(text: "Hint Custom");
  final _pricefocusnode = FocusNode();
   final _descriptionfocusnode = FocusNode();
   final _imageurlcontroller = TextEditingController();
   final _imageurlfocusnode = FocusNode();
   final _form = GlobalKey<FormState>();
   var _editedproduct = Product(id: null, title: '',price: 0 ,description: '' , imageurl: '',);
   var _isinit = true;
   var _isloading = false;
   var _initvalues = {
     'title':'',
     'description':'',
     'price':'',
     'imageurl':'',
   };
      @override
  void dispose() {
      _imageurlfocusnode.removeListener(_updateimageurl);
    _pricefocusnode.dispose();
    _descriptionfocusnode.dispose();
    _imageurlcontroller.dispose();
   _imageurlfocusnode.dispose();
    super.dispose();
  }
  @override
  void initState() {
     _imageurlfocusnode.addListener(_updateimageurl);
    super.initState();
  }


void didChangeDependencies() {
   if(_isinit){
    final productId = ModalRoute.of(context).settings.arguments as String;
if (productId != null){
    _editedproduct = Provider.of<Products>(context,listen: false).findById(productId);
  _initvalues={
  'title':_editedproduct.title,
 'description':_editedproduct.description,
  'price':_editedproduct.price.toString(),
  //'imageurl': _editedproduct.imageurl,
 'imageurl': '',
  };
    _imageurlcontroller.text = _editedproduct.imageurl;
  }
  }

  _isinit = false;
  super.didChangeDependencies();

}

void _updateimageurl(){
  
  if(!_imageurlfocusnode.hasFocus){
     if( ( !_imageurlcontroller.text.startsWith('http')&& !_imageurlcontroller.text.startsWith('https')) /* ||
    ( !_imageurlcontroller.text.endsWith('.png')&&!_imageurlcontroller.text.endsWith('jpg')&&!_imageurlcontroller.text.endsWith('jpeg')) */){
      return ;  }
  setState(() {});
  }
}
Future <void> _saveform() async{
  setState(() {
    _isloading = true;
  });
  final isvalid=_form.currentState.validate();
  if (!isvalid){
    return;
  }
  _form.currentState.save();
  if (_editedproduct.id != null){
    await Provider.of<Products>(context,listen: false).updateproduct(_editedproduct.id, _editedproduct);
    
  }else{
    try{
 await Provider.of<Products>(context,listen: false)
  .addProduct(_editedproduct);
    }
 
  catch(error){

 await showDialog(context: context, builder: (ctx)=> AlertDialog(
      title: Text('An error occured'),
      content: Text('Something went Wrong'),
      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.of(ctx).pop();
        }, child: Text('Okay'))
      ],
    )
  );
  }
/* finally{
 setState(() {
    _isloading = false;
  });
     Navigator.of(context).pop();
  } */ 
  }
  setState(() {
        _isloading = false;
    });
    Navigator.of(context).pop();

 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveform,)
        ],
      ),
      body: _isloading ? Center(child: CircularProgressIndicator(),): Padding(
           padding: const EdgeInsets.all(16.0),
              child: Form( key: _form , child: ListView(children: <Widget>[
          TextFormField( 
             initialValue: _initvalues['title'],
               decoration: InputDecoration(labelText: 'title'),
               textInputAction: TextInputAction.next,
          onFieldSubmitted: (_){
           FocusScope.of(context).requestFocus(_pricefocusnode);
          },
          validator: (value){
            if(value.isEmpty){
           return 'Please Provide a value';
           }
             return null;
            
          },
          onSaved: (value){
           _editedproduct = Product( title: value,price: _editedproduct.price, description: 
            _editedproduct.description, imageurl: _editedproduct.imageurl,
            id: _editedproduct.id, isfavourite: _editedproduct.isfavourite);
          },
          ),
          TextFormField(
             
              initialValue: _initvalues['price'],
             decoration: InputDecoration(labelText: 'price'),
               textInputAction: TextInputAction.next,
               keyboardType: TextInputType.number,
               focusNode: _pricefocusnode,
               onFieldSubmitted: (_){
            FocusScope.of(context).requestFocus(_descriptionfocusnode);
          },
            validator: (value){
            if(value.isEmpty){
              return 'Please enter a price';
            }
            if(double.tryParse(value)==null){
              return 'Please enter a valid number';
            }
            if(double.parse(value)<=0){
              return 'Please enter a number greater than zero';
            }
              return null;
            
          },
           onSaved: (value){
            _editedproduct = Product( title: _editedproduct.title,  price:  double.parse(value),description: 
            _editedproduct.description, imageurl: _editedproduct.imageurl,
            id: _editedproduct.id, isfavourite: _editedproduct.isfavourite);
          },
          
            
          ),
          
          TextFormField( 
          
             initialValue: _initvalues['description'],
         decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          keyboardType: TextInputType.multiline, 
          focusNode: _descriptionfocusnode,
           validator: (value){
            if(value.isEmpty){
             return 'Please enter Description';
            }
            if(value.length<10){
              return 'Value should be atleast 10 character';
            }
            return null;
          },

          onSaved: (value){
            _editedproduct = Product( title: _editedproduct.title,  price: _editedproduct.price,
            description: value , imageurl: _editedproduct.imageurl,
             id: _editedproduct.id, isfavourite: _editedproduct.isfavourite);
          },
          
          
           ),
           Row(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: <Widget>[
               Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 8,right: 10),
                decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey)),
                child:  _imageurlcontroller.text.isEmpty? 
                Text('Enter a Url '):FittedBox(
                  child: Image.network( _imageurlcontroller.text,fit: BoxFit.cover,),),
                
                ),
               Expanded(
                       child: TextFormField(
                              //   initialValue: _initvalues['imageurl'],
              
                 decoration: InputDecoration(labelText: 'ImageUrl'),
                 keyboardType: TextInputType.url,
                 textInputAction: TextInputAction.done,
                 controller: _imageurlcontroller,
                 focusNode: _imageurlfocusnode,

                 onFieldSubmitted:(_){ 
                    _saveform();
                    },
                    validator: (value){
                     if(value.isEmpty){
                        return 'Please enter a Url';
                     }
                   /* if(!value.startsWith('http') && !value.startsWith('https')){
                        return'Please enter a valid Url';
                     }
                    if(!value.endsWith('.png') && !value.endsWith('jpg') && !value.endsWith('jpeg')){
                       return 'Please enter a valid image Url';
                      } */
                      return null;
                    },

                    
                    onSaved: (value){
            _editedproduct = Product( title: _editedproduct.title, price:_editedproduct.price, description: 
            _editedproduct.description, imageurl: value,
             id: _editedproduct.id, isfavourite: _editedproduct.isfavourite);
          },
          
                      
                    ),
               ),
             ],
           )
        ],)),
      ),
      
    );
  }
} 