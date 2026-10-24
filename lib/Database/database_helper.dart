import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:health_bridge/SymptomTracker/symptom_tracker_events.dart';
import 'package:health_bridge/Treatment Timeline/treatment_event.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('careatlas.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE IF EXISTS symptoms');
          await db.execute('''
        CREATE TABLE symptoms (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          symptomName TEXT,
          symptomSeverity TEXT,
          symptomDate TEXT,
          symptomTime TEXT,
          symptomDuration TEXT,
          symptomNotes TEXT
        )
      ''');
        }

        if (oldVersion < 3) {
          await db.execute('''
        CREATE TABLE treatment_events (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          type TEXT NOT NULL,
          date TEXT NOT NULL,
          time TEXT,
          notes TEXT
        )
      ''');
        }
        if (oldVersion < 4) {
          await db.execute('''
    CREATE TABLE conditions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data TEXT NOT NULL
    )
  ''');

          await db.execute('''
    CREATE TABLE medications (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data TEXT NOT NULL
    )
  ''');

          await db.execute('''
    CREATE TABLE allergies (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data TEXT NOT NULL
    )
  ''');

          await db.execute('''
    CREATE TABLE medical_histories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data TEXT NOT NULL
    )
  ''');

          await db.execute('''
    CREATE TABLE health_notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data TEXT NOT NULL
    )
  ''');
        }
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE symptoms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    symptomName TEXT,
    symptomSeverity TEXT,
    symptomDate TEXT,
    symptomTime TEXT,
    symptomDuration TEXT,
    symptomNotes TEXT
  )
''');
    await db.execute('''
    CREATE TABLE treatment_events (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      type TEXT NOT NULL,
      date TEXT NOT NULL,
      time TEXT,
      notes TEXT
    )
  ''');
  }

  Future<int> insertSymptom(SymptomTrackerEvent event) async {
    final db = await database;

    return await db.insert('symptoms', {
      'symptomName': event.symptomName,
      'symptomSeverity': event.symptomSeverity,
      'symptomDate': event.symptomDate?.toIso8601String(),
      'symptomTime': event.symptomTime,
      'symptomDuration': event.symptomDuration,
      'symptomNotes': event.symptomNotes,
    });
  }

  Future<int> updateSymptom(SymptomTrackerEvent event) async {
    final db = await database;

    return await db.update(
      'symptoms',
      {
        'symptomName': event.symptomName,
        'symptomSeverity': event.symptomSeverity,
        'symptomDate': event.symptomDate?.toIso8601String(),
        'symptomTime': event.symptomTime,
        'symptomDuration': event.symptomDuration,
        'symptomNotes': event.symptomNotes,
      },
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteSymptom(int id) async {
    final db = await database;

    return await db.delete('symptoms', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<SymptomTrackerEvent>> getSymptoms() async {
    final db = await database;

    final result = await db.query('symptoms', orderBy: 'symptomDate DESC');

    return result.map((row) {
      return SymptomTrackerEvent(
        id: row['id'] as int,
        symptomName: row['symptomName'] as String?,
        symptomSeverity: row['symptomSeverity'] as String?,
        symptomDate: row['symptomDate'] != null
            ? DateTime.parse(row['symptomDate'] as String)
            : null,
        symptomTime: row['symptomTime'] as String?,
        symptomDuration: row['symptomDuration'] as String?,
        symptomNotes: row['symptomNotes'] as String?,
      );
    }).toList();
  }

  Future<int> insertTreatmentEvent(TreatmentEvent event) async {
    final db = await database;

    return await db.insert('treatment_events', {
      'title': event.title,
      'type': event.type,
      'date': event.date.toIso8601String(),
      'time': event.time,
      'notes': event.notes,
    });
  }

  Future<List<TreatmentEvent>> getTreatmentEvents() async {
    final db = await database;

    final result = await db.query('treatment_events', orderBy: 'date DESC');

    return result.map<TreatmentEvent>((row) {
      return TreatmentEvent(
        id: row['id'] as int,
        title: row['title'] as String,
        type: row['type'] as String,
        date: DateTime.parse(row['date'] as String),
        time: row['time'] as String?,
        notes: row['notes'] as String?,
      );
    }).toList();
  }

  Future<int> updateTreatmentEvent(TreatmentEvent event) async {
    final db = await database;

    return await db.update(
      'treatment_events',
      {
        'title': event.title,
        'type': event.type,
        'date': event.date.toIso8601String(),
        'time': event.time,
        'notes': event.notes,
      },
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteTreatmentEvent(int id) async {
    final db = await database;

    return await db.delete(
      'treatment_events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertSummaryEntry(
    String table,
    Map<String, dynamic> entry,
  ) async {
    final db = await database;

    final data = Map<String, dynamic>.from(entry);
    data.remove('id');

    return await db.insert(table, {'data': jsonEncode(data)});
  }

  Future<List<Map<String, dynamic>>> getSummaryEntries(String table) async {
    final db = await database;

    final result = await db.query(table);

    return result.map((row) {
      final entry = Map<String, dynamic>.from(
        jsonDecode(row['data'] as String) as Map,
      );

      entry['id'] = row['id'];
      return entry;
    }).toList();
  }

  Future<int> updateSummaryEntry(
    String table,
    Map<String, dynamic> entry,
  ) async {
    final db = await database;

    final data = Map<String, dynamic>.from(entry);
    final id = data.remove('id');

    if (id == null) {
      throw ArgumentError('Cannot update an entry without an ID.');
    }

    return await db.update(
      table,
      {'data': jsonEncode(data)},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSummaryEntry(String table, int id) async {
    final db = await database;

    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
