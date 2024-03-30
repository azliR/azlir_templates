import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/app/helpers/injection.dart';
import 'package:{{project_name}}/app/observers/app_riverpod_observer.dart';
import 'package:logger/logger.dart';

Future<void> bootstrap(
  String env,
  FutureOr<Widget> Function() builder,
) async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(env);

  FlutterError.onError = (details) {
    getIt<Logger>().f(
      details.exceptionAsString(),
      error: details,
      stackTrace: details.stack,
    );
  };

  runApp(
    ProviderScope(
      observers: [
        getIt<AppRiverpodObserver>(),
      ],
      child: await builder(),
    ),
  );
}
