import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          'If someone needs immediate professional medical care',
          style: textTheme.bodySmall,
        ),
        Text(
          'contact your local medical helpline or public ',
          style: textTheme.bodySmall,
        ),
        Text(
          'ambulance service.',
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
  
}