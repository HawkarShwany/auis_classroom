import 'package:AUIS_classroom/components/Comment_card.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Reviews extends StatefulWidget {
  final data;
  final courseId;
  Reviews(this.data, this.courseId);
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  double _rating;
  int _numberOfVotes;
  TextEditingController _controller = TextEditingController();
  List<Comment> reviews = [];
  String _review;

  void addReviews() {
    for (var i = 0; i < widget.data['reviewCount']; i++) {
      reviews.add(Comment(widget.data['reviews'][i]['studentId'],
          widget.data['reviews'][i]['review']));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addReviews();
    _rating = double.parse(widget.data['rate']);
    print(_rating);
    _numberOfVotes = widget.data['votes'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: SmoothStarRating(
              rating: _rating - 0.1,
              // onRatingChanged: (rating) {
              //   setState(() {
              //     _rating= rating;
              //   });
              // } ,
              allowHalfRating: true,
              starCount: 5,
              color: KYellow,
              borderColor: KYellow,
              size: 40,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Text(_numberOfVotes.toString() + " votes"),
          ),
          RaisedButton(
            onPressed: () {},
            color: KGreen,
            child: Text(
              'Rate',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return reviews[index];
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              onChanged: (value) => _review = value,
              controller: _controller,
              decoration: kdecorateInput(
                hint: "Add a Review",
                suffix: FlatButton(
                  onPressed: () {
                    setState(() {
                      Network.review(_review, widget.courseId,
                          Provider.of<User>(context, listen: false).id);
                      _controller.clear();
                    });
                  },
                  child: Icon(Icons.send, color: KBlue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
