// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ColabDao? _colabDaoInstance;

  EquipDao? _equipDaoInstance;

  LocalDao? _localDaoInstance;

  TerceiroDao? _terceiroDaoInstance;

  VisitanteDao? _visitanteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `colab` (`matricColab` INTEGER NOT NULL, `nomeColab` TEXT NOT NULL, PRIMARY KEY (`matricColab`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `equip` (`idEquip` INTEGER NOT NULL, `nroEquip` INTEGER NOT NULL, PRIMARY KEY (`idEquip`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `local` (`idLocal` INTEGER NOT NULL, `descrLocal` TEXT NOT NULL, PRIMARY KEY (`idLocal`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `terceiro` (`idTerceiro` INTEGER PRIMARY KEY AUTOINCREMENT, `idBDTerceiro` INTEGER NOT NULL, `cpfTerceiro` TEXT NOT NULL, `nomeTerceiro` TEXT NOT NULL, `empresaTerceiro` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `visitante` (`idVisitante` INTEGER NOT NULL, `cpfVisitante` TEXT NOT NULL, `nomeVisitante` TEXT NOT NULL, `empresaVisitante` TEXT NOT NULL, PRIMARY KEY (`idVisitante`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ColabDao get colabDao {
    return _colabDaoInstance ??= _$ColabDao(database, changeListener);
  }

  @override
  EquipDao get equipDao {
    return _equipDaoInstance ??= _$EquipDao(database, changeListener);
  }

  @override
  LocalDao get localDao {
    return _localDaoInstance ??= _$LocalDao(database, changeListener);
  }

  @override
  TerceiroDao get terceiroDao {
    return _terceiroDaoInstance ??= _$TerceiroDao(database, changeListener);
  }

  @override
  VisitanteDao get visitanteDao {
    return _visitanteDaoInstance ??= _$VisitanteDao(database, changeListener);
  }
}

class _$ColabDao extends ColabDao {
  _$ColabDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _colabFloorModelInsertionAdapter = InsertionAdapter(
            database,
            'colab',
            (ColabFloorModel item) => <String, Object?>{
                  'matricColab': item.matricColab,
                  'nomeColab': item.nomeColab
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ColabFloorModel> _colabFloorModelInsertionAdapter;

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM colab');
  }

  @override
  Future<List<int>> insertAll(List<ColabFloorModel> listColab) {
    return _colabFloorModelInsertionAdapter.insertListAndReturnIds(
        listColab, OnConflictStrategy.abort);
  }
}

class _$EquipDao extends EquipDao {
  _$EquipDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _equipFloorModelInsertionAdapter = InsertionAdapter(
            database,
            'equip',
            (EquipFloorModel item) => <String, Object?>{
                  'idEquip': item.idEquip,
                  'nroEquip': item.nroEquip
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EquipFloorModel> _equipFloorModelInsertionAdapter;

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM equip');
  }

  @override
  Future<List<int>> insertAll(List<EquipFloorModel> listEquip) {
    return _equipFloorModelInsertionAdapter.insertListAndReturnIds(
        listEquip, OnConflictStrategy.abort);
  }
}

class _$LocalDao extends LocalDao {
  _$LocalDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _localFloorModelInsertionAdapter = InsertionAdapter(
            database,
            'local',
            (LocalFloorModel item) => <String, Object?>{
                  'idLocal': item.idLocal,
                  'descrLocal': item.descrLocal
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LocalFloorModel> _localFloorModelInsertionAdapter;

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM local');
  }

  @override
  Future<List<int>> insertAll(List<LocalFloorModel> listLocal) {
    return _localFloorModelInsertionAdapter.insertListAndReturnIds(
        listLocal, OnConflictStrategy.abort);
  }
}

class _$TerceiroDao extends TerceiroDao {
  _$TerceiroDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _terceiroFloorModelInsertionAdapter = InsertionAdapter(
            database,
            'terceiro',
            (TerceiroFloorModel item) => <String, Object?>{
                  'idTerceiro': item.idTerceiro,
                  'idBDTerceiro': item.idBDTerceiro,
                  'cpfTerceiro': item.cpfTerceiro,
                  'nomeTerceiro': item.nomeTerceiro,
                  'empresaTerceiro': item.empresaTerceiro
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TerceiroFloorModel>
      _terceiroFloorModelInsertionAdapter;

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM terceiro');
  }

  @override
  Future<List<int>> insertAll(List<TerceiroFloorModel> listTerceiro) {
    return _terceiroFloorModelInsertionAdapter.insertListAndReturnIds(
        listTerceiro, OnConflictStrategy.abort);
  }
}

class _$VisitanteDao extends VisitanteDao {
  _$VisitanteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _visitanteFloorModelInsertionAdapter = InsertionAdapter(
            database,
            'visitante',
            (VisitanteFloorModel item) => <String, Object?>{
                  'idVisitante': item.idVisitante,
                  'cpfVisitante': item.cpfVisitante,
                  'nomeVisitante': item.nomeVisitante,
                  'empresaVisitante': item.empresaVisitante
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VisitanteFloorModel>
      _visitanteFloorModelInsertionAdapter;

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM visitante');
  }

  @override
  Future<List<int>> insertAll(List<VisitanteFloorModel> listVisitante) {
    return _visitanteFloorModelInsertionAdapter.insertListAndReturnIds(
        listVisitante, OnConflictStrategy.abort);
  }
}
