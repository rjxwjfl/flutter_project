import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({this.formatChange, this.eventLoader, Key? key}) : super(key: key);

  final void Function()? formatChange;
  final List<dynamic> Function(DateTime)? eventLoader;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _select = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  late DateTime _focus = DateTime.now();
  DateTime? _start;
  DateTime? _end;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'en_US',
      focusedDay: _focus,
      calendarFormat: CalendarFormat.week,
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(2100, 12, 31),
      rowHeight: 100,
      rangeStartDay: _start,
      rangeEndDay: _end,
      onPageChanged: (focus) {},
      onDaySelected: (select, focus) {
        setState(() {
          _select = select;
          _focus = focus;
        });
      },
      selectedDayPredicate: (value) {
        return isSameDay(_select, value);
      },
      eventLoader: widget.eventLoader,
      headerVisible: false,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.redAccent)
      ),
      calendarStyle: const CalendarStyle(
        weekendTextStyle: TextStyle(color: Colors.redAccent)
      ),

    );
  }
}
