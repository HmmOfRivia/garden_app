import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:garden_app/config/config.dart';
import 'package:garden_app/gen/assets.gen.dart';
import 'package:garden_app/logic/plants_page/plants_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden_app/generated/l10n.dart';

class HeaderSearchSliver extends SliverAppBar {
  final String titleText;
  static double maxHeight = 350.0;
  static double minHeight = 80.0;
  static double heightDifference = maxHeight - minHeight;

  HeaderSearchSliver({
    Key? key,
    required this.titleText,
    bool useSearch = false,
  }) : super(
          key: key,
          floating: true,
          pinned: true,
          expandedHeight: useSearch ? minHeight : maxHeight,
          backgroundColor: AppColors.mainColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(minHeight),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              height: 60,
              child: const Center(
                child: _SearchPlantsTextField(),
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

class _SearchPlantsTextField extends HookWidget {
  const _SearchPlantsTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: S.of(context).search,
        contentPadding: const EdgeInsets.all(8.0),
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder()
            .copyWith(borderRadius: BorderRadius.circular(10.0)),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
            context.read<PlantsPageCubit>().loadPlantsFromDatabase();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      onChanged: (value) =>
          context.read<PlantsPageCubit>().searchPlant(text: value),
    );
  }
}
