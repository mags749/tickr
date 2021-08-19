import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _steps = 0;

  void _incrementCounter() {
    setState(() {
      _steps++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_steps',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 30),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width / 2 - 20,
              height: 60,
              width: 60,
              child: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Start',
                child: Icon(Icons.play_arrow_outlined),
                backgroundColor: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
