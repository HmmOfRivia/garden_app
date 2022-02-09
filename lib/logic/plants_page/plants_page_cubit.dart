import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:garden_app/data/entity/plant.dart';
import 'package:garden_app/data/repositories/plants_repository.dart';

part 'plants_page_cubit.freezed.dart';

@singleton
class PlantsPageCubit extends Cubit<PlantsPageState> {
  final PlantsRepository _repository;

  PlantsPageCubit(this._repository) : super(PlantsPageState.initial()) {
    loadPlantsFromDatabase();
  }

  Future<void> loadPlantsFromDatabase({int? after}) async {
    const _quantity = 10;
    final plantsEither = await _repository.getPlants(
      after: after,
      quantity: _quantity,
    );

    plantsEither.fold(
      (_) => emit(PlantsPageState.error()),
      (plants) {
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
              plants: after == null ? plants : [...s.plants, ...plants],
              searchPhrase: '',
              reachedLastItem: reachedEnd,
              action: null,
            ),
          ),
          orElse: () => null,
        );
      },
    );
  }

  void loadMorePlantsOnEdge(int index) {
    state.maybeMap(
      loaded: (s) {
        if (index == s.plants.length - 2 &&
            !s.reachedLastItem &&
            s.searchPhrase.isEmpty) {
          loadPlantsFromDatabase(after: s.plants.last.id!);
        }
      },
      orElse: () => null,
    );
  }

  Future<void> addPlant(Plant plant) async {
    await _repository.insertPlant(plant);

    state.maybeMap(
      loaded: (s) => emit(
        s.copyWith(
          plants: [plant, ...s.plants],
          action: _PlantActionArguments(
            action: PlantsListAction.inserted,
            name: plant.name,
          ),
        ),
      ),
      orElse: () => null,
    );
  }

  Future<void> updatePlant(Plant plant) async {
    await _repository.updatePlant(plant);

    state.maybeMap(
      loaded: (s) {
        final updatedPlants = s.plants.map((element) {
          return element.id == plant.id ? plant : element;
        }).toList();

        emit(
          s.copyWith(
            plants: updatedPlants,
            action: _PlantActionArguments(
              action: PlantsListAction.updated,
              name: plant.name,
            ),
          ),
        );
      },
      orElse: () => null,
    );
  }

  Future<void> searchPlant({String? text}) async {
    if (text != null && text.isNotEmpty) {
      final plantsEither = await _repository.getPlantsByText(text);

      plantsEither.fold(
        (_) => null,
        (plants) => emit(
          PlantsPageState.loaded(
            plants: plants,
            searchPhrase: text,
          ),
        ),
      );
    } else {
      final plantsEither = await _repository.getPlants();

      plantsEither.fold(
        (_) => null,
        (plants) => emit(PlantsPageState.loaded(plants: plants)),
      );
    }
  }
}

enum PlantsListAction { updated, inserted }

class _PlantActionArguments {
  final PlantsListAction action;
  final String name;

  _PlantActionArguments({
    required this.action,
    required this.name,
  });
}

@freezed
class PlantsPageState with _$PlantsPageState {
  factory PlantsPageState.initial() = _PlantsPageStateInitial;
  factory PlantsPageState.loaded({
    @Default(<Plant>[]) List<Plant> plants,
    @Default(false) bool reachedLastItem,
    _PlantActionArguments? action,
    @Default('') String searchPhrase,
  }) = _PlantsPageStateLoaded;
  factory PlantsPageState.error() = _PlantsPageStateError;
}
