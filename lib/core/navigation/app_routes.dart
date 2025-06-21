enum AppRoutes {
  home(path: '/home'),
  flowerInfo(path: '/flowerInfo/:flowerId'),
  addFlower(path: '/addFlower');

  static const defaultRoute = home;
  final String path;

  const AppRoutes({required this.path});

  String get lastPathSegment => path.split('/').last;


  static final pathMap = Map.fromEntries(
    values.map((e) => MapEntry(e.path, e)),
  );
}
