import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:flutter/material.dart';

class ShadowContainerTemplate extends StatelessWidget {
  final Widget body;
  final List<double>? bodyStops;
  final List<Color>? bodyColors;
  final Alignment? begin;
  final Alignment? end;
  const ShadowContainerTemplate({
    super.key,
    required this.body,
    this.bodyStops,
    this.bodyColors,
    this.begin,
    this.end,
  });

  List<Color> get _resolvedBodyColors =>
      bodyColors ?? const [AppColours.white, AppColours.white];

  List<double> get _resolvedBodyStops {
    final colors = _resolvedBodyColors;
    if (bodyStops != null && bodyStops!.length == colors.length) {
      return bodyStops!;
    }
    return switch (colors.length) {
      3 => const [0.0, 0.1, 1.0],
      4 => const [0.0, 0.1, 0.9, 1.0],
      _ => const [0.0, 1.0],
    };
  }

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      bodyStops: _resolvedBodyStops,
      topStops: const [0.0, 0.5, 1.0],
      shadowColor: Color.lerp(
        AppColours.hireCyanBright,
        AppColours.white,
        0.7,
      )!,
      topGradientColors: const [
        AppColours.hireCyanElectric,
        AppColours.hireCyanBright,
        AppColours.darkVividTeal,
      ],
      begin: begin ?? Alignment.topRight,
      end: end ?? Alignment.bottomLeft,
      bodyGradientColors: _resolvedBodyColors,
      borderColor: Color.lerp(
        AppColours.hireCyanBright,
        AppColours.white,
        0.5,
      )!,
      body: body,
    );
  }
}
