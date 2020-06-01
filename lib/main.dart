import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int hour=0;
  int min=0;
  int sec=0;
  int TimeForTimer=0;
  String timetodisplay="";

  void start(){
    TimeForTimer = (hour*60*60)+(min*60)+sec;
    Timer.periodic(Duration(seconds: 1),(Timer t){
      setState(() {
        if(TimeForTimer < 1){
          t.cancel();
          timetodisplay="";
          if (TimeForTimer==0){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Timer App",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                  content: new Text("No Time Remaning",style: TextStyle(fontSize: 20,color: Colors.white),),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Ok",style: TextStyle(fontSize: 20,color: Colors.red),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
        else if (TimeForTimer<60){
          timetodisplay = TimeForTimer.toString();
          TimeForTimer=TimeForTimer-1;
        }
        else if (TimeForTimer < 3600){
          int m=TimeForTimer~/60;
          int s=TimeForTimer-(60*m);
          timetodisplay=m.toString()+":"+s.toString();
        }
        else {
          int h=TimeForTimer~/3600;
          int t=TimeForTimer-(3600*h);
          int m=t~/60;
          int s=t-(60*m);
          timetodisplay=h.toString()+":"+m.toString()+":"+s.toString();
          TimeForTimer=TimeForTimer-1;
          }
      });
    } );
  }
  void reset(){
    setState(() {
      TimeForTimer=0;
      timetodisplay="";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Timer App",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
        centerTitle: true,
      ),
      body: new Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("HH",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      ),
                      NumberPicker.integer(
                          initialValue: hour,
                          minValue: 0,
                          maxValue: 23,
                          onChanged: (val){
                            setState(() {
                              hour=val;
                            });
                          }
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("MM",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      ),
                      NumberPicker.integer(
                          initialValue: min,
                          minValue: 0,
                          maxValue: 60,
                          onChanged: (val){
                            setState(() {
                              min=val;
                            });
                          }
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("SS",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      ),
                      NumberPicker.integer(
                          initialValue: sec,
                          minValue: 0,
                          maxValue: 60,
                          onChanged: (val){
                            setState(() {
                              sec=val;
                            });
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
            new Expanded(
              flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Time Remaining:",style: TextStyle(fontSize: 30,color: Colors.white,),),
                    new Text(timetodisplay,style:TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                )
            ),
            new Expanded(
              flex: 1,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      child:
                      Text("START",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                      color: Colors.green,
                      onPressed: start,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    new RaisedButton(
                      child:
                      Text("RESET",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                      color: Colors.red,
                      onPressed: reset,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    )
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}


