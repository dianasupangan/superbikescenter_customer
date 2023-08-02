import 'package:flutter/widgets.dart';
import 'package:superbikes/screens/change_num/change_num_screen.dart';
import 'package:superbikes/screens/request_change_num/request_change_num_screen.dart';
import 'package:superbikes/screens/home/home.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (ctx) => const HomeScreen(),
  RequestChangeNumberScreen.routeName: (ctx) =>
      const RequestChangeNumberScreen(),
  ChangeNumberScreen.routeName: (ctx) => const ChangeNumberScreen(),
};
