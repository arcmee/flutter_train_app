import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Seat extends StatefulWidget{
  int row;
  int column;
  bool isSelected = false;
  Seat({required this.row
    ,required this.column
    ,required this.isSelected
    });

  String get seatNumber {
    return '${getColumnName()}-${row}';
  }

  String getColumnName(){
    switch(column){
      case 1:
        return 'A';
      case 2:
        return 'B';
      case 3:
        return 'C';
      case 4:
        return 'D';
      default:
        return 'A';
    }
  }

  // void Function(Seat seat) onTapped;

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  double size = 60;

  void switchSelected(){
    widget.isSelected = widget.isSelected ? false : true;
  }

  void onTapped() {
    setState(() {
      switchSelected();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: GestureDetector(
          onTap: onTapped
        ),
      ),
    );
  }
}