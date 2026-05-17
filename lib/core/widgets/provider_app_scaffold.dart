import 'dart:ui';

import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ProviderAppScaffold extends StatelessWidget {
  final Widget body;
  const ProviderAppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return _DrawerBlurWrapper(
      child: Scaffold(drawer: const ProviderDrawer(), body: body),
    );
  }
}

class _DrawerBlurWrapper extends StatefulWidget {
  final Widget child;
  const _DrawerBlurWrapper({required this.child});

  @override
  State<_DrawerBlurWrapper> createState() => _DrawerBlurWrapperState();
}

class _DrawerBlurWrapperState extends State<_DrawerBlurWrapper> {
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ProviderDrawer(),
      onDrawerChanged: (isOpen) => setState(() => _isDrawerOpen = isOpen),
      body: Stack(
        children: [
          widget.child,
          if (_isDrawerOpen)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(color: Colors.black.withAlpha(10)),
              ),
            ),
        ],
      ),
    );
  }
}
