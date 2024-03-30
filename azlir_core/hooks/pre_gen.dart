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
  var veryGoodCoreVars = <String, dynamic>{
    'project_name': projectName,
    'org_name': orgName,
    'application_id': applicationId,
    'description': description,
  };
  await generator.hooks.preGen(
    vars: veryGoodCoreVars,
    onVarsChanged: (vars) => veryGoodCoreVars = vars,
  );

  await generator.generate(
    DirectoryGeneratorTarget(Directory.current),
    vars: veryGoodCoreVars,
    fileConflictResolution: FileConflictResolution.skip,
  );

  final currentDir = Directory.current.directory(projectName);

  await deleteIfExists(currentDir.directory('assets'));
  await deleteIfExists(currentDir.directory('lib'));
  await deleteIfExists(currentDir.directory('test'));
  await deleteIfExists(currentDir.file('analysis_options.yaml'));
  await deleteIfExists(currentDir.file('flutter_native_splash.yaml'));
  await deleteIfExists(currentDir.file('icons_launcher.yaml'));
  await deleteIfExists(currentDir.file('l10n.yaml'));
  await deleteIfExists(currentDir.file('Makefile'));
  await deleteIfExists(currentDir.file('pubspec.yaml'));
}

Future<void> deleteIfExists(FileSystemEntity entity) async {
  if (await entity.exists()) {
    await entity.delete(recursive: true);
  }
}
