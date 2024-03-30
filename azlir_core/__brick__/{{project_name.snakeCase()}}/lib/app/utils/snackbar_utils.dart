import 'package:flutter/material.dart';

void showSnackbar(
  BuildContext context,
  String message, {
  bool hideCurrentSnackbar = false,
}) {
  if (hideCurrentSnackbar) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

void showErrorSnackbar(
  BuildContext context,
  String message, {
  bool hideCurrentSnackBar = true,
}) {
  final theme = Theme.of(context);

  if (hideCurrentSnackBar) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onErrorContainer,
        ),
      ),
      backgroundColor: theme.colorScheme.errorContainer,
    ),
  );
}
