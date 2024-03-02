import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:fitsaw/env/env.dart';

final dbProvider = FutureProvider<Db>(
  (ref) async {
    // wrap in try catch
    var db = await Db.create("mongodb://127.0.0.1:27017/fitsaw-db?directConnection=true&serverS");
  
    await db.open();

    return db;
  },
);
