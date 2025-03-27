import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
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
                selectArea(),
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

  SizedBox seatSelectButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onPressed: () {},
        child: Text("좌석 선택",
        style: TextStyle(
          color: Colors.white,
        ),),
      ),
    );
  }

  Container selectArea() {
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
        selectStation('출발역', '선택'),
        VerticalDivider(
          thickness: 3,
          indent: 70,
          endIndent: 70,
        ),
        selectStation('도착역', '선택'),
      ],),
    );
  }

  Expanded selectStation(String title, String selected) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$title",
          style: TextStyle(
            fontSize: 16,
          ),),
          Text("$selected",
          style: TextStyle(
            fontSize: 40,
          ),),
        ],
      ),
    );
  }
}