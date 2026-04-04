import '../env.dart';

class ProdEnv implements Env {
  @override
  String get envName => 'prod';
  @override
  String get baseUrl =>
      'https://hotpink-hyena-564990.hostingersite.com/abujena-dawajen-api/api/';
}
