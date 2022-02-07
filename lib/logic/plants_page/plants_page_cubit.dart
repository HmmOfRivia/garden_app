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
    final plantsEither = await _repository.getPlants(after);

    plantsEither.fold(
      (_) => emit(PlantsPageState.error()),
      (plants) => emit(PlantsPageState.loaded(plants: plants)),
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
  }) = _PlantsPageStateLoaded;
  factory PlantsPageState.error() = _PlantsPageStateError;
}
