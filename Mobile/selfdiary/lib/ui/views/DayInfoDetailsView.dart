import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfdiary/core/models/dayInfoModel.dart';
import 'package:selfdiary/dateTimeExtensions.dart';
import 'package:selfdiary/ui/views/DayInfoEditView.dart';

import '../../core/viewmodels/CRUDModel.dart';

class DayInfoDetails extends StatelessWidget {
  final DayInfo dayInfo;

  DayInfoDetails({required this.dayInfo});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Hero(
          tag: 'day_date',
          child: Text(
              dayInfo.date.toStringShort(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 24,
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
            onPressed: ()async {
              await productProvider.removeProduct(dayInfo.id);
              Navigator.pop(context) ;
            },
          ),
          IconButton(
            iconSize: 24,
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> DayInfoEdit(dayInfo: dayInfo,)));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'day_text',
              child: Text(
                dayInfo.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}