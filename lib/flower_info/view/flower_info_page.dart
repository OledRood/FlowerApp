import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flowers_app/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/flower_model.dart';
import '../../resources/app_images.dart';
import '../../test/widgets/calendar_widget.dart';
import '../../ui/theme/dark_theme.dart';
import '../bloc/flower_info_bloc.dart';

class FlowerInfoPage extends StatelessWidget {
  final String flowerId;

  const FlowerInfoPage({super.key, required this.flowerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlowerInfoBloc(),
      child: _FlowerInfoWidget(
        flowerId: flowerId,
      ),
    );
  }
}

class _FlowerInfoWidget extends StatefulWidget {
  final String flowerId;

  const _FlowerInfoWidget({super.key, required this.flowerId});

  @override
  State<_FlowerInfoWidget> createState() => _FlowerInfoWidgetState();
}

class _FlowerInfoWidgetState extends State<_FlowerInfoWidget> {
  @override
  void initState() {
    super.initState();
    context
        .read<FlowerInfoBloc>()
        .add(FlowerInfoGettingStartData(flowerId: widget.flowerId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<FlowerInfoBloc, FlowerInfoState>(
        listener: (context, state) {
          if (state is FlowerInfoSaved) {
            context
                .read<FlowerInfoBloc>()
                .add(FlowerInfoGettingStartData(flowerId: widget.flowerId));
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              BlocBuilder<FlowerInfoBloc, FlowerInfoState>(
                builder: (context, state) {
                  late Flower flower;
                  if (state is FlowerInfoGetFlower) {
                    final flower = state.flower;

                    return ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 60),
                            Row(
                              children: [
                                _ImagePickerWidget(
                                    photo: File(flower.photoPath)),
                                Expanded(child: SizedBox()),
                                _NameFieldWidget(name: flower.name),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                            const SizedBox(height: 30),
                            _DescriptionWidget(description: flower.description),
                            const SizedBox(height: 30),
                            _WateringCalendarWidget(
                              wateringDates: flower.wateringDates,
                            ),
                            const SizedBox(height: 30),
                            _DatePlantFieldWidget(
                              plantDate: flower.plantDate,
                            ),
                            const SizedBox(height: 30),
                            _DeleteButton(
                              flowerId: flower.id,
                            )
                          ],
                        ),
                      ],
                    );
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ));
                },
              ),
              const _AppBarWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: AppColors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackButton(),
          Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () {
              context.read<FlowerInfoBloc>().add(FlowerInfoSaving());
            },
            child: Center(
              child: Text(
                "Сохранить",
                style: context.theme.textButtonWithoutBackground,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}

class _WateringCalendarWidget extends StatefulWidget {
  final List<DateTime> wateringDates;

  const _WateringCalendarWidget({super.key, required this.wateringDates});

  @override
  State<_WateringCalendarWidget> createState() =>
      _WateringCalendarWidgetState();
}

class _WateringCalendarWidgetState extends State<_WateringCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Даты поливов',
          style: context.theme.title,
        ),
        SizedBox(height: 10),
        CalendarWidget(
          wateringDates: widget.wateringDates,
        ),
      ],
    );
  }
}

class _ImagePickerWidget extends StatefulWidget {
  final File? photo;

  const _ImagePickerWidget({super.key, required this.photo});

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

      context.read<FlowerInfoBloc>().add(PhotoAdding(_image!));
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
                border: Border.all(
                  width: 0.5,
                  color: AppColors.white70,
                ),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.white70,
                size: 30,
              ))
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

class _NameFieldWidget extends StatefulWidget {
  final String name;

  const _NameFieldWidget({super.key, required this.name});

  @override
  State<_NameFieldWidget> createState() => _NameFieldWidgetState();
}

class _NameFieldWidgetState extends State<_NameFieldWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowerInfoBloc, FlowerInfoState>(
      // buildWhen: (_, current) => current is FlowerInfoErrors,
      builder: (context, state) {
        // final errors = state as FlowerInfoErrors;
        // final nameError = errors.nameError;
        return SizedBox(
          width: 180,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                hintText: "Имя",
                hintStyle:
                    // nameError
                    //     ? context.theme.flowerNameError
                    //     :
                    context.theme.flowerName,
                border: InputBorder.none,
                counterText: ""),
            maxLength: 11,
            textAlign: TextAlign.center,
            style: context.theme.flowerName,
            onChanged: (text) =>
                context.read<FlowerInfoBloc>().add(NameAddingEvent(text)),
          ),
        );
      },
    );
  }
}

class _DescriptionWidget extends StatefulWidget {
  final String description;

  const _DescriptionWidget({super.key, required this.description});

  @override
  State<_DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<_DescriptionWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.description;
  }

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
            controller: _controller,
            onChanged: (description) => context
                .read<FlowerInfoBloc>()
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

class _DatePlantFieldWidget extends StatefulWidget {
  final String plantDate;

  const _DatePlantFieldWidget({super.key, required this.plantDate});

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
            initialValue: widget.plantDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            textAlign: TextAlign.center,
            // icon: Icon(Icons.calendar_today),
            cursorColor: AppColors.primaryYellow,
            // dateLabelText: 'Выберите дату',
            // locale: Locale('ru'), // Русский язык
            onChanged: (date) {
              context.read<FlowerInfoBloc>().add(DatePlantAdding(date));
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

class _DeleteButton extends StatelessWidget {
  final String flowerId;

  const _DeleteButton({super.key, required this.flowerId});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context
              .read<FlowerInfoBloc>()
              .add(FlowerInfoRemoving(flowerId: flowerId));
          Navigator.pop(context);
        },
        style: ButtonStyle().copyWith(
            backgroundColor: WidgetStatePropertyAll(AppColors.errorsRed)),
        child: Text('Удалить'));
  }
}
