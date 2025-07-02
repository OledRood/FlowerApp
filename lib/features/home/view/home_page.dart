import 'dart:io';

import 'package:flowers_app/extension/theme_extension.dart';
import 'package:flowers_app/ui/yellow_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../add_flower/view/add_flower_page.dart';
import '../../../core/flower_model.dart';
import '../../../notification/notification.dart';
import '../../../resources/app_images.dart';

import '../../../ui/theme/dark_theme.dart';
import '../homeDI.dart';

class HomePageWithRefresh extends ConsumerWidget {
  const HomePageWithRefresh({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(HomeDi.homeViewModel.notifier).getFlowerList();
    return HomePage();
  }
}




class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void didChangeDependencies() {
    ref.invalidate(HomeDi.homeViewModel);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    ref.invalidate(HomeDi.homeViewModel);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _HomePageContent();
  }
}

class _HomePageContent extends ConsumerWidget {
  const _HomePageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(HomeDi.homeViewModel);
    final viewModel = ref.watch(HomeDi.homeViewModel.notifier);
    final isLoading = homeState.isLoading;
    final flowerList = homeState.flowerList;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ваши растения',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView.separated(
                    itemCount: flowerList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == (flowerList.length)) {
                        return SizedBox(height: 150);
                      }
                      return _FlowerContainerWidget(flower: flowerList[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                  ),
                ),
              ],
            ),
            YellowButtonWidget(
              onPressedAction: () {
                viewModel.goToAddFlower();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowerContainerWidget extends ConsumerWidget {
  final Flower flower;

  const _FlowerContainerWidget({super.key, required this.flower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(HomeDi.homeViewModel);
    final viewModel = ref.watch(HomeDi.homeViewModel.notifier);
    final isLoading = homeState.isLoading;
    return GestureDetector(
      onTap: () => viewModel.goToFlowerInfo(flower.id),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.all(5),
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.greyContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0.2, color: Colors.white38),
        ),
        child: Row(
          children: [
            _ImageWidget(flowerPhotoPath: flower.photoPath),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text(flower.name, style: context.theme.flowerName),
                  const SizedBox(height: 15),
                  // Text(
                  //   'Дата полива: ${convertDate(widget.flower.wateringDates)}',
                  //   style: context.theme.date,
                  // ),
                  Text('${flower.flowerAge}', style: context.theme.date),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                viewModel.wateringFlower(flower.id);
              },
              behavior: HitTestBehavior.opaque,

              // Реагирует на касания даже в прозрачных областях
              child: SizedBox(
                width: 80,
                height: 90,
                // child: Icon(Icons.water_drop_outlined, size: 30,),
                child: flower.isWateringToday
                    ? Icon(Icons.water_drop, size: 30)
                    : Icon(Icons.water_drop_outlined, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertDate(final List date) {
    if (date.isEmpty) {
      return 'Отсутствует';
    }
    List dateList = date.toString().substring(1, 11).split('-');
    return dateList[2] + "." + dateList[1] + "." + dateList[0];
  }
}

class _ImageWidget extends StatelessWidget {
  final String flowerPhotoPath;

  const _ImageWidget({super.key, required this.flowerPhotoPath});

  @override
  Widget build(BuildContext context) {
    bool isPhotoByPath = File(flowerPhotoPath).existsSync();
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: (isPhotoByPath)
            ? Image.file(File(flowerPhotoPath), fit: BoxFit.cover)
            : Image.asset(AppImages.photoNotFound, fit: BoxFit.cover),
      ),
    );
  }
}
