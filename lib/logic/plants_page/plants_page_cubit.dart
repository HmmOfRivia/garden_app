import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garden_app/data/entity/plant.dart';
import 'package:garden_app/data/repositories/plants_repository.dart';
import 'package:injectable/injectable.dart';

part 'plants_page_cubit.freezed.dart';

@singleton
class PlantsPageCubit extends Cubit<PlantsPageState> {
  final PlantsRepository _repository;

  PlantsPageCubit(this._repository) : super(PlantsPageState.initial()) {
    loadPlantsFromDatabase(0);
  }

  Future<void> loadPlantsFromDatabase(int after) async {
    const _quantity = 10;
    final plantsEither = await _repository.getPlants(after, _quantity);

    plantsEither.fold((_) => emit(PlantsPageState.error()), (plants) {
      final reachedEnd = _quantity != plants.length;
      state.maybeMap(
        initial: (_) => emit(
          PlantsPageState.loaded(
            plants: plants,
            reachedLastItem: reachedEnd,
          ),
        ),
        loaded: (s) => emit(
          s.copyWith(
            plants: [...s.plants, ...plants],
            reachedLastItem: reachedEnd,
          ),
        ),
        orElse: () => null,
      );
    });
  }

  void loadMorePlantsOnEdge(int index) {
    state.maybeMap(
      loaded: (s) {
        if (index == s.plants.length - 2 && !s.reachedLastItem) {
          loadPlantsFromDatabase(s.plants.length - 1);
        }
      },
      orElse: () => null,
    );
  }

  //TODO: Implement

  Future<void> addPlant(Plant plant) async {}

  Future<void> removePlant(Plant plant) async {}
}

@freezed
class PlantsPageState with _$PlantsPageState {
  factory PlantsPageState.initial() = _PlantsPageStateInitial;
  factory PlantsPageState.loaded({
    @Default(<Plant>[]) List<Plant> plants,
    @Default(false) bool reachedLastItem,
  }) = _PlantsPageStateLoaded;
  factory PlantsPageState.error() = _PlantsPageStateError;
}
