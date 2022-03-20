import 'package:flutter/material.dart';

import 'package:travel_app/models/travel.dart';

class TravelDetail extends StatelessWidget {
  final Travel travel;
  final double expandedHeight = 300;
  final double roundedContainerHeight = 50;

  const TravelDetail({required this.travel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverHead(),
              SliverToBoxAdapter(
                child: _buildDetail(),
              )
            ],
          ),
          SizedBox(
            height: kToolbarHeight,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 15,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverHead() {
    return SliverPersistentHeader(
      delegate: DetailsSliverDelegate(
        travel: travel,
        expandedHeight: expandedHeight,
        roundedContainerHeight: roundedContainerHeight,
      ),
    );
  }

  Widget _buildDetail() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildUserInfo(),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nisi, asperiores voluptatem voluptate optio suscipit qui corrupti dolorum rerum veniam vel mollitia cupiditate tempore quaerat? Autem expedita nihil corporis cum necessitatibus!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Featured',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: FeaturedWidget(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nisi, asperiores voluptatem voluptate optio suscipit qui corrupti dolorum rerum veniam vel mollitia cupiditate tempore quaerat? Autem expedita nihil corporis cum necessitatibus!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              travel.url,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  travel.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  travel.location,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.share,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class DetailsSliverDelegate extends SliverPersistentHeaderDelegate {
  final Travel travel;
  final double expandedHeight;
  final double roundedContainerHeight;

  DetailsSliverDelegate({
    required this.travel,
    required this.expandedHeight,
    required this.roundedContainerHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Image.asset(
          travel.url,
          width: MediaQuery.of(context).size.width,
          height: expandedHeight,
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: 0.4,
          child: Container(
            decoration: const BoxDecoration(color: Colors.black),
          ),
        ),
        Positioned(
          top: expandedHeight - roundedContainerHeight - shrinkOffset + 1,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: roundedContainerHeight,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
        Positioned(
            top: expandedHeight - shrinkOffset - 120,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  travel.name,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  travel.location,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ))
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(
    covariant SliverPersistentHeaderDelegate oldDelegate,
  ) =>
      true;
}

class FeaturedWidget extends StatelessWidget {
  final _travelList = Travel.generateMostPopular();

  FeaturedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      scrollDirection: Axis.horizontal,
      itemCount: _travelList.length,
      separatorBuilder: (context, _) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        var travel = _travelList[index];

        return SizedBox(
          width: 120,
          child: Image.asset(
            travel.url,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
