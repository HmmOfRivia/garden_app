import 'package:flutter/material.dart';
import 'package:garden_app/config/config.dart';
import 'package:garden_app/generated/l10n.dart';
import 'package:garden_app/presentation/plants_page/widgets/header_search_sliver.dart';
import 'package:lottie/lottie.dart';
import 'package:garden_app/gen/assets.gen.dart';

class SliverEmptyPlantsListPlaceholder extends StatelessWidget {
  final double keyboardHeight;
  const SliverEmptyPlantsListPlaceholder({
    Key? key,
    required this.keyboardHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeholderHeight = MediaQuery.of(context).size.height -
        (HeaderSearchSliver.maxHeight + 80);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: placeholderHeight,
        child: Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.mainColor,
                      width: 3,
                    ),
                  ),
                ),
                LottieBuilder.asset(
                  Assets.animations.treeAnim,
                  height: 130,
                  repeat: false,
                ),
                Align(
                  alignment: const FractionalOffset(0.5, 0.8),
                  child: Text(
                    S.of(context).noPlants,
                    style: AppStyles.blackMedium(16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
