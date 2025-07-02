import 'package:flowers_app/ui/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../features/flower_info/flower_info_di.dart';
import '../features/flower_info/models/flower_info_view_model.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  final String flowerId;

  const CalendarWidget({super.key, required this.flowerId});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends ConsumerState<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  late final List<DateTime> _selectedDays;

  @override
  void initState() {
    final flowerInfoState = ref.read(
      FlowerInfoDi.flowerInfoViewModelProvider(widget.flowerId),
    );
    _selectedDays = List<DateTime>.from(flowerInfoState.wateringDates ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FlowerInfoViewModel flowerInfoViewModel = ref.watch(
      FlowerInfoDi.flowerInfoViewModelProvider(widget.flowerId).notifier,
    );
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime(2024, 1, 1),
      lastDay: DateTime(now.year + 1, now.month, now.day),
      selectedDayPredicate: (day) =>
          _selectedDays.any((selectedDay) => isSameDay(selectedDay, day)),
      onDaySelected: (selectedDay, focusedDay) =>
          _onDaySelected(selectedDay, flowerInfoViewModel),

      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay; // Обновляем focusedDay при перелистывании
        });
      },
      calendarFormat: _calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: const HeaderStyle(formatButtonVisible: false),
      calendarBuilders: CalendarBuilders(
        // Кастомизация focusedDay (текущий день)
        todayBuilder: (context, date, _) {
          return _FocusDayWidget(date: date);
        },
        // Кастомизация выбранных дней
        selectedBuilder: (context, date, _) {
          return _SelectedDayWidget(date: date);
        },
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, FlowerInfoViewModel viewModel) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
      viewModel.addDateWatering(_selectedDays);
    });
  }
}

class _SelectedDayWidget extends StatelessWidget {
  final DateTime date;

  const _SelectedDayWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryYellow,
        shape: BoxShape.circle, // Круглая форма
      ),
      child: Text(
        '${date.day}',
        style: TextStyle(
          color: AppColors.black, // Белый текст
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _FocusDayWidget extends StatelessWidget {
  final DateTime date;

  const _FocusDayWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.primaryYellow, width: 2),
        shape: BoxShape.circle,
      ),
      child: Text(
        '${date.day}',
        // style: TextStyle(
        //   color: Colors.white, // Белый текст
        //   fontWeight: FontWeight.bold,
        // ),
      ),
    );
    ;
  }
}
