import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:selfdiary/core/models/dayInfoModel.dart';
import 'package:selfdiary/ui/widgets/dayInfoCard.dart';

import '../../core/viewmodels/CRUDModel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<DayInfo>? dayInfos;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addProduct');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('Home')),
      ),
      body: Container(
        child: StreamBuilder(
            stream: productProvider.fetchProductsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                dayInfos = snapshot.data?.docs
                    .map((doc) => DayInfo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                    .toList();
                return ListView.builder(
                  itemCount: dayInfos?.length,
                  itemBuilder: (buildContext, index) =>
                      DayInfoCard(dayInfoDetails: dayInfos![index]),
                );
              } else {
                return Text('fetching');
              }
            }),
      ),
    );
    ;
  }
}