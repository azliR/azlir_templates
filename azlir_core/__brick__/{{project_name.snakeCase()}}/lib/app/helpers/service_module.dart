import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> sharedPreferences() =>
      SharedPreferences.getInstance();

  @lazySingleton
  Logger get logger => Logger();
}
