import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';

class MostPopular extends StatelessWidget {
  final _travelList = Travel.generateMostPopular();

  MostPopular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var travel = _travelList[index];

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                travel.url,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                left: 15,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Text(travel.location,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(travel.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ),
                  ],
                ))
          ],
        );
      },
      separatorBuilder: (context, _) => const SizedBox(
        width: 15,
      ),
      itemCount: _travelList.length,
    );
  }
}
