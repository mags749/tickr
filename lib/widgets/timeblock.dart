import 'package:flutter/material.dart';

class TimeBlock extends StatelessWidget {
  const TimeBlock({
    Key? key,
    required String num,
  })  : _num = num,
        super(key: key);

  final String _num;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor.withOpacity(0.8),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_num',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
