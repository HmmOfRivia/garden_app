import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:floor/floor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:garden_app/data/database/database.dart';
import 'package:garden_app/data/entity/plant.dart';
import 'package:garden_app/data/dao/plant_dao.dart';
import 'package:garden_app/data/repositories/plants_repository.dart';
import 'package:garden_app/logic/plants_page/plants_page_cubit.dart';
import 'package:garden_app/presentation/plants_page/plants_page.dart';
import 'package:flutter/material.dart';
import 'package:garden_app/config/garden_app.dart';

class MockPlantsRepository extends Mock implements PlantsRepository {}

class MockPlant extends Mock implements Plant {
  final int? id;
  MockPlant(this.id);
}

void main() {
  group(
    'database tests',
    () {
      late PlantDatabase database;
      late PlantDao plantDao;

      setUp(() async {
        database = await $FloorPlantDatabase.inMemoryDatabaseBuilder().build();
        plantDao = database.plantDao;
      });

      tearDown(() async {
        await database.close();
      });

      test(
        'insert and get 1 item from database',
        () async {
          await plantDao.insertPlant(insertedPlant);

          final actual = await plantDao.getFirstPlants(1);

          expect(actual.first, equals(insertedPlant));
        },
      );
      test(
        'get 10 items from database',
        () async {
          final _insertedItems = 10;
          for (int i = 0; i < _insertedItems; i++) {
            await plantDao.insertPlant(insertedPlant.copyWith(id: i));
          }
          final actual = await plantDao.getFirstPlants(10);

          expect(actual.length, equals(_insertedItems));
        },
      );
      test(
        'search for text in database',
        () async {
          final _text = '%Ros%';

          await plantDao.insertPlant(insertedPlant.copyWith(
            id: 0,
            name: 'Rose',
          ));
          await plantDao.insertPlant(insertedPlant.copyWith(
            id: 1,
            name: 'Eros',
          ));
          await plantDao.insertPlant(insertedPlant.copyWith(
            id: 2,
            name: 'Banana',
          ));

          final actual = await plantDao.getPlantsByName(_text);

          expect(actual.length, 2);
        },
      );
    },
  );
  group(
    'plant cubit',
    () {
      late MockPlantsRepository plantsRepository;
      late PlantsPageCubit cubit;

      setUp(() async {
        plantsRepository = MockPlantsRepository();
        cubit = PlantsPageCubit(plantsRepository);
      });

      tearDown(() async {
        await cubit.close();
      });
      PlantsPageCubit buildCubit() => PlantsPageCubit(plantsRepository);

      test('plants cubit starts with initial state', () {
        expect(
          cubit.state,
          PlantsPageState.initial(),
        );
      });

      blocTest<PlantsPageCubit, PlantsPageState>(
        'inserting first plant to list',
        seed: () => PlantsPageState.loaded(
          plants: [],
          reachedLastItem: true,
        ),
        build: () {
          when(() => plantsRepository.insertPlant(insertedPlant))
              .thenAnswer((_) => Future.value(true));

          return buildCubit();
        },
        act: (c) => c.addPlant(insertedPlant),
        expect: () => [
          PlantsPageState.loaded(
            plants: [insertedPlant],
            reachedLastItem: true,
            action: PlantActionArguments(
              action: PlantsListAction.inserted,
              name: insertedPlant.name,
            ),
          )
        ],
      );

      blocTest<PlantsPageCubit, PlantsPageState>(
        'search for plants',
        seed: () => PlantsPageState.loaded(
          plants: firstPaginationPlants,
          reachedLastItem: false,
        ),
        build: () {
          when(
            () => plantsRepository.getPlantsByText('%plant%'),
          ).thenAnswer(
            (_) => Future.value(Right(firstPaginationPlants)),
          );

          return buildCubit();
        },
        act: (c) => c.searchPlant(text: '%plant%'),
        expect: () => [
          PlantsPageState.loaded(
            plants: firstPaginationPlants,
            searchPhrase: '%plant%',
          )
        ],
      );

      blocTest<PlantsPageCubit, PlantsPageState>(
        'load first 10 plants',
        seed: () => PlantsPageState.initial(),
        build: () {
          when(
            () => plantsRepository.getPlants(after: 0, quantity: 10),
          ).thenAnswer(
            (_) => Future.value(Right(firstPaginationPlants)),
          );

          return buildCubit();
        },
        act: (c) => c.loadPlantsFromDatabase(after: 0),
        expect: () => [
          PlantsPageState.loaded(plants: firstPaginationPlants),
        ],
      );

      blocTest<PlantsPageCubit, PlantsPageState>(
        'load 10 more items on hit edge index',
        seed: () => PlantsPageState.loaded(
          plants: firstPaginationPlants,
          reachedLastItem: false,
        ),
        build: () {
          when(
            () => plantsRepository.getPlants(
              after: firstPaginationPlants.length - 1,
              quantity: 10,
            ),
          ).thenAnswer(
            (_) => Future.value(Right(secondPaginationPlants)),
          );

          return buildCubit();
        },
        act: (c) => c.loadPlantsFromDatabase(
          after: firstPaginationPlants.length - 1,
        ),
        expect: () => [
          PlantsPageState.loaded(
            plants: [
              ...firstPaginationPlants,
              ...secondPaginationPlants,
            ],
            reachedLastItem: true,
          ),
        ],
      );

      blocTest<PlantsPageCubit, PlantsPageState>(
        'return error state on database exception',
        build: () {
          when(
            () => plantsRepository.getPlants(after: 0, quantity: 10),
          ).thenAnswer(
            (_) => Future.value(Left(Exception())),
          );

          return buildCubit();
        },
        act: (c) => c.loadPlantsFromDatabase(after: 0),
        expect: () => [PlantsPageState.error()],
      );
    },
  );
}

final insertedPlant = Plant(
  id: 0,
  name: "name",
  type: PlantType.alpines,
  plantDate: DateTime(1000),
);

final firstPaginationPlants = generatePlantsList();
final secondPaginationPlants = generatePlantsList(length: 6);

Future<Either<Exception, List<Plant>>> goodRes(
  List<Plant> plants,
) async =>
    right(plants);

Future<Either<Exception, List<Plant>>> badRes() async => left(Exception());

List<Plant> generatePlantsList({int length = 10}) {
  return List.generate(length, (index) => MockPlant(index));
}
