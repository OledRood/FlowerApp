import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flowers_app/extension/theme_extension.dart';
import 'package:flowers_app/features/add_flower/add_flower_di.dart';
import 'package:flowers_app/features/add_flower/models/add_flower_view_model.dart';
import 'package:flowers_app/ui/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddFlowerPage extends ConsumerWidget {
  const AddFlowerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: const [
              Column(
                children: [
                  Align(alignment: Alignment.centerLeft, child: BackButton()),
                  Row(
                    children: [
                      _ImagePickerWidget(),
                      Expanded(child: SizedBox()),
                      _NameFieldWidget(),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(height: 20),
                  _DatePlantFieldWidget(),
                  SizedBox(height: 20),
                  _DescriptionWidget(),
                  SizedBox(height: 20),
                  // _FullInfoWidget(),
                  _DateFieldLastWateringWidget(),
                  SizedBox(height: 20),
                  AddButtonWidget(),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePickerWidget extends ConsumerStatefulWidget {
  const _ImagePickerWidget();

  @override
  ConsumerState<_ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends ConsumerState<_ImagePickerWidget> {
  final picker = ImagePicker();

  Future<void> _pickImage(
    ImageSource source,
    AddFlowerViewModel viewModel,
  ) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final photo = File(pickedFile.path);
      viewModel.addPhoto(photo);
    }
  }

  void _showPicker(AddFlowerViewModel viewModel) {
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
                  _pickImage(ImageSource.gallery, viewModel);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Камера'),
                onTap: () {
                  _pickImage(ImageSource.camera, viewModel);
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
    final state = ref.watch(AddFlowerDi.addFlowerViewModelProvider);
    final viewModel = ref.read(AddFlowerDi.addFlowerViewModelProvider.notifier);
    return GestureDetector(
      onTap: () => _showPicker(viewModel),
      child: state.photo == null
          ? Container(
              width: 140,
              height: 140,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.greyContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 0.5,
                  color: state.photoError
                      ? AppColors.errorsRed
                      : AppColors.white70,
                ),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: state.photoError
                    ? AppColors.errorsRed
                    : AppColors.white70,
                size: 30,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                state.photo!,
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}

class _NameFieldWidget extends ConsumerWidget {
  const _NameFieldWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(AddFlowerDi.addFlowerViewModelProvider);
    final viewModel = ref.read(AddFlowerDi.addFlowerViewModelProvider.notifier);

    return SizedBox(
      width: 180,
      child: TextField(
        controller: viewModel.controllerOfName,
        onTap: () => viewModel.resetNameError(),
        decoration: InputDecoration(
          hintText: "Имя",
          hintStyle: state.nameError
              ? context.theme.flowerNameError
              : context.theme.flowerName,
          border: InputBorder.none,
          counterText: "",
        ),
        maxLength: 11,
        textAlign: TextAlign.center,
        style: context.theme.flowerName,
        onChanged: (text) {
          // Логика будет в ViewModel
        },
      ),
    );
  }
}

class _DatePlantFieldWidget extends ConsumerStatefulWidget {
  const _DatePlantFieldWidget();

  @override
  ConsumerState<_DatePlantFieldWidget> createState() =>
      _DatePlantFieldWidgetState();
}

class _DatePlantFieldWidgetState extends ConsumerState<_DatePlantFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(AddFlowerDi.addFlowerViewModelProvider);
    
    return Column(
      children: [
        Text('Дата посадки', style: context.theme.title),
        const SizedBox(height: 10),
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
            type: DateTimePickerType.date,
            dateMask: 'dd.MM.yyyy',
            initialValue: state.plantDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            textAlign: TextAlign.center,
            cursorColor: AppColors.primaryYellow,
            onChanged: (date) {
              ref
                  .read(AddFlowerDi.addFlowerViewModelProvider.notifier)
                  .addPlantData(date);
            },
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}

class _DescriptionWidget extends ConsumerWidget {
  const _DescriptionWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(AddFlowerDi.addFlowerViewModelProvider.notifier);

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
            controller: viewModel.controllerOfDescription,
            onChanged: (description) {
              // Контроллер автоматически обновляется
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

// class _FullInfoWidget extends StatelessWidget {
//   const _FullInfoWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Полная информация',
//           style: context.theme.title,
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         TextButton(onPressed: () {}, child: Text('Выбрать'))
//       ],
//     );
//   }
// }

class _DateFieldLastWateringWidget extends ConsumerStatefulWidget {
  const _DateFieldLastWateringWidget();

  @override
  ConsumerState<_DateFieldLastWateringWidget> createState() =>
      _DateFieldLastWateringWidgetState();
}

class _DateFieldLastWateringWidgetState
    extends ConsumerState<_DateFieldLastWateringWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Дата последнего полива', style: context.theme.title),
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
            textAlign: TextAlign.center,
            type: DateTimePickerType.date,
            dateMask: 'dd.MM.yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            cursorColor: AppColors.primaryYellow,
            onChanged: (date) {
              final dateTime = DateTime.parse(date);
              ref
                  .read(AddFlowerDi.addFlowerViewModelProvider.notifier)
                  .addDateWatering([dateTime]);
            },
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}

class AddButtonWidget extends ConsumerWidget {
  const AddButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(AddFlowerDi.addFlowerViewModelProvider.notifier);

    return TextButton(
      onPressed: () {
        debugPrint('pressed');
        viewModel.addFlower();
      },
      child: Text('Посадить'),
    );
  }
}
