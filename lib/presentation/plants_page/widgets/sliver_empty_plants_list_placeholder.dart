import 'package:flutter/material.dart';
import 'package:garden_app/config/config.dart';
import 'package:garden_app/generated/l10n.dart';
import 'package:lottie/lottie.dart';
import 'package:garden_app/gen/assets.gen.dart';

class SliverEmptyPlantsListPlaceholder extends StatelessWidget {
  const SliverEmptyPlantsListPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 240,
        width: 240,
        margin: const EdgeInsets.symmetric(vertical: 100),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.mainColor,
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              Assets.animations.treeAnim,
              height: 150,
              repeat: false,
            ),
            Text(
              S.of(context).noPlants,
              style: AppStyles.blackMedium(16),
            )
          ],
        ),
      ),
    );
  }
}
