import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:garden_app/data/entity/plant.dart';
import 'package:garden_app/data/repositories/plants_repository.dart';

part 'plants_page_cubit.freezed.dart';

@singleton
class PlantsPageCubit extends Cubit<PlantsPageState> {
  final PlantsRepository _repository;

  PlantsPageCubit(this._repository) : super(const PlantsPageState.initial());

  Future<void> loadPlantsFromDatabase({int? after, int quantity = 10}) async {
    final plantsEither = await _repository.getPlants(
      after: after,
      quantity: quantity,
    );

    plantsEither.fold(
      (_) => emit(const PlantsPageState.error()),
      (plants) {
        final reachedLastItem = quantity != plants.length;
        state.maybeMap(
          loaded: (s) => emit(
            s.copyWith(
              plants: after == null ? plants : [...s.plants, ...plants],
              searchPhrase: '',
              reachedLastItem: reachedLastItem,
              action: null,
            ),
          ),
          orElse: () => emit(
            PlantsPageState.loaded(
              plants: plants,
              reachedLastItem: reachedLastItem,
            ),
          ),
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
    if (!await _repository.insertPlant(plant)) {
      emit(const PlantsPageState.error());
    }

    state.maybeMap(
      loaded: (s) => emit(
        s.copyWith(
          plants: [plant, ...s.plants],
          action: PlantActionArguments(
            action: PlantsListAction.inserted,
            name: plant.name,
          ),
        ),
      ),
      orElse: () => null,
    );
  }

  Future<void> updatePlant(Plant plant) async {
    if (!await _repository.updatePlant(plant)) {
      emit(const PlantsPageState.error());
    }

    state.maybeMap(
      loaded: (s) {
        final updatedPlants = s.plants.map((element) {
          return element.id == plant.id ? plant : element;
        }).toList();

        emit(
          s.copyWith(
            plants: updatedPlants,
            action: PlantActionArguments(
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
      const quantity = 10;
      final plantsEither = await _repository.getPlants(quantity: quantity);

      plantsEither.fold(
        (_) => emit(const PlantsPageState.error()),
        (plants) {
          final reachedLastItem = quantity != plants.length;
          emit(
            PlantsPageState.loaded(
              plants: plants,
              reachedLastItem: reachedLastItem,
            ),
          );
        },
      );
    }
  }
}

enum PlantsListAction { updated, inserted }

class PlantActionArguments {
  final PlantsListAction action;
  final String name;

  PlantActionArguments({
    required this.action,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlantActionArguments &&
        other.action == action &&
        other.name == name;
  }

  @override
  int get hashCode => action.hashCode ^ name.hashCode;
}

@freezed
abstract class PlantsPageState with _$PlantsPageState {
  const factory PlantsPageState.initial() = _PlantsPageStateInitial;
  const factory PlantsPageState.loaded({
    @Default(<Plant>[]) List<Plant> plants,
    @Default(false) bool reachedLastItem,
    PlantActionArguments? action,
    @Default('') String searchPhrase,
  }) = _PlantsPageStateLoaded;
  const factory PlantsPageState.error() = _PlantsPageStateError;
}
