import 'package:flutter/foundation.dart';
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
  int numOfComments;
  int numOfReviews;
  List<PieChartSectionData> chartsections = [];
  List<Color> colors = [
    KYellow,
    KGreen,
    Colors.deepPurple,
    KBlue,
    Colors.yellowAccent,
    Colors.grey,
    KPrimaryColor,
    Colors.amberAccent
  ];
  double cardWidth = 200;
  double vertical = 15;
  double horizontal = 15;

  void parseData(dynamic data) {
    chartsections.removeRange(0, chartsections.length);
    numOfStudnets = int.parse(data['numOfStudents']);
    numOfFiles = int.parse(data['numOfFiles']);
    numOfTypes = int.parse(data['numOfTypes']);
    numOfComments = int.parse(data['numOfComments']);
    numOfReviews = int.parse(data['numOfReviews']);

    if(numOfTypes == 0){
      chartsections.add(
        PieChartSectionData(titlePositionPercentageOffset: 1.0,
          value: 1.0,
          color: Colors.white,
          radius: 55,
          showTitle: true,
          titleStyle: TextStyle(color: Colors.black),
          title:'no files',
        ),
      );
      return;
    }
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

  Widget students() {
    return Container(
      width: cardWidth,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: KBox,
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          margin:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.people,
                color: KBlue,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                numOfStudnets.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget files() {
    return Container(
      width: cardWidth,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: KBox,
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          margin:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.insert_drive_file,
                color: KBlue,
              ),
              SizedBox(
                height: 10,
              ),
              Text(numOfFiles.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget comments() {
    return Container(
      width: cardWidth,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: KBox,
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          margin:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.rate_review,
                color: KBlue,
              ),
              SizedBox(
                height: 10,
              ),
              Text(numOfComments.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget reviews() {
    var container = Container(
      width: cardWidth,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: KBox,
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          margin:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.comment,
                color: KBlue,
              ),
              SizedBox(
                height: 10,
              ),
              Text(numOfReviews.toString()),
            ],
          ),
        ),
      ),
    );
    return container;
  }

  Widget chart() {
    return Container(
      decoration: KBox,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
    );
  }

  Widget mobileView() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                students(),
                files(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                comments(),
                reviews(),
              ],
            ),
            chart(),
          ],
        ),
      ),
    );
  }

  Widget webView() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                students(),
                files(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                comments(),
                reviews(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return webView();
    } else {
      return mobileView();
    }
  }
}
