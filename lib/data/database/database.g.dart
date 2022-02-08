// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorPlantDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PlantDatabaseBuilder databaseBuilder(String name) =>
      _$PlantDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PlantDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$PlantDatabaseBuilder(null);
}

class _$PlantDatabaseBuilder {
  _$PlantDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PlantDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PlantDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PlantDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PlantDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PlantDatabase extends PlantDatabase {
  _$PlantDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PlantDao? _plantDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Plant` (`id` INTEGER, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `plantDate` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PlantDao get plantDao {
    return _plantDaoInstance ??= _$PlantDao(database, changeListener);
  }
}

class _$PlantDao extends PlantDao {
  _$PlantDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _plantInsertionAdapter = InsertionAdapter(
            database,
            'Plant',
            (Plant item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': _plantTypeConverter.encode(item.type),
                  'plantDate': _dateTimeConverter.encode(item.plantDate)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Plant> _plantInsertionAdapter;

  @override
  Future<List<Plant>> getPlantsAfterId(int id, int quantity) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Plant WHERE id < ?1 ORDER BY id DESC LIMIT ?2',
        mapper: (Map<String, Object?> row) => Plant(
            id: row['id'] as int?,
            name: row['name'] as String,
            type: _plantTypeConverter.decode(row['type'] as String),
            plantDate: _dateTimeConverter.decode(row['plantDate'] as int)),
        arguments: [id, quantity]);
  }

  @override
  Future<List<Plant>> getFirstPlants(int quantity) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Plant ORDER BY id DESC LIMIT ?1',
        mapper: (Map<String, Object?> row) => Plant(
            id: row['id'] as int?,
            name: row['name'] as String,
            type: _plantTypeConverter.decode(row['type'] as String),
            plantDate: _dateTimeConverter.decode(row['plantDate'] as int)),
        arguments: [quantity]);
  }

  @override
  Future<void> insertPlant(Plant plant) async {
    await _plantInsertionAdapter.insert(plant, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _plantTypeConverter = PlantTypeConverter();
