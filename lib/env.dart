// lib/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'CF_WORKER_URL', obfuscate: true)
  static final String cfWorkerUrl = _Env.cfWorkerUrl;

  @EnviedField(varName: 'WORKER_API_SECRET', obfuscate: true)
  static final String workerApiSecret = _Env.workerApiSecret;
}