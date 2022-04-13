import 'package:flutter/material.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({ Key? key }) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Statistic'),
      ),
    );
  }
}