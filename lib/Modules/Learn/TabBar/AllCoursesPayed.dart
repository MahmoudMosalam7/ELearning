import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              elevation: 4, // Adds a shadow effect
              child: ListTile(
                title: const Text('Completed Python For Beginners',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: const Text('Wael Abo Hamze'),
                leading: Stack(
                  children: [
                    const Image(image: AssetImage('assets/images/python.jpeg')),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 9,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 15,
                            color: isFavorite ? Colors.green : Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: SizedBox(
                  width: 50, // Constrain the width of the CircularPercentIndicator
                  height: 50, // Constrain the height of the CircularPercentIndicator
                  child: CircularPercentIndicator(
                    radius: 25.0,
                    lineWidth: 4.0,
                    percent: 1,
                    center: Text("100%"),
                    progressColor: Colors.green,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 4, // Adds a shadow effect
              child: ListTile(
                title: const Text('Completed C_Programming For Beginners',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: const Text('Adel Nesim'),
                leading: Stack(
                  children: [
                    const Image(image: AssetImage('assets/images/cprogramming.jpg')),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 9,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 15,
                            color: isFavorite ? Colors.green : Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: SizedBox(
                  width: 50, // Constrain the width of the CircularPercentIndicator
                  height: 50, // Constrain the height of the CircularPercentIndicator
                  child: CircularPercentIndicator(
                    radius: 25.0,
                    lineWidth: 4.0,
                    percent: 0.8,
                    center: Text("80%"),
                    progressColor: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
