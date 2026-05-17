import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _HookRouteAware extends RouteAware {
  _HookRouteAware({this.onDidPopNext, this.onDidPush});

  final VoidCallback? onDidPopNext;
  final VoidCallback? onDidPush;

  @override
  void didPopNext() => onDidPopNext?.call();

  @override
  void didPush() => onDidPush?.call();
}

void useRouteAware({
  required RouteObserver<ModalRoute<void>> observer,
  VoidCallback? onDidPopNext,
  VoidCallback? onDidPush,
}) {
  final context = useContext();
  final popNextRef = useRef(onDidPopNext);
  final pushRef = useRef(onDidPush);
  popNextRef.value = onDidPopNext;
  pushRef.value = onDidPush;

  final route = ModalRoute.of(context);

  useEffect(() {
    if (route is! PageRoute) return null;
    final aware = _HookRouteAware(
      onDidPopNext: () => popNextRef.value?.call(),
      onDidPush: () => pushRef.value?.call(),
    );
    observer.subscribe(aware, route);
    return () => observer.unsubscribe(aware);
  }, [route, observer]);
}
