import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.black,
            icon: const CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.search,
                size: 20.0,
              ),
            ),
            onPressed: () {},
          ),
        ],
        title: const Text(
          'WishList',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),

            ),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('assets/images/cprogramming.jpg'),
                          width: 100, // Set the width of the image
                          height: 100, // Set the height of the image
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "the name of course the name of course the name of course",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Icon(Icons.nat),
                                  SizedBox(width: 10.0),
                                  Text("10 lesson"),
                                  SizedBox(width: 10.0),
                                  CircleAvatar(backgroundColor: Colors.yellow, minRadius: 5.0),
                                  SizedBox(width: 10.0),
                                  Text("8h22min"),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  SizedBox(width: 20.0),
                                  Text("\$ 1500 "),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Enroll",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Add more content here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
