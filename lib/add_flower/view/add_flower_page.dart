import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flowers_app/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../ui/theme/dark_theme.dart';
import '../bloc/add_flower_bloc.dart';

class AddFlowerPage extends StatelessWidget {
  const AddFlowerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFlowerBloc(),
      child: Scaffold(
        body: AddFlowerPageWidget(),
      ),
    );
  }
}

class AddFlowerPageWidget extends StatelessWidget {
  const AddFlowerPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFlowerBloc, AddFlowerState>(
      listener: (context, state) {
        if (state is AddFlowerCompleted) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton()),
                Row(
                  children: [
                    _ImagePickerWidget(),
                    Expanded(child: SizedBox()),
                    _NameFieldWidget(),
                    Expanded(child: SizedBox()),

                  ],
                ),
                const SizedBox(height: 20),
                _DatePlantFieldWidget(),
                const SizedBox(height: 20),
                _DescriptionWidget(),
                const SizedBox(height: 20),
                // _FullInfoWidget(),
                _DateFieldLastWateringWidget(),
                const SizedBox(height: 20),
                AddButtonWidget(),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ImagePickerWidget extends StatefulWidget {
  const _ImagePickerWidget({super.key});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<_ImagePickerWidget> {
  File? _image; // Хранение выбранного изображения
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      context.read<AddFlowerBloc>().add(PhotoAdding(_image!));
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
                leading: Icon(Icons.photo_library),
                title: Text('Галерея'),
                onTap: () {
                  _pickImage(ImageSource.gallery, context);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Камера'),
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
    return BlocBuilder<AddFlowerBloc, AddFlowerState>(
      buildWhen: (_, current) => current is AddFlowerErrors,
      builder: (context, state) {
        final errors = state as AddFlowerErrors;
        final photoError = errors.photoError;
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
                    border: Border.all(
                      width: 0.5,
                      color:
                          photoError ? AppColors.errorsRed : AppColors.white70,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: photoError ? AppColors.errorsRed : AppColors.white70,
                    size: 30,
                  ))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _image!,
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
        );
      },
    );
  }
}

class _NameFieldWidget extends StatelessWidget {
  const _NameFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFlowerBloc, AddFlowerState>(
      buildWhen: (_, current) => current is AddFlowerErrors,
      builder: (context, state) {
        final errors = state as AddFlowerErrors;
        final nameError = errors.nameError;
        return SizedBox(
          width: 180,
          child: TextField(
            decoration: InputDecoration(
                hintText: "Имя",
                hintStyle: nameError
                    ? context.theme.flowerNameError
                    : context.theme.flowerName,
                border: InputBorder.none,
                counterText: ""),
            maxLength: 11,
            textAlign: TextAlign.center,
            style: context.theme.flowerName,
            onChanged: (text) =>
                context.read<AddFlowerBloc>().add(NameAddingEvent(text)),
          ),
        );
      },
    );
  }
}

class _DatePlantFieldWidget extends StatefulWidget {
  const _DatePlantFieldWidget({super.key});

  @override
  State<_DatePlantFieldWidget> createState() => _DatePlantFieldWidgetState();
}

class _DatePlantFieldWidgetState extends State<_DatePlantFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Дата посадки',
          style: context.theme.title,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.greyContainer,
              border: Border.all(width: 0.5, color: AppColors.white70),
              borderRadius: BorderRadius.circular(20)),
          child: DateTimePicker(
            type: DateTimePickerType.date,
            // Только дата
            dateMask: 'dd.MM.yyyy',
            // Формат даты
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            textAlign: TextAlign.center,
            // icon: Icon(Icons.calendar_today),
            cursorColor: AppColors.primaryYellow,
            // dateLabelText: 'Выберите дату',
            // locale: Locale('ru'), // Русский язык
            onChanged: (date) {
              // print(date);
              context.read<AddFlowerBloc>().add(DatePlantAdding(date));
            },
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Описание',
          style: context.theme.title,
        ),
        SizedBox(height: 10),
        Container(
          height: 400,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.greyContainer,
              border: Border.all(width: 0.5, color: AppColors.white70),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            onChanged: (description) => context
                .read<AddFlowerBloc>()
                .add(DescriptionAdding(description)),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
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

class _DateFieldLastWateringWidget extends StatefulWidget {
  const _DateFieldLastWateringWidget({super.key});

  @override
  State<_DateFieldLastWateringWidget> createState() =>
      _DateFieldLastWateringWidgetState();
}

class _DateFieldLastWateringWidgetState
    extends State<_DateFieldLastWateringWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Дата последнего полива',
          style: context.theme.title,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.greyContainer,
              border: Border.all(width: 0.5, color: AppColors.white70),
              borderRadius: BorderRadius.circular(20)),
          child: DateTimePicker(
            textAlign: TextAlign.center,
            type: DateTimePickerType.date,
            // Только дата
            dateMask: 'dd.MM.yyyy',
            // Формат даты
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),

            // icon: Icon(Icons.calendar_today),
            cursorColor: AppColors.primaryYellow,
            // dateLabelText: 'Выберите дату',
            // locale: Locale('ru'), // Русский язык
            onChanged: (date) =>
                context.read<AddFlowerBloc>().add(DateWateringAdding(date)),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFlowerBloc, AddFlowerState>(
      // buildWhen: (_, current) => current is AddFlowerErrors,
      builder: (context, state) {
        final errors = state as AddFlowerErrors;
        final nameError = errors.nameError;
        final photoError = errors.photoError;
        return TextButton(
            onPressed: () {
              debugPrint('pressed');
              context.read<AddFlowerBloc>().add(const AddButtonTapping());

              final currentState = context.read<AddFlowerBloc>().state;
              if (nameError || photoError) {
                Fluttertoast.showToast(
                  msg: stringError(nameError, photoError),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  // Уведомление сверху
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              } else {}
            },
            child: Text('Посадить'));
      },
    );
  }

  String stringError(bool nameError, bool photoError) {
    if (nameError && photoError) {
      return 'Заполните имя и добавьте фотографию';
    }
    if (nameError) {
      return 'Заполните имя';
    }
    return "Добавьте фотографию";
  }
}
