import 'package:flutter/material.dart';

import '../../../models/review_model.dart';



/*
class ReviewScreen extends StatelessWidget {
  final List<Review> reviews = [
    Review(
      name: 'John Doe',
      rating: 4.5,
      comment: 'Great service! Will definitely come back again.',
    ),
    Review(
      name: 'Jane Smith',
      rating: 5.0,
      comment: 'Excellent experience. Highly recommended!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewCard(review: reviews[index]);
      },
    );
  }
}*/

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage('assets/profile_picture.jpg'),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Text(
                  review.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                for (int i = 0; i <(review.rating).round() ; i++)
                  const Icon(Icons.star, color: Colors.yellow),
                for (int i = (review.rating).round(); i < 5; i++)
                  const Icon(Icons.star_border, color: Colors.yellow),
                Text(
                  '${review.rating}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              review.comment,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
