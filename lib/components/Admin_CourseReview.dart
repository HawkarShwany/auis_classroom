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

  void addReviews() {
    
    for (var i = 0; i < widget.data['reviewCount']; i++) {

      reviews.add(
        AdminComment(
          widget.data['reviews'][i]['studentId'],
          widget.data['reviews'][i]['review'],
          widget.data['reviews'][i]['review_id'],
          deleteReviews,  
        ),
      );
    }
  }

  void deleteReviews(dynamic reviewId) {
    Network.deleteReivew(reviewId);
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
