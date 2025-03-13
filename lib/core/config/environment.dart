import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ENV { production, development, qa, local, staging }

String apiUrl = dotenv.env['API_URL'] ?? 'ERROR_KEY';
String sentryDns = dotenv.env['DSN_SENTRY'] ?? 'ERROR_KEY';
String keyOneSignal = dotenv.env['KEY_ONE_SIGNAL'] ?? 'ERROR_KEY';

Future<void> initEnvironment(ENV env) async {
  switch (env) {
    case ENV.production:
      await dotenv.load(fileName: '.env.prod');
    case ENV.development:
      await dotenv.load(fileName: '.env.development');
    case ENV.staging:
      await dotenv.load(fileName: '.env.staging');
    case ENV.qa:
      await dotenv.load(fileName: '.env.qa');
    case ENV.local:
      await dotenv.load(fileName: '.env.local');
  }
}
