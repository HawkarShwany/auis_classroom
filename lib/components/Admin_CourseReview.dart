import 'package:AUIS_classroom/components/Admin_CommentCard.dart';
import 'package:AUIS_classroom/components/Comment_card.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AdminReviews extends StatefulWidget {
  final data;
  final courseId;
  AdminReviews(this.data, this.courseId);
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<AdminReviews> {
  double _rating;
  int _numberOfVotes;
  List<AdminComment> reviews = [];

  void addReviews(dynamic data) {
    if (reviews.length > 0) {
      reviews.removeRange(0, reviews.length - 1);
    }
    for (var i = 0; i < data['reviewCount']; i++) {
      reviews.add(
        AdminComment(
          data['reviews'][i]['studentId'],
          data['reviews'][i]['review'],
          data['reviews'][i]['review_id'],
          deleteReviews,
        ),
      );
    }
  }

  void deleteReviews(dynamic reviewId) async {
    var response = await Network.deleteReivew(reviewId);
    if (response['response'] == 'deleted') {
      updateScreen();
    }
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: KSecondaryColor, content: Text(response['response'])));
  }

  void updateScreen() async {
    var newReviews = await Network.getReviews(widget.courseId);
    setState(() {
      addReviews(newReviews);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addReviews(widget.data);
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
            margin: EdgeInsets.only(top: 20),
            child: SmoothStarRating(
              rating: _rating - 0.1,
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return reviews[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
