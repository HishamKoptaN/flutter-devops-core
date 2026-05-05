import 'env.dart';
import 'envs/dev_env.dart';
import 'envs/prod_env.dart';

class EnvConfig {
  static const String _envTag = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );
  static final Env _config = _initialize();
  static Env _initialize() {
    switch (_envTag) {
      case 'prod':
        return ProdEnv();
      case 'dev':
        return DevEnv();
      default:
        print('⚠️ Unknown environment: $_envTag, defaulting to dev');
        return DevEnv();
    }
  }

  static Env get config => _config;
  static bool get isDev => _envTag == 'dev';
  static bool get isProd => _envTag == 'prod';
  static String get currentEnv => _envTag;
}
