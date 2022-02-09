import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden_app/config/config.dart';
import 'package:garden_app/config/injection.dart';
import 'package:garden_app/config/routes.gr.dart';
import 'package:garden_app/generated/l10n.dart';
import 'package:garden_app/logic/plants_page/plants_page_cubit.dart';
import 'package:garden_app/presentation/plants_page/widgets/sliver_empty_plants_list_placeholder.dart';
import 'package:garden_app/presentation/plants_page/widgets/header_search_sliver.dart';
import 'package:garden_app/presentation/plants_page/widgets/plant_list_tile.dart';
import 'package:garden_app/presentation/plants_page/widgets/pulsing_floating_button.dart';
import 'package:garden_app/presentation/plants_page/widgets/sliver_empty_search_placeholder.dart';
import 'package:keyboard_utils/widgets.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlantsPageCubit>()..loadPlantsFromDatabase(),
      child: const _PlantsPage(),
    );
  }
}

class _PlantsPage extends StatelessWidget {
  const _PlantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardAware(
        builder: (context, options) {
          return CustomScrollView(
            slivers: [
              HeaderSearchSliver(
                useSearch: options.isKeyboardOpen,
                titleText: S.of(context).appName,
              ),
              BlocConsumer<PlantsPageCubit, PlantsPageState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loaded: (_, __, action, ___) {
                      if (action == null) return;
                      if (action.action == PlantsListAction.inserted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).insertedSuccessfully(action.name),
                            ),
                            backgroundColor: AppColors.successColor,
                          ),
                        );
                      }
                      if (action.action == PlantsListAction.updated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).updatedSuccessfully(action.name),
                            ),
                            backgroundColor: AppColors.successColor,
                          ),
                        );
                      }
                    },
                    orElse: () => null,
                  );
                },
                builder: (context, state) {
                  return state.maybeMap(
                    loaded: (s) {
                      if (s.plants.isEmpty) {
                        if (s.searchPhrase.isNotEmpty) {
                          return SliverEmptySearchPlaceholder(
                            keyboardHeight: options.keyboardHeight,
                          );
                        }
                        return SliverEmptyPlantsListPlaceholder(
                          keyboardHeight: options.keyboardHeight,
                        );
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
                    // Handle error state there
                    orElse: () => const SliverToBoxAdapter(child: SizedBox()),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: PulsingFloatingButton(
        pulseEnabled: true,
        onTap: () {
          FocusScope.of(context).unfocus();
          AutoRouter.of(context).push(
            PlantsFormRoute(),
          );
        },
      ),
    );
  }
}
