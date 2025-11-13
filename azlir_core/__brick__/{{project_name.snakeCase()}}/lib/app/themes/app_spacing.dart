import 'package:flutter/material.dart';
import 'package:gap/gap.dart' as gap;

// ignore_for_file: prefer-match-file-name, avoid-returning-widgets
final class Gap extends StatelessWidget {
  const Gap(this._size, {super.key});

  factory Gap.xxsmall() => const Gap(Insets.xxsmall);
  factory Gap.xsmall() => const Gap(Insets.xsmall);
  factory Gap.small() => const Gap(Insets.small);
  factory Gap.medium() => const Gap(Insets.medium);
  factory Gap.large() => const Gap(Insets.large);
  factory Gap.xlarge() => const Gap(Insets.xlarge);
  factory Gap.xxlarge() => const Gap(Insets.xxlarge);
  factory Gap.xxxlarge() => const Gap(Insets.xxxlarge);

  final double _size;

  @override
  Widget build(BuildContext context) => gap.Gap(_size);
}

final class SliverGap extends StatelessWidget {
  const SliverGap(this._size, {super.key});

  factory SliverGap.xxsmall() => const SliverGap(Insets.xxsmall);
  factory SliverGap.xsmall() => const SliverGap(Insets.xsmall);
  factory SliverGap.small() => const SliverGap(Insets.small);
  factory SliverGap.medium() => const SliverGap(Insets.medium);
  factory SliverGap.large() => const SliverGap(Insets.large);
  factory SliverGap.xlarge() => const SliverGap(Insets.xlarge);
  factory SliverGap.xxlarge() => const SliverGap(Insets.xxlarge);
  factory SliverGap.xxxlarge() => const SliverGap(Insets.xxxlarge);

  final double _size;

  @override
  Widget build(BuildContext context) => gap.SliverGap(_size);
}

final class Insets {
  const Insets._();

  static const double scale = 1;

  /// 0
  static const double zero = 0;

  /// scale * 4
  static const double xxsmall = scale * 4;

  /// scale * 8
  static const double xsmall = scale * 8;

  /// scale * 12
  static const double small = scale * 12;

  /// scale * 16
  static const double medium = scale * 16;

  /// scale * 24
  static const double large = scale * 24;

  /// scale * 32
  static const double xlarge = scale * 32;

  /// scale * 48
  static const double xxlarge = scale * 48;

  /// scale * 64
  static const double xxxlarge = scale * 64;
  // double.infinity
  static const double infinity = double.infinity;
}
