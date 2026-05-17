import 'dart:ui';
import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:ambuhub/features/client_dashboard/presentation/ui/widgets/client_drawer.dart';
import 'package:ambuhub/core/widgets/client_app_bar.dart';
import 'package:flutter/material.dart';

class ClientAppScaffold extends StatelessWidget {
  final Widget body;
  const ClientAppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return _DrawerBlurWrapper(
      child: Scaffold(drawer: const ClientDrawer(), body: body),
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
      drawer: const ClientDrawer(),
      onDrawerChanged: (isOpen) => setState(() => _isDrawerOpen = isOpen),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child:  ClientAppBar(),
      ),
      body: Stack(
        children: [
          const GradientBackground(),
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
