import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:selfdiary/core/models/dayInfoModel.dart';
import 'package:selfdiary/dateTimeExtensions.dart';
import 'package:selfdiary/welcome_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/viewmodels/CRUDModel.dart';
import 'DayInfoDetailsView.dart';

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

  DayInfo? selectedDay()
  {
    if(dayInfos != null) {
        var dayInfo = dayInfos!.firstWhereOrNull((x) => x.isDateEqual(_selectedDate));
        if(dayInfo != null){
          return dayInfo;
        }else{
          return DayInfo(null, FirebaseAuth.instance.currentUser!.uid, '', _selectedDate, 0);
        }
    }
    return DayInfo(null, FirebaseAuth.instance.currentUser!.uid,'', _selectedDate, 0);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: selectedDay()!.isDateEqual(DateTime.now()) ? null :  FloatingActionButton(
        onPressed: () {
          setState(() {
            _resetSelectedDate();
          });
        },
        child: const Icon(Icons.redo)
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => signOut(),
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
        title: const Text(
          'SELF DIARY',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: body(),
    );
  }

  Widget body()
  {
    final productProvider = Provider.of<CRUDModel>(context);

    return StreamBuilder(
        stream: productProvider.fetchProductsAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            dayInfos = snapshot.data?.docs
                .map((doc) => DayInfo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                .where((element) => element.userId == FirebaseAuth.instance.currentUser!.uid)
                .toList();
            return Column(
              children: [
                calendarSlider(),
                const SizedBox(height: 20),
                selectedDayCard(),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    'Day rating:'.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                chart()
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 8,
              )
            );
          }
        });
  }

  void onDateSelected(DateTime date)
  {
    _selectedDate = date;
  }

  Widget calendarSlider()
  {
    return CalendarTimeline(
      showYears: false,
      initialDate: _selectedDate,
      firstDate: DateTime.now().add(const Duration(days: 365 * 5 * -1)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      onDateSelected: (date) => setState(() => onDateSelected(date)),
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

  Widget selectedDayCard()
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => DayInfoDetails(dayInfo: selectedDay()!)));
        },
        child: Card(
          elevation: 5,
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: 'day_date',
                        child: Text(
                          _selectedDate.toStringShort(locale: 'en'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        ('${selectedDay()!.dayRating} / 10'),
                        style: const TextStyle(
                          fontSize: 14
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Text(
                    selectedDay()!.id == null || selectedDay()!.text!.isEmpty ? 'Not filled yet' : selectedDay()!.text!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget chart()
  {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: SfCartesianChart(
        margin: const EdgeInsets.only(top: 16, right: 16, left: 8, bottom: 8),
        primaryYAxis: NumericAxis(
          maximum: 10,
          interval: 1
        ),
        primaryXAxis: NumericAxis(
          interval: 1
        ),
        series: <SplineSeries<DayInfo, int>>[
          SplineSeries(
            splineType: SplineType.monotonic,
            dataSource: getDataSource(),
            xValueMapper: (DayInfo dayInfo, _) => dayInfo.date!.day,
            yValueMapper: (DayInfo dayInfo, _) => dayInfo.dayRating,
            emptyPointSettings: EmptyPointSettings(
              mode: EmptyPointMode.zero
            )
          )
        ],
      ),
    );
  }

  List<DayInfo> getDataSource() {
    List<DayInfo> result = [];
    int dataCount = 5;
    int offset = (dataCount / 2).floor();

    for(DateTime i = _selectedDate.add(Duration(days: -offset)); i.compareTo(_selectedDate.add(Duration(days: offset+1))) < 0; i = i.add(const Duration(days: 1))){
      DayInfo? existingDay = dayInfos!.firstWhereOrNull((element) => element.isDateEqual(i));
      existingDay ??= DayInfo(null, '', '', i, null);
      result.add(existingDay);
    }
    return result;
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const WelcomeView()), (value) => false);
  }
}