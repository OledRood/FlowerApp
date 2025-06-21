import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../flower_info/bloc/flower_info_bloc.dart';
import '../../ui/theme/dark_theme.dart';

class CalendarWidget extends StatefulWidget {
  final List<DateTime> wateringDates;

  const CalendarWidget({super.key, required this.wateringDates});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  late final List<DateTime> _selectedDays;

  @override
  void initState() {
    super.initState();

    _selectedDays = widget.wateringDates;
    print('selectedDays: $_selectedDays');
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime(2024, 1, 1),
      lastDay: DateTime(now.year + 1, now.month, now.day),
      selectedDayPredicate: (day) =>
          _selectedDays.any((selectedDay) => isSameDay(selectedDay, day)),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          if (_selectedDays.any((day) => isSameDay(day, selectedDay))) {
            _selectedDays.removeWhere((day) =>
                isSameDay(day, selectedDay)); // Удалить, если уже выбран
          } else {
            _selectedDays.add(selectedDay); // Добавить, если не выбран
          }
          debugPrint("Выбранные дни на странице: ${_selectedDays.toString()}");
          context.read<FlowerInfoBloc>().add(DateWateringAdding(_selectedDays));
        });
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay; // Обновляем focusedDay при перелистывании
        });
      },
      calendarFormat: _calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        // Кастомизация focusedDay (текущий день)
        todayBuilder: (context, date, _) {
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
        },
        // Кастомизация выбранных дней
        selectedBuilder: (context, date, _) {
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
        },
      ),
    );
  }
}
