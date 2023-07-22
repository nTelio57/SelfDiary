import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:selfdiary/core/models/dayInfoModel.dart';
import 'package:selfdiary/dateTimeExtensions.dart';

import '../../core/viewmodels/CRUDModel.dart';

class DayInfoDetails extends StatefulWidget {
  final DayInfo dayInfo;
  DayInfo? cachedDayInfo;

  DayInfoDetails({required this.dayInfo}){
    cachedDayInfo = DayInfo(dayInfo.id, dayInfo.userId, dayInfo.text, dayInfo.date, dayInfo.dayRating);
  }

  @override
  State<DayInfoDetails> createState() => _DayInfoDetailsState();
}

class _DayInfoDetailsState extends State<DayInfoDetails> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => onBackClicked(),
        ),
        title: Hero(
          tag: 'day_date',
          child: Text(
            widget.dayInfo.date!.toStringShort(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    initialValue: widget.dayInfo.text,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'I started my day with...',
                    ),
                    style: const TextStyle(
                      color: Colors.white
                    ),
                    minLines: 20,
                    maxLines: null,
                    onSaved: (value) => widget.dayInfo.text = value!,
                ),
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Day rating:'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: NumberPicker(
                    value: widget.dayInfo.dayRating!,
                    minValue: 0,
                    maxValue: 10,
                    axis: Axis.horizontal,
                    haptics: true,
                    onChanged: (value) {
                      setState(() {
                        widget.dayInfo.dayRating = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }

  void onBackClicked() async
  {
    final productProvider = Provider.of<CRUDModel>(context, listen: false);

    _formKey.currentState!.save();
    if(widget.cachedDayInfo != widget.dayInfo){
      if(widget.dayInfo.id == null){//Text changed on non existing id - need to add
        print('Text changed - adding');
        await productProvider.addProduct(widget.dayInfo);

      }else{//Text changed on existing id - need update
        print('Text changed - updating');
        await productProvider.updateProduct(widget.dayInfo, widget.dayInfo.id!);
      }
    }

    Navigator.pop(context) ;
  }
}