import 'package:{{project_name}}/app/app.dart';
import 'package:{{project_name}}/bootstrap.dart';
import 'package:injectable/injectable.dart';

void main() {
  bootstrap(Environment.test, () => const App());
}
