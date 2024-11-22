import 'package:flutter/widgets.dart';

//* Уникальные ключи для роутера (можно обратиться к контексту из любого места)
abstract final class AppRouterKey {
  static final rootKey = GlobalKey<NavigatorState>();
  static final signKey = GlobalKey<NavigatorState>();
  static final dashboardKey = GlobalKey<NavigatorState>();
}
