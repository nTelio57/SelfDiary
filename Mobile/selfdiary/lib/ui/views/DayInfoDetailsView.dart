import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfdiary/core/models/dayInfoModel.dart';
import 'package:selfdiary/ui/views/DayInfoEditView.dart';

import '../../core/viewmodels/CRUDModel.dart';

class DayInfoDetails extends StatelessWidget {
  final DayInfo dayInfo;

  DayInfoDetails({required this.dayInfo});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: <Widget>[

          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: ()async {
              await productProvider.removeProduct(dayInfo.id);
              Navigator.pop(context) ;
            },
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> DayInfoEdit(dayInfo: dayInfo,)));
            },
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: dayInfo.id,
            child: Text(
                dayInfo.id
            ),
          ),
          SizedBox(
            height: 20
          ),
          Text(
            dayInfo.id,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          Text(
            '${dayInfo.id} \$',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic,
                color: Colors.orangeAccent),
          )
        ],
      ),
    );
  }
}