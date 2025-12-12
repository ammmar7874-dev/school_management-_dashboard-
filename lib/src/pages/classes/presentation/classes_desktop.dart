import 'package:flutter/material.dart';

class ClassesScreen extends StatelessWidget {
  final VoidCallback? onAddClass;

  const ClassesScreen({super.key, this.onAddClass});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Class Schedule',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Schedule your class',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onAddClass ?? () {},
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Add Class',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Calendar Section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildCalendar(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    // Calendar data
    final events = [
      _CalendarEvent(
        date: 3,
        day: 'Wed',
        title: 'Design new pages',
        time: '10:00AM - 11:30AM',
        color: Colors.green.withOpacity(0.2),
        textColor: Colors.green[700]!,
      ),
      _CalendarEvent(
        date: 8,
        day: 'Mon',
        title: 'Meeting',
        time: '10:00AM - 12:00AM',
        color: Colors.purple.withOpacity(0.2),
        textColor: Colors.purple[700]!,
      ),
      _CalendarEvent(
        date: 13,
        day: 'Sat',
        title: 'Visit Course',
        time: '10:00AM - 8:00AM',
        color: Colors.red.withOpacity(0.2),
        textColor: Colors.red[700]!,
      ),
      _CalendarEvent(
        date: 18,
        day: 'Thu',
        title: 'Design New Pages',
        time: '1:00AM - 3:30AM',
        color: Colors.blue.withOpacity(0.2),
        textColor: Colors.blue[700]!,
      ),
      _CalendarEvent(
        date: 23,
        day: 'Tue',
        title: 'Design new pages',
        time: '9:00AM - 11:30AM',
        color: Colors.green.withOpacity(0.2),
        textColor: Colors.green[700]!,
      ),
      _CalendarEvent(
        date: 27,
        day: 'Sat',
        title: 'Type to add',
        time: '10:00AM - 11:00AM',
        color: Colors.purple.withOpacity(0.2),
        textColor: Colors.purple[700]!,
      ),
      _CalendarEvent(
        date: 1,
        day: 'Wed',
        title: 'Meeting',
        time: '10:00AM - 11:00AM',
        color: Colors.purple.withOpacity(0.2),
        textColor: Colors.purple[700]!,
        isNextMonth: true,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Days of week header
          Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          // Calendar grid
          Expanded(child: _buildCalendarGrid(context, events)),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(BuildContext context, List<_CalendarEvent> events) {
    // Generate calendar dates (1-30 for current month, 1-5 for next month)
    final weeks = <List<int>>[];
    final currentMonthDays = List.generate(30, (i) => i + 1);
    final nextMonthDays = List.generate(5, (i) => i + 1);

    // Split into weeks (7 days each)
    for (var i = 0; i < currentMonthDays.length; i += 7) {
      if (i + 7 <= currentMonthDays.length) {
        weeks.add(currentMonthDays.sublist(i, i + 7));
      } else {
        final remaining = currentMonthDays.sublist(i);
        remaining.addAll(nextMonthDays.take(7 - remaining.length));
        weeks.add(remaining);
      }
    }

    return Expanded(
      child: Column(
        children: weeks.map((week) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: week.map((date) {
                  final weekIndex = weeks.indexOf(week);
                  final isNextMonth =
                      date <= 5 && weekIndex == weeks.length - 1;
                  final event = events.firstWhere(
                    (e) => e.date == date && e.isNextMonth == isNextMonth,
                    orElse: () => _CalendarEvent(
                      date: date,
                      day: '',
                      title: '',
                      time: '',
                      color: Colors.transparent,
                      textColor: Colors.black,
                      isNextMonth: isNextMonth,
                    ),
                  );

                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: event.title.isNotEmpty
                            ? event.color
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              date.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isNextMonth
                                    ? Colors.grey[400]
                                    : Colors.black87,
                              ),
                            ),
                            if (event.title.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Flexible(
                                child: Text(
                                  event.title,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: event.textColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Flexible(
                                child: Text(
                                  event.time,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: event.textColor.withOpacity(0.7),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CalendarEvent {
  final int date;
  final String day;
  final String title;
  final String time;
  final Color color;
  final Color textColor;
  final bool isNextMonth;

  _CalendarEvent({
    required this.date,
    required this.day,
    required this.title,
    required this.time,
    required this.color,
    required this.textColor,
    this.isNextMonth = false,
  });
}
