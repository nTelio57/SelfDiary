import 'package:flutter/material.dart';
import 'package:selfdiary/ui/views/DayInfoDetailsView.dart';

import '../../core/models/dayInfoModel.dart';

class DayInfoCard extends StatelessWidget {
  final DayInfo dayInfoDetails;

  DayInfoCard({required this.dayInfoDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => DayInfoDetails(dayInfo: dayInfoDetails)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 5,
          child: SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.45,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: dayInfoDetails.id!,
                  child: Text(
                      dayInfoDetails.id!
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        dayInfoDetails.text!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}