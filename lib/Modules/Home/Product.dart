
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/listView_Courses.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(product.imageURL ,width: 300, // Desired width
              height: 250,
              fit: BoxFit.cover),
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                InkWell(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.favorite_border,
                  //    color: product.isFavorite ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('EGP ${product.price}'
                ),
                Spacer(),
                for (int i = 0; i < product.rating.round(); i++)
                  Icon(Icons.star, color: Colors.yellow),
                for (int i = product.rating.round(); i < 5; i++)
                  Icon(Icons.star_border, color: Colors.yellow),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
