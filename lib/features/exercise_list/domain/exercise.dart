import 'package:realm/realm.dart';

part 'exercise.g.dart';

// "$" distinguishes this class from the class generated by Realm.
// According to Realm docs, this isn't best practice but is necessary for
// feature-first architecture.
@RealmModel()
class $Exercise {
  @PrimaryKey()
  late final ObjectId id;

  late final String name;
  late final String? description;
  late final bool isTimed;
  late final bool isWeighted;
  late final List<String> tags;
}