import 'package:flutter/material.dart';
import 'package:garden_app/config/config.dart';
import 'package:garden_app/gen/assets.gen.dart';

class HeaderSearchSliver extends SliverAppBar {
  final String titleText;
  HeaderSearchSliver({
    Key? key,
    required this.titleText,
  }) : super(
          key: key,
          floating: true,
          pinned: true,
          expandedHeight: 350,
          backgroundColor: AppColors.mainColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              height: 60,
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: const TextField(),
                ),
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              titleText,
              style: AppStyles.whiteMedium(50),
            ),
            titlePadding: const EdgeInsets.only(
              bottom: 100.0,
              left: 10.0,
            ),
            background: Assets.images.bannerImage.image(
              fit: BoxFit.cover,
            ),
            collapseMode: CollapseMode.parallax,
          ),
        );
}
