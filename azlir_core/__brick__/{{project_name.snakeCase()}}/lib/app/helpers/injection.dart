import 'package:{{project_name}}/app/helpers/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies(String env) async =>
    getIt.init(environment: env);
