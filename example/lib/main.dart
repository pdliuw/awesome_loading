import 'dart:ui';

import 'package:awesome_loading/awesome_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  static const double MAX = 10.0;
  static const double MIN = 1.0;
  static int _divisions = 99;

  double _progressValue = 1;
  double _slideValue = MAX;

  AnimationController _controller;
  Animation<Color> _colorTween;

  AwesomeLoadingRoute _awesomeLoadingRoute;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _colorTween = _controller.drive(ColorTween(
      begin: Colors.grey,
      end: Colors.green,
    ));
    _controller.value = _progressValue;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    Paint paint = Paint();

    paint..isAntiAlias = true;
  }

  loadingChange(double value) {
    setState(() {
      _slideValue = _segmentValue / 10;
      _progressValue = (value / 100);
      _controller.value = _progressValue;
    });
  }

  void _incrementCounter() {
    _awesomeLoadingRoute = AwesomeLoadingRoute(builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            print("click");
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(5),
                          child: CircularProgressIndicator(
                            value: _segmentValue / 10,
                            strokeWidth: 5.0,
                            valueColor: _colorTween,
                          ),
                        ),
                        Text("${_segmentValue / 10 * 100}%"),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(5),
                          child: CircularStateProgressIndicator(
                            size: Size(100, 100),
                            value: _segmentValue / 10 * 100, //1~100
                            pathColor: Colors.white,
                            valueColor:
                                ColorTween(begin: Colors.grey, end: Colors.blue)
                                    .transform(_segmentValue / 10),
                            pathStrokeWidth: 10.0,
                            valueStrokeWidth: 10.0,
                          ),
                        ),
                        Text("${_segmentValue / 10 * 100}%"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
    Navigator.push(context, _awesomeLoadingRoute);
  }

  Map<int, Widget> _segmentChildren = {
    1: Text("1"),
    2: Text("2"),
    3: Text("3"),
    4: Text("4"),
    5: Text("5"),
    6: Text("6"),
    7: Text("7"),
    8: Text("8"),
    9: Text("9"),
    10: Text("10"),
  };
  int _segmentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CupertinoSegmentedControl(
                    padding: EdgeInsets.all(5),
                    children: _segmentChildren,
                    onValueChanged: (int index) {
                      setState(() {
                        _segmentValue = index;
                        AwesomeLoadingViewModel.getInstance().notify();
                      });
                    },
                    groupValue: _segmentValue,
                  ),
                ),
              ],
            ),
            Align(
              child: Text("$_segmentValue"),
            ),
            Slider(
              min: MIN,
              max: MAX,
              value: _segmentValue.toDouble(),
              onChanged: (double newValue) {
                setState(() {
                  _segmentValue = newValue.toInt();
                  AwesomeLoadingViewModel.getInstance().notify();
                });
              },
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.all(5),
                  child: CircularProgressIndicator(
                    value: _segmentValue / 10,
                    strokeWidth: 10.0,
                    valueColor: _colorTween,
                  ),
                ),
                Text("${_segmentValue / 10 * 100}%"),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.all(5),
                  child: CircularStateProgressIndicator(
                    size: Size(150, 150),
                    value: _segmentValue / 10 * 100, //1~100
                    pathColor: Colors.white,
                    valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                        .transform(_segmentValue / 10),
                    pathStrokeWidth: 10.0,
                    valueStrokeWidth: 10.0,
                    useCenter: false,
                    fill: false,
                  ),
                ),
                Text("${_segmentValue / 10 * 100}%"),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.all(5),
                  child: CircularStateProgressIndicator(
                    size: Size(150, 150),
                    value: _segmentValue / 10 * 100, //1~100
                    pathColor: Colors.white,
                    valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                        .transform(_segmentValue / 10),
                    pathStrokeWidth: 10.0,
                    valueStrokeWidth: 10.0,
                    useCenter: true,
                    fill: true,
                  ),
                ),
                Text("${_segmentValue / 10 * 100}%"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  padding: EdgeInsets.all(5),
                  child: LinearProgressIndicator(
                    value: _segmentValue / 10,
                    valueColor: _colorTween,
                  ),
                ),
                Text("${_segmentValue / 10 * 100}%"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
