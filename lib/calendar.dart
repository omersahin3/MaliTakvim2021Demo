import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();
  @override
  void initState() {
    selectedEvents = {};
    // TODO: implement initState
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mali Takvim 2021 Demo'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              //startingDayOfWeek: StartingDayOfWeek.sunday,
              // Day Changed
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: (selectDay, focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay; // update `_focusedDay` here as well
                });
              },
              eventLoader: _getEventsfromDay,
              // To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                ),
                //selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.rectangle,
                ),
              ),
              headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonShowsNext: false,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white)),
            ),
            ..._getEventsfromDay(selectedDay).map(
              (Event event) => ListTile(
                title: Text(event.title),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Add Event'),
                    content: TextFormField(
                      controller: _eventController,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel')),
                      TextButton(
                          onPressed: () {
                            if (_eventController.text.isEmpty) {
                              Navigator.pop(context);
                              return;
                            } else {
                              if (selectedEvents[selectedDay] != null) {
                                selectedEvents[selectedDay].add(
                                  Event(title: _eventController.text),
                                );
                              } else {
                                selectedEvents[selectedDay] = [
                                  Event(title: _eventController.text)
                                ];
                              }
                              Navigator.pop(context);
                              _eventController.clear();
                              return;
                            }
                          },
                          child: Text('Ok'))
                    ],
                  )),
          label: Text('Add Event'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
