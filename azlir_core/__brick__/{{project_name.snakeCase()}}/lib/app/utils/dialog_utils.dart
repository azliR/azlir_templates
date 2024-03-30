import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:{{project_name}}/core/widgets/dialogs/confirmation_dialog.dart';

Future<bool?> showConfirmationDialog(
  BuildContext context, {
  required String message,
  String? title,
  String? negativeButtonText,
  String? positiveButtonText,
  VoidCallback? onNegativePressed,
  VoidCallback? onPositivePressed,
  Color? negativeButtonColor,
  Color? positiveButtonColor,
  Color? negativeButtonTextColor,
  Color? positiveButtonTextColor,
  Color? titleColor,
}) =>
    showModal<bool?>(
      context: context,
      builder: (BuildContext context) => ConfirmationDialog(
        message: message,
        title: title,
        titleColor: titleColor,
        negativeButtonText: negativeButtonText,
        positiveButtonText: positiveButtonText,
        onNegativePressed: onNegativePressed,
        onPositivePressed: onPositivePressed,
        negativeButtonColor: negativeButtonColor,
        positiveButtonColor: positiveButtonColor,
        negativeButtonTextColor: negativeButtonTextColor,
        positiveButtonTextColor: positiveButtonTextColor,
      ),
    );
