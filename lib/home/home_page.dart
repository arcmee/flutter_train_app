import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/Seat/seat_page.dart';
import 'package:flutter_train_app/home/argument_for_list.dart';
import 'package:flutter_train_app/station_list/station_list_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? departures;
  String? arrivals;

  void onDeparturesChanged(String departures){
    setState(() {
      this.departures = departures;
    });
  }

  void onArrivalsChanged(String arrivals){
    setState(() {
      this.arrivals = arrivals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("기차예매"),
          backgroundColor: Colors.blueAccent,
        ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                selectArea(context: context, departures: departures, arrivals: arrivals),
                SizedBox(height: 20,),
                seatSelectButton(),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget seatSelectButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onPressed: () {
          if(arrivals != null && departures != null){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SeatPage(departures!, arrivals!)),
            );
          } else {
            showCupertinoDialog(context: context, builder: (context){
              return CupertinoAlertDialog(
                title: Text('예약확인'),
                content: Text('역을 선택해 주세요'),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인'),
                  ),
                ],
              );
            });
          }
        },
        child: Text("좌석 선택",
        style: TextStyle(
          color: Colors.white,
        ),),
      ),
    );
  }

  Container selectArea({required BuildContext context, required String? departures, required String? arrivals}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 200,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        selectStation(title : '출발역',selected: departures ?? '선택',context: context, setStateFunction: onDeparturesChanged),
        VerticalDivider(
          thickness: 3,
          indent: 70,
          endIndent: 70,
        ),
        selectStation(title : '도착역',selected: arrivals ?? '선택',context: context, setStateFunction: onArrivalsChanged),
      ],),
    );
  }

  Expanded selectStation({required String title,required  String selected,required  BuildContext context,required Function setStateFunction}) {
    return Expanded(
      child: TextButton(
        onPressed: () async {
          String selected = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => StationListPage(),
            settings: RouteSettings(
              arguments: ArgumentForList(title, departures, arrivals),
            )),
          );
          setStateFunction(selected);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey
            ),),
            Text(selected,
            style: TextStyle(
              fontSize: 40,
              color: Colors.black
            ),),
          ],
        ),
      ),
    );
  }
}