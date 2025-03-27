import 'dart:ffi';

import 'package:flutter/material.dart';

class SeatPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {}, 
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
                  stationText('수서'),
                  Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 30,
                  ),
                  stationText('부산'),
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
                  Text('선택됨')
              ],),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: GridView.count(
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 8,
                    crossAxisCount: 5,
                    children: List.generate(100, (index) {
                        if((index + 3 )% 5 == 0){
                          return Text(((index + 3 )/ 5).floor().toString());
                        }
                        return seatSquare(20, false);
                      }
                    ),
                  )
                )
              ),
          ],),
        )
      ),
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

  Container seatSquare(double size, bool isSelected) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

