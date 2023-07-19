import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/dayInfoModel.dart';
import '../../core/viewmodels/CRUDModel.dart';

class DayInfoEdit extends StatefulWidget {
  final DayInfo dayInfo;

  DayInfoEdit({required this.dayInfo});

  @override
  _ModifyProductState createState() => _ModifyProductState();
}

class _ModifyProductState extends State<DayInfoEdit> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    //productType =  widget.dayInfo.img[0].toUpperCase() + widget.dayInfo.img.substring(1);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Modify Product Details'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.dayInfo.id,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Product Title',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Product Title';
                    }
                  },
                  //onSaved: (value) => title = value!
              ),
              /*SizedBox(height: 16,),
              TextFormField(
                  initialValue: widget.dayInfo.price,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Price',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter The price';
                    }
                  },
                  onSaved: (value) => price = value
              ),
              DropdownButton<String>(
                value: productType,
                onChanged: (String newValue) {
                  setState(() {
                    productType = newValue;
                  });
                },
                items: <String>['Bag', 'Computer', 'Dress', 'Phone','Shoes']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await productProvider.updateProduct(Product(name: title,price: price,img: productType.toLowerCase()),widget.dayInfo.id);
                    Navigator.pop(context) ;
                  }
                },
                child: Text('Modify Product', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )
*/
            ],
          ),
        ),
      ),
    );
  }
}