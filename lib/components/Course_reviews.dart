import 'package:AUIS_classroom/components/Comment_card.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Reviews extends StatefulWidget {
  final data;
  Reviews(this.data);
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  double _rating;
  int _numberOfVotes;
  List<Comment> reviews = [];

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
    _rating = widget.data['rate'];
    print(_rating);
    _numberOfVotes = widget.data['votes'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              decoration: kdecorateInput(
                hint: "Add a Review",
                suffix: FlatButton(
                  onPressed: () {},
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
