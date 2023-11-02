import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:fitsaw/env/env.dart';

final dbProvider = FutureProvider<Db>(
  (ref) async {
    var db = await Db.create(Env.mongoURI);

    await db.open();

    return db;
  },
);
