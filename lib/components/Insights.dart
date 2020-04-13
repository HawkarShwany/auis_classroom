import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:fl_chart/fl_chart.dart';

class Insights extends StatefulWidget {
  final courseId;
  final data;
  Insights(this.data, this.courseId);
  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  int numOfStudnets;
  int numOfFiles;
  int numOfTypes;
  List<PieChartSectionData> chartsections = [];
  List<Color> colors = [
    KYellow,
    KGreen,
    Colors.deepPurple,
    KBlue,
    Colors.yellowAccent,
    Colors.white,
    KPrimaryColor,
    Colors.amberAccent
  ];

  void parseData(dynamic data) {
    chartsections.removeRange(0, chartsections.length);
    numOfStudnets = int.parse(data['numOfStudents']);
    numOfFiles = int.parse(data['numOfFiles']);
    numOfTypes = int.parse(data['numOfTypes']);

    for (var i = 0; i < numOfTypes; i++) {
      chartsections.add(
        PieChartSectionData(
          value: double.parse(data['files'][i]['numOfFiles']),
          color: colors[i],
          radius: 55,
          showTitle: true,
          titleStyle: TextStyle(color: Colors.black),
          title:
              data['files'][i]['numOfFiles'] + ' ' + data['files'][i]['type'],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: KBox,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text(
                  'students enrolled: ' + numOfStudnets.toString(),
                ),
              ),
              Container(
                decoration: KBox,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text('Nmuber of files: ' + numOfFiles.toString()),
              ),
              Container(
                decoration: KBox,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: AspectRatio(
                  aspectRatio: 1.3,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 10,
                      borderData: FlBorderData(show: false),
                      sections: chartsections,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
