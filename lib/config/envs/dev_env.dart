import '../env.dart';

class DevEnv extends Env {
  @override
  String get envName => 'dev';
  @override
  String get baseUrl =>
      'https://hotpink-gnu-383634.hostingersite.com/abujena-dawajen-api/api/';
}
