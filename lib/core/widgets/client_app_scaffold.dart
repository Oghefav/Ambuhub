import 'dart:ui';
import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:ambuhub/features/client_dashboard/presentation/ui/widgets/client_drawer.dart';
import 'package:ambuhub/core/widgets/client_app_bar.dart';
import 'package:flutter/material.dart';

class ClientAppScaffold extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  const ClientAppScaffold({super.key, required this.body, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return _DrawerBlurWrapper(body: body, backgroundColor: backgroundColor);
  }
}

class _DrawerBlurWrapper extends StatefulWidget {
  final Color? backgroundColor;
  final Widget body;
  const _DrawerBlurWrapper({required this.body, this.backgroundColor});

  @override
  State<_DrawerBlurWrapper> createState() => _DrawerBlurWrapperState();
}

class _DrawerBlurWrapperState extends State<_DrawerBlurWrapper> {
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      drawer: const ClientDrawer(),
      onDrawerChanged: (isOpen) => setState(() => _isDrawerOpen = isOpen),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child:  ClientAppBar(),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.backgroundColor == null) const GradientBackground(),
          Positioned.fill(child: widget.body),
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
