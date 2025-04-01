import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/home/argument_for_list.dart';

class StationListPage extends StatelessWidget{
  StationListPage({super.key});
  List<String> stations = [
    '수서', '동탄', '평택지제', '천안아산', '오송', '대전', '김천구미', '동대구', '경주', '울산', '부산'
  ];

  String? selectedStation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios)
        ),
        centerTitle: true,
        title: Text((ModalRoute.of(context)!.settings.arguments as ArgumentForList).title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...stationsWidget(context, stations)
        ],
      ),
    );
  }
}

List<Widget> stationsWidget(BuildContext context, List<String> stations){
  return stations
    .map((station) => stationListButton(context, station))
    .toList();
}

bool isSelected(String station,BuildContext context){
  if(station == (ModalRoute.of(context)!.settings.arguments as ArgumentForList).arrivals) return true;
  if(station == (ModalRoute.of(context)!.settings.arguments as ArgumentForList).departures) return true;

  return false;
}

Widget stationListButton(BuildContext context ,String station){
  return Container(
    decoration: BoxDecoration(
      color: isSelected(station,context) ?Colors.grey : Colors.white,
      border: Border(
        bottom: BorderSide(
          width: 0.5,
          color: Colors.grey[300]!
        )
      )
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
      onPressed: () {
        if(isSelected(station,context)){
          showCupertinoDialog(context: context, builder: (context){
            return CupertinoAlertDialog(
              title: Text('예약확인'),
              content: Text('이미 선택된 역입니다.'),
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
        } else {
          Navigator.pop(context, station);
        }
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          station,
          textAlign: TextAlign.left,
        ),
      ),
    ),
  );
}