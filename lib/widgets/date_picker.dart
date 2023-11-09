import 'package:flutter/material.dart';

class DatePickerCustom {
  Future<DateTime?> showStartDatePicker(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final result = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime? result;

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        result = DateTime.now();
                        Navigator.of(context).pop(result);
                      },
                      child: const Text('Today'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        result = _getNextWeekday(DateTime.monday);
                        Navigator.of(context).pop(result);
                      },
                      child: const Text('Next Monday'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        result = _getNextWeekday(DateTime.tuesday);
                        Navigator.of(context).pop(result);
                      },
                      child: const Text('Next Tuesday'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        result = DateTime.now().add(const Duration(days: 7));
                        Navigator.of(context).pop(result);
                      },
                      child: const Text('After 1 Week'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 240,
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    onDateChanged: (date) {
                      result = date;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(result);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return result;
  }

  Future<DateTime?> showEndDatePicker(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final result = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime? result;

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        result = DateTime.now();
                        Navigator.of(context).pop(null);
                      },
                      child: const Text('No Date'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        result = DateTime.now();
                        Navigator.of(context).pop(result);
                      },
                      child: const Text('Today'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 240,
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    onDateChanged: (date) {
                      result = date;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(result);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return result;
  }

  DateTime _getNextWeekday(int desiredWeekday) {
    DateTime currentDate = DateTime.now();
    int daysUntilNextWeekday = (desiredWeekday - currentDate.weekday + 7) % 7;
    return currentDate.add(Duration(days: daysUntilNextWeekday));
  }
}