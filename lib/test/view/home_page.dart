// import 'dart:io';
//
// import 'package:flowers_app/extension/theme_extension.dart';
// import 'package:flowers_app/flower_info/view/flower_info_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../add_flower/view/add_flower_page.dart';
// import '../../core/flower_model.dart';
// import '../../resources/app_colors.dart';
// import '../../resources/app_images.dart';
// import '../bloc/test_bloc.dart';
//
// String statePage = "";
// // List flowerList = [];
// bool isWatering = false;
//
// mixin RouteAwareMixin<T extends StatefulWidget> on State<T>
//     implements RouteAware {
//   late RouteObserver<PageRoute> _routeObserver;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _routeObserver = RouteObserver<PageRoute>();
//     final route = ModalRoute.of(context);
//     if (route is PageRoute) {
//       _routeObserver.subscribe(this, route);
//     }
//   }
//
//   @override
//   void dispose() {
//     _routeObserver.unsubscribe(this);
//     super.dispose();
//   }
//
//   @override
//   void didPopNext() {
//     // Вызывается, когда страница становится активной после возврата (например, через Navigator.pop)
//     context.read<TestBloc>().add(PageOpening());
//   }
//
//   @override
//   void didPush() {
//     // Вызывается, когда страница открывается впервые (например, через Navigator.push)
//     context.read<TestBloc>().add(PageOpening());
//   }
//
//   @override
//   void didPop() {}
//
//   @override
//   void didPushNext() {}
// }
//
// class TestPage extends StatelessWidget {
//   const TestPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TestBloc(),
//       child: _TestPageWidget(),
//     );
//   }
// }
//
// class _TestPageWidget extends StatefulWidget {
//   const _TestPageWidget({super.key});
//
//   @override
//   State<_TestPageWidget> createState() => _HomePageWidgetState();
// }
//
// class _HomePageWidgetState extends State<_TestPageWidget> with RouteAwareMixin {
//   @override
//   void initState() {
//     super.initState();
//     print('page is open');
//     context.read<TestBloc>().add(PageOpening());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Test',
//                     style: Theme.of(context).textTheme.headlineLarge,
//                   ),
//                   // IconButton(
//                   //     onPressed: () {},
//                   //     icon: Icon(Icons.delete_forever_outlined))
//                 ],
//               ),
//               const SizedBox(height: 40),
//               Expanded(
//                 child: BlocBuilder<TestBloc, TestState>(
//                   buildWhen: (_, current) => current is TestPageOpened,
//                   builder: (context, state) {
//                     if (!(state is TestPageOpened)) {
//                       return SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator());
//                     }
//                     state = state as TestPageOpened;
//                     final flowerList = state.flowerList;
//                     return ListView.separated(
//                       itemCount: flowerList.length + 1,
//                       itemBuilder: (context, index) {
//                         if (index == (flowerList.length)) {
//                           return SizedBox(height: 150);
//                         }
//                         return _FlowerContainerWidget(
//                             flower: flowerList[index]);
//                       },
//                       separatorBuilder: (context, index) {
//                         return SizedBox(height: 20);
//                       },
//                     );
//
//                     Future.delayed(Duration(seconds: 2));
//                     return Center(
//                         child: Container(
//                       color: Colors.red,
//                       child: Text("Тотальная ошибка"),
//                     ));
//                   },
//                 ),
//               ),
//             ],
//           ),
//           _AddButtonWidget(),
//         ],
//       )),
//     );
//   }
// }
//
// class _FlowerContainerWidget extends StatefulWidget {
//   final Flower flower;
//
//   const _FlowerContainerWidget({super.key, required this.flower});
//
//   @override
//   State<_FlowerContainerWidget> createState() => _FlowerContainerWidgetState();
// }
//
// class _FlowerContainerWidgetState extends State<_FlowerContainerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => FlowerInfoPage(
//                     flowerId: widget.flower.id,
//                   )),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 0),
//         padding: EdgeInsets.all(5),
//         height: 100,
//         decoration: BoxDecoration(
//             color: AppColors.greyContainer,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(width: 0.2, color: Colors.white38)),
//         child: Row(
//           children: [
//             _ImageWidget(
//               flowerPhotoPath: widget.flower.photoPath,
//             ),
//             Expanded(child: SizedBox()),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 children: [
//                   Text(widget.flower.name, style: context.theme.flowerName),
//                   const SizedBox(height: 15),
//                   // Text(
//                   //   'Дата полива: ${convertDate(widget.flower.wateringDates)}',
//                   //   style: context.theme.date,
//                   // ),
//                   Text(
//                     '${widget.flower.flowerAge}',
//                     style: context.theme.date,
//                   ),
//                 ],
//               ),
//             ),
//             const Expanded(child: SizedBox()),
//             BlocBuilder<TestBloc, TestState>(
//                 buildWhen: (_, current) => current is TestFlowerWatered,
//                 builder: (context, state) {
//                   if (!(state is TestFlowerWatered)) {
//                     return SizedBox(
//                       width: 80,
//                       height: 90,
//                       // child: Icon(Icons.water_drop_outlined, size: 30,),
//                       child: widget.flower.isWateringToday
//                           ? Icon(
//                               Icons.water_drop,
//                               size: 30,
//                             )
//                           : Icon(
//                               Icons.water_drop_outlined,
//                               size: 30,
//                             ),
//                     );
//                   }
//                   state =  state as TestFlowerWatered;
//
//                   return GestureDetector(
//                     onTap: () {
//                       print('Watering');
//                       context
//                           .read<TestBloc>()
//                           .add(TestFlowerWatering(widget.flower.id));
//                     },
//                     behavior: HitTestBehavior.opaque,
//                     // Реагирует на касания даже в прозрачных областях
//
//                     child: ColoredBox(
//                       color: Colors.yellow,
//                       child: SizedBox(
//                         width: 80,
//                         height: 90,
//                         // child: Icon(Icons.water_drop_outlined, size: 30,),
//                         child: state.isWatered
//                             ? Icon(
//                                 Icons.water_drop,
//                                 size: 30,
//                               )
//                             : Icon(
//                                 Icons.water_drop_outlined,
//                                 size: 30,
//                               ),
//                       ),
//                     ),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String convertDate(final List date) {
//     if (date.isEmpty) {
//       return 'Отсутствует';
//     }
//     List dateList = date.toString().substring(1, 11).split('-');
//     return dateList[2] + "." + dateList[1] + "." + dateList[0];
//   }
// }
//
// class _ImageWidget extends StatelessWidget {
//   final String flowerPhotoPath;
//
//   const _ImageWidget({super.key, required this.flowerPhotoPath});
//
//   @override
//   Widget build(BuildContext context) {
//     bool isPhotoByPath = File(flowerPhotoPath).existsSync();
//     return Container(
//       height: 90,
//       width: 90,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: (isPhotoByPath)
//             ? Image.file(
//                 File(flowerPhotoPath),
//                 fit: BoxFit.cover,
//               )
//             : Image.asset(
//                 AppImages.photoNotFound,
//                 fit: BoxFit.cover,
//               ),
//       ),
//     );
//   }
// }
//
// class _AddButtonWidget extends StatelessWidget {
//   const _AddButtonWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Align(
//           alignment: Alignment.bottomCenter,
//           child: TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (_) => const AddFlowerPage()));
//                 // debugPrint('tap');
//               },
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.add),
//                     Text('Добавить'),
//                   ],
//                 ),
//               ))),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/app_images.dart';
import '../bloc/test_bloc.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestBloc(),
      child: Scaffold(
          body: TestPageWidget()
      ),
    );
  }
}

class TestPageWidget extends StatefulWidget {
  const TestPageWidget({super.key});

  @override
  State<TestPageWidget> createState() => _TestPageWidgetState();
}

class _TestPageWidgetState extends State<TestPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: BlocBuilder<TestBloc, TestState>(
          buildWhen: (_, current) {
            return current is TestPageOpened;
          },
          builder: (context, state) {
            final data = state as TestPageOpened;
            final flowerList = data.flowerList;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 55,
                  child: Row(children: [
                    Image.asset(AppImages.photoNotFound),
                    SizedBox(width: 5,),
                    Text(flowerList[index]),
                    SizedBox(width: 5,),
                    Text(true.toString())
                  ]),
                );
              },
              itemCount: flowerList.length,
            );
          },
        ),
      ),
    );
  }
}
