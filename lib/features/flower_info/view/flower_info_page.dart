import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flowers_app/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../resources/app_images.dart';
import '../../../ui/calendar_widget.dart';
import '../../../ui/theme/dark_theme.dart';
import '../domain/flower_info_state.dart';
import '../flower_info_di.dart';
import '../models/flower_info_view_model.dart';

class FlowerInfoPage extends ConsumerWidget {
  final String flowerId;

  const FlowerInfoPage({super.key, required this.flowerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowerInfoState = ref.watch(
      FlowerInfoDi.flowerInfoViewModelProvider(flowerId),
    );
    final viewModel = ref.watch(
      FlowerInfoDi.flowerInfoViewModelProvider(flowerId).notifier,
    );
    final flowerPhotoPath = flowerInfoState.photoPath;
    final saveStatus = flowerInfoState.saveStatus;

    if (saveStatus == SaveStatus.saved) {
      return const Scaffold(
        body: Center(
          child: Icon(Icons.check, color: AppColors.primaryYellow, size: 34),
        ),
      );
    } else if (flowerInfoState.isLoading ||
        flowerPhotoPath == null ||
        flowerInfoState.wateringDates == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        _ImagePickerWidget(
                          photo: File(flowerPhotoPath),
                          viewModel: viewModel,
                        ),
                        const Expanded(child: SizedBox()),
                        _NameFieldWidget(
                          controllerOfName: viewModel.controllerOfName,
                          changeSaveStatusToReady: () =>
                              viewModel.changeSaveStatusToReady(),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _DescriptionWidget(
                      controllerOfDescription:
                          viewModel.controllerOfDescription,
                      changeSaveStatusToReady: () =>
                          viewModel.changeSaveStatusToReady(),
                    ),
                    const SizedBox(height: 30),
                    _WateringCalendarWidget(
                      flowerId: flowerInfoState.flowerId!,
                    ),
                    const SizedBox(height: 30),
                    _DatePlantFieldWidget(
                      controllerOfDatePlant: viewModel.controllerOfDatePlant,
                      viewModel: viewModel,
                    ),
                    const SizedBox(height: 30),
                    _DeleteButton(viewModel: viewModel),
                  ],
                ),
              ],
            ),
            _AppBarWidget(
              saveTap: () => viewModel.saveFlowerInfo(),
              saveStatus: saveStatus,
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends ConsumerWidget {
  final VoidCallback saveTap;
  final SaveStatus saveStatus;

  const _AppBarWidget({
    super.key,
    required this.saveTap,
    required this.saveStatus,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      color: AppColors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BackButton(),
          const Spacer(),
          GestureDetector(
            onTap: saveTap,
            child: Center(
              child: Text(
                "Сохранить",
                style: saveStatus == SaveStatus.none
                    ? context.theme.unActiveTextButton
                    : context.theme.textButtonWithoutBackground,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class _WateringCalendarWidget extends StatelessWidget {
  final String flowerId;

  const _WateringCalendarWidget({super.key, required this.flowerId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Даты поливов', style: context.theme.title),
        const SizedBox(height: 10),
        CalendarWidget(flowerId: flowerId),
      ],
    );
  }
}

class _ImagePickerWidget extends StatefulWidget {
  final FlowerInfoViewModel viewModel;
  final File? photo;

  const _ImagePickerWidget({
    super.key,
    required this.photo,
    required this.viewModel,
  });

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<_ImagePickerWidget> {
  late File? _image;

  @override
  void initState() {
    super.initState();
    _image = widget.photo;
  }

  // Хранение выбранного изображения
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.viewModel.addPhoto(_image!);
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Галерея'),
                onTap: () {
                  _pickImage(ImageSource.gallery, context);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Камера'),
                onTap: () {
                  _pickImage(ImageSource.camera, context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPhotoByPath = widget.photo!.existsSync();
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: _image == null
          ? Container(
              width: 140,
              height: 140,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.greyContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.5, color: AppColors.white70),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.white70,
                size: 30,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: isPhotoByPath
                  ? Image.file(
                      _image!,
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AppImages.photoNotFound,
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
            ),
    );
  }
}
//

class _NameFieldWidget extends StatelessWidget {
  final TextEditingController controllerOfName;
  final VoidCallback changeSaveStatusToReady;

  // final FlowerInfoViewModel viewModel;

  const _NameFieldWidget({
    super.key,
    required this.controllerOfName,
    required this.changeSaveStatusToReady,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: TextField(
        controller: controllerOfName,
        onTap: changeSaveStatusToReady,
        decoration: InputDecoration(
          hintText: "Имя",
          hintStyle:
              // nameError
              //     ? context.theme.flowerNameError
              //     :
              context.theme.flowerName,
          border: InputBorder.none,
          counterText: "",
        ),
        maxLength: 11,
        textAlign: TextAlign.center,
        style: context.theme.flowerName,
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  final TextEditingController controllerOfDescription;
  final VoidCallback changeSaveStatusToReady;

  const _DescriptionWidget({
    super.key,
    required this.controllerOfDescription,
    required this.changeSaveStatusToReady,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Описание', style: context.theme.title),
        SizedBox(height: 10),
        Container(
          height: 400,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.greyContainer,
            border: Border.all(width: 0.5, color: AppColors.white70),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controllerOfDescription,
            onTap: changeSaveStatusToReady,
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(border: InputBorder.none),
            maxLines: null,
            style: TextStyle(color: AppColors.white100),
          ),
        ),
      ],
    );
  }
}

class _DatePlantFieldWidget extends StatelessWidget {
  final TextEditingController controllerOfDatePlant;
  final FlowerInfoViewModel viewModel;

  const _DatePlantFieldWidget({
    super.key,
    required this.controllerOfDatePlant,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Дата посадки', style: context.theme.title),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.greyContainer,
            border: Border.all(width: 0.5, color: AppColors.white70),
            borderRadius: BorderRadius.circular(20),
          ),
          child: DateTimePicker(
            controller: controllerOfDatePlant,
            onChanged: (_) => viewModel.changeSaveStatusToReady(),
            type: DateTimePickerType.date,
            // Только дата
            dateMask: 'dd.MM.yyyy',
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            textAlign: TextAlign.center,
            // icon: Icon(Icons.calendar_today),
            cursorColor: AppColors.primaryYellow,
            // dateLabelText: 'Выберите дату',
            // locale: Locale('ru'), // Русский язык
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final FlowerInfoViewModel viewModel;

  const _DeleteButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        viewModel.removeFlower();
      },
      style: ButtonStyle().copyWith(
        backgroundColor: WidgetStatePropertyAll(AppColors.errorsRed),
      ),
      child: Text('Удалить'),
    );
  }
}
