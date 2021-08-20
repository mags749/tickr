import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tickr/widgets/timeblock.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _inProgress = false;
  double _progress = 0;
  final _stepController = TextEditingController();
  int _stepDuration = 0;
  int _steps = 0;
  String _hour = '', _minute = '';
  TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);

  void _toggleCounter() {
    if (_steps == 0) {
      setState(() {
        _steps = int.parse(_stepController.text);
      });
    }
    if (!_inProgress)
      Timer.periodic(new Duration(seconds: _stepDuration), _decrementSteps);
    setState(() {
      _inProgress = !_inProgress;
    });
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  void _decrementSteps(Timer t) {
    if (!_inProgress) {
      t.cancel();
      setState(() {
        _inProgress = !_inProgress;
      });
    }
    setState(() {
      if (_steps == 0) {
        t.cancel();
        _steps = int.parse(_stepController.text);
      } else {
        playLocalAsset();
        _steps -= 1;
      }
    });
  }

  String _getStepCount() {
    try {
      double value =
          ((_selectedTime.hour * 60 * 60) + (_selectedTime.minute * 60)) /
              int.parse(_stepController.text);
      setState(() {
        _stepDuration = value.floor();
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
                        top: 5, left: 15, right: 15, bottom: 30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'tickr',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Time',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            GestureDetector(
                              child: TimeBlock(num: _hour),
                              onTap: () => _selectTime(context),
                            ),
                            GestureDetector(
                              child: TimeBlock(num: _minute),
                              onTap: () => _selectTime(context),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Steps",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width / 2 + 35,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red, //this has no effect
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                controller: _stepController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            child: LinearProgressIndicator(
                              value: _progress,
                              minHeight: 100.0,
                            ),
                          ),
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
                      _inProgress ? FeatherIcons.pause : FeatherIcons.play,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            if (_inProgress)
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

  playLocalAsset() {
    AudioCache cache = new AudioCache();
    cache.play('bell.mp3');
  }
}
