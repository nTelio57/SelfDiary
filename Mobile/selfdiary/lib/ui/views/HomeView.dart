import 'package:calendar_timeline/calendar_timeline.dart';
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
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addProduct');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'SELF DIARY',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: calendarSlider(),
    );
  }

  Widget cards()
  {
    final productProvider = Provider.of<CRUDModel>(context);

    return Container(
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
    );
  }

  Widget calendarSlider()
  {
    return CalendarTimeline(
      showYears: false,
      initialDate: _selectedDate,
      firstDate: DateTime.now().add(const Duration(days: 365 * 5 * -1)),
      lastDate: DateTime.now().add(const Duration(days: 2)),
      onDateSelected: (date) => setState(() => _selectedDate = date),
      leftMargin: MediaQuery.of(context).size.width/2 - 30,
      monthColor: Colors.white70,
      dayColor: Colors.teal[200],
      dayNameColor: const Color(0xFF333A47),
      activeDayColor: Colors.white,
      activeBackgroundDayColor: Colors.redAccent[100],
      dotsColor: Colors.redAccent[100],
      locale: 'en',
    );
  }
}