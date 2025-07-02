import 'package:go_router/go_router.dart';

import '../../add_flower/view/add_flower_page.dart';
import '../../features/flower_info/view/flower_info_page.dart';
import '../../features/home/view/home_page.dart';
import 'app_routes.dart';

class AppRouterFactory {
  GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.home.path,
      routes: [
        GoRoute(
          path: AppRoutes.home.path,
          builder: (context, state) => const HomePageWithRefresh(),
        ),
        //Здесь надо заменить на реальный flowerId
        GoRoute(
          path: AppRoutes.flowerInfo.path, // например, '/flower/:id'
          builder: (context, state) {
            final flowerId = state.pathParameters['flowerId'];
            return FlowerInfoPage(flowerId: flowerId!);
          },
        ),

        GoRoute(
          path: AppRoutes.addFlower.path,
          builder: (context, state) => const AddFlowerPage(),
        ),
      ],
    );
  }
}
