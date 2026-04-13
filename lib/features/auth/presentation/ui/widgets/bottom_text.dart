import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'If someone needs immediate professional medical care',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          'contact your local medical helpline or public ',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          'ambulance service.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
  
}