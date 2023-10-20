import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'MONGO_URI', obfuscate: true)
  static final String mongoURI = _Env.mongoURI;
}
