import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:flutter/material.dart';

class ShadowContainerTemplate extends StatelessWidget {
  final Widget body;
  final List<double>? bodyStops;
  final List<Color>? bodyColors;
  const ShadowContainerTemplate({
    super.key,
    required this.body,
    this.bodyStops,
    this.bodyColors,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      bodyStops: bodyStops ?? const [0.0, 1.0],
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
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      bodyGradientColors: bodyColors != null ? [
        Color.lerp(AppColours.hireCyanBright, AppColours.white, 0.7)!,
        AppColours.white,
        AppColours.white,
        Color.lerp(AppColours.hireCyanBright, AppColours.white, 0.7)!,
      ] :[
        AppColours.white,
        AppColours.white,
      ] ,
      borderColor: Color.lerp(
        AppColours.hireCyanBright,
        AppColours.white,
        0.5,
      )!,
      body: body,
    );
  }
}
