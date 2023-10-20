import 'package:mongo_dart/mongo_dart.dart';
import 'package:fitsaw/env/env.dart';

Future<Db> dbProvider() async {
  var db = await Db.create(Env.mongoURI);

  await db.open();

  return db;
}
