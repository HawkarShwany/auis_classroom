import 'package:AUIS_classroom/components/Comment_card.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Reviews extends StatefulWidget {
  final courseId;
  final data;
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

  void updateScreen(dynamic response) async {
    var newReviews = await Network.getReviews(widget.courseId);
    setState(() {
      addReviews(newReviews);
      _rating = double.parse(newReviews['rate']);
      _numberOfVotes = newReviews['votes'];
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: KSecondaryColor,
        content: Text(response['response']),
      ),
    );
  }

  void addReviews(dynamic data) {
    reviews.removeRange(0, reviews.length);
    for (var i = 0; i < data['reviewCount']; i++) {
      reviews.add(Comment(
          data['reviews'][i]['fname'] + ' ' + data['reviews'][i]['lname'],
          data['reviews'][i]['review']));
    }
  }

  void rate() async {
    var response = await Network.rateCourse(
        Provider.of<User>(context, listen: false).id,
        widget.courseId,
        _rating.toString());

    updateScreen(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addReviews(widget.data);
    _rating = double.parse(widget.data['rate']);
    _numberOfVotes = widget.data['votes'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: SmoothStarRating(
                  onRatingChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
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
              RaisedButton(
                onPressed: () {
                  rate();
                },
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
                    if (reviews.length == 0) return CircularProgressIndicator();
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
                        setState(() async {
                          var response = await Network.review(
                              _review,
                              widget.courseId,
                              Provider.of<User>(context, listen: false).id);
                          _controller.clear();
                          if (response['response'] == 'added')
                            updateScreen(response);
                        });
                      },
                      child: Icon(Icons.send, color: KBlue),
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
