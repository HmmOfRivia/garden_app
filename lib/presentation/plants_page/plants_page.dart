import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:garden_app/config/injection.dart';
import 'package:garden_app/config/routes.gr.dart';
import 'package:garden_app/generated/l10n.dart';
import 'package:garden_app/logic/plants_page/plants_page_cubit.dart';
import 'package:garden_app/presentation/plants_page/widgets/sliver_empty_plants_list_placeholder.dart';
import 'package:garden_app/presentation/plants_page/widgets/header_search_sliver.dart';
import 'package:garden_app/presentation/plants_page/widgets/plant_list_tile.dart';
import 'package:garden_app/presentation/plants_page/widgets/pulsing_floating_button.dart';
import 'package:keyboard_utils/widgets.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlantsPageCubit>(),
      child: const _PlantsPage(),
    );
  }
}

class _PlantsPage extends HookWidget {
  const _PlantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: [
          KeyboardAware(
            builder: (context, options) {
              if (options.isKeyboardOpen &&
                  controller.offset < HeaderSearchSliver.heightDifference) {
                controller.animateTo(
                  HeaderSearchSliver.heightDifference,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              }

              return HeaderSearchSliver(
                titleText: S.of(context).appName,
              );
            },
          ),
          BlocBuilder<PlantsPageCubit, PlantsPageState>(
            builder: (context, state) {
              return state.maybeMap(
                loaded: (s) {
                  if (s.plants.isEmpty) {
                    return const SliverEmptyPlantsListPlaceholder();
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        context
                            .read<PlantsPageCubit>()
                            .loadMorePlantsOnEdge(index);

                        return PlantListTile(plant: s.plants[index]);
                      },
                      childCount: s.plants.length,
                    ),
                  );
                },
                orElse: () => const SizedBox(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: PulsingFloatingButton(
        pulseEnabled: true,
        onTap: () => AutoRouter.of(context).push(
          PlantsFormRoute(),
        ),
      ),
    );
  }
}
