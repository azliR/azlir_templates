import 'dart:io';

import 'package:dartx/dartx_io.dart';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final projectName = context.vars['project_name'] as String;
  final orgName = context.vars['org_name'] as String;
  final applicationId = context.vars['application_id'] as String;
  final description = context.vars['description'] as String;

  final generator = await MasonGenerator.fromBrick(
    Brick.version(name: 'very_good_core', version: 'any'),
  );
  final veryGoodCoreVars = <String, dynamic>{
    'project_name': projectName,
    'org_name': orgName,
    'application_id': applicationId,
    'description': description,
  };
  await generator.hooks.postGen(vars: veryGoodCoreVars);

  final currentDir = Directory.current.directory(projectName);

  final makeCommands = [
    'pub_upgrade_major',
    'fix_lint',
    'format',
    'icons_launcher',
    'native_splash'
  ];
  for (final command in makeCommands) {
    print('✨ Running: make $command');
    final result =
        await Process.run('make', [command], workingDirectory: currentDir.path);
    printResult(result);
  }

  await deleteIfExists(currentDir
      .file('android/app/src/main/res/values/ic_launcher_background.xml'));
}

Future<void> deleteIfExists(FileSystemEntity entity) async {
  if (await entity.exists()) {
    await entity.delete(recursive: true);
  }
}

void printResult(ProcessResult result) {
  if (result.exitCode != 0) {
    print('  ❌ Error ❌');
    print(result.stderr);
  } else {
    print('  ✅ Success ✅');
  }
}
