import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("data"),
          backgroundColor: Colors.blueAccent,
        ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text('text'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text("button")
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}