import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _steps = 0;
  int _stepDuration = 0;
  final _stepController = TextEditingController();
  String _hour = '', _minute = '';
  TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);

  void _toggleCounter() {
    Timer.periodic(new Duration(seconds: _stepDuration), _decrementSteps);
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  void _decrementSteps(Timer t) {
    if (_steps == 0) {
      t.cancel();
      setState(() {
        _steps = int.parse(_stepController.text);
      });
    } else
      setState(() {
        _steps--;
      });
  }

  String _getStepCount() {
    try {
      double value =
          ((_selectedTime.hour * 60 * 60) + (_selectedTime.minute * 60)) /
              int.parse(_stepController.text);
      setState(() {
        _stepDuration = value.floor();
        _steps = int.parse(_stepController.text);
      });
      return value.floor().toString();
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(
                        top: 0, left: 15, right: 15, bottom: 30),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 50,
                          color: Colors.black.withOpacity(0.23),
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Time'),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () => _selectTime(context),
                              child: Text('Save'),
                              style: OutlinedButton.styleFrom(
                                primary: Theme.of(context).accentColor,
                                minimumSize: Size(88, 36),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text("Steps"),
                        TextField(
                          controller: _stepController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 2 - 20,
                  height: 60,
                  width: 60,
                  child: FloatingActionButton(
                    onPressed: _toggleCounter,
                    tooltip: 'Start',
                    child: Icon(
                      FeatherIcons.play,
                      size: 30,
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '$_steps',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text('Steps')
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        _getStepCount(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text('sec/Step')
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _hour = _selectedTime.hour.toString();
        _minute = _selectedTime.minute.toString();
      });
    }
  }
}
