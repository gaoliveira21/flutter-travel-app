import 'package:flutter/material.dart';

import 'package:travel_app/detail.dart';
import 'package:travel_app/models/travel.dart';

class TravelBlog extends StatelessWidget {
  final List<Travel> _travelList = Travel.generateTravelBlog();
  final _pageCtrl = PageController(viewportFraction: 0.9);

  TravelBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageCtrl,
      itemCount: _travelList.length,
      itemBuilder: (context, index) {
        var travel = _travelList[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return TravelDetail(
                    travel: travel,
                  );
                },
              ),
            );
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, right: 20, bottom: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    travel.url,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        travel.location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        travel.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 30,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
