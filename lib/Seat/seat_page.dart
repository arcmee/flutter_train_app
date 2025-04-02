import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/Seat/Seat.dart';

class SeatPage extends StatefulWidget{
  String arrivals;
  String departures;

  SeatPage(this.departures, this.arrivals);

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  late List<Seat> seats = [];
  int seatRows = 4;
  int seatColumns = 20;

  _SeatPageState(){
    setSeats();
  }

  // void onSeatSelect(Seat selected){
  //   setState(() {
  //     selected.switchSelected();
  //   });
  // }

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
        title: Text('좌석 선택'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  stationText(widget.departures),
                  Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 30,
                  ),
                  stationText(widget.arrivals),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatSquare(24, true),
                  SizedBox(width: 4),
                  Text('선택됨'),
                  SizedBox(width: 20),
                  seatSquare(24, false),
                  SizedBox(width: 4),
                  Text('선택 안됨')
              ],),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  columnName('A', 60, 30),
                  columnName('B', 60, 30),
                  columnName(' ', 60, 30),
                  columnName('C', 60, 30),
                  columnName('D', 60, 30),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ...seats.where((seat) => seat.column == 1)
                        ],
                      ),
                      Column(
                        children: [
                          ...seats.where((seat) => seat.column == 2)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(seatColumns, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: columnName('${index+1}', 60, 60),
                            );
                          }),
                        ],
                      ),
                      Column(
                        children: [
                          ...seats.where((seat) => seat.column == 3)
                        ],
                      ),
                      Column(
                        children: [
                          ...seats.where((seat) => seat.column == 4)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              reserveButton(context),
              SizedBox(height: 50,),
          ],),
        )
      ),
    );
  }

  SizedBox reserveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onPressed: () {
          showCupertinoDialog(context: context, builder: (context){
            if(getSelectedSeat().isEmpty){
              return CupertinoAlertDialog(
                title: Text('예약확인'),
                content: Text('선택된 좌석이 없습니다.'),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인'),
                  )
                ],
              );
            } else {
              String selected = getSelectedSeat().fold('', (prev, next) {
                return prev + next.seatNumber + ' ';
              });
              return CupertinoAlertDialog(
                title: Text('예약확인'),
                content: Text('''$selected
  예약 하시겠습니까?'''),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text('확인'),
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('취소'),
                  )
                ],
              );
            }
          });
        }, 
        child: Text(
          '예매하기',
          style: TextStyle(
            color : Colors.white
          ),
        ),
      ),
    );
  }

  Container columnName(String name, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.amber,
      ),
      width: width ,
      height: height,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 18,
          ),
        )
      )
    );
  }

Widget stationText(String station) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Text(
      station,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.purple,
        fontSize: 30,
      ),
    ),
  );
}

  void setSeats(){
    for(int col = 1; col < seatColumns + 1; col++){
      for(int row = 1; row < seatRows + 1; row++){
        seats.add(Seat(row : col, column : row, isSelected: false, ));
      }
    }
  }

  List<Seat> getSelectedSeat(){
    return seats.where((seat) => seat.isSelected ).toList();
  }

}

Widget seatRowNumber(int index){
  return Center(
    child: Text(((index + 3 )/ 5).floor().toString())
  );
}

Widget seatSquare(double size,bool isSelected ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
