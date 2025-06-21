import 'package:flutter/widgets.dart';

import 'app_router_factory.dart';
import 'app_routes.dart';

class AppNavigator {
  final AppRouterFactory _appRouterFactory;

  late final _goRouter = _appRouterFactory.createRouter();

  RouterConfig<Object> get routerConfig => _goRouter;

  AppNavigator(this._appRouterFactory);

  void home() {
    _goRouter.go(AppRoutes.home.path);
  }

  void flowerInfo(String flowerId){
    _goRouter.push(AppRoutes.flowerInfo.path.replaceFirst(':flowerId', flowerId));
  }

  void addFlower(){
    _goRouter.push(AppRoutes.addFlower.path);
  }


}