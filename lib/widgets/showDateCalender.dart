import 'package:flutter/material.dart';

DateTime selectedDateCalendor;
Widget showDateCalendor(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.calendar_today),
    onPressed: () {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2019, 1),
          lastDate: DateTime(2021, 12),
          builder: (BuildContext context, Widget picker) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.grey[900],
                  onPrimary: Colors.red,
                  surface: Colors.pink,
                  onSurface: Colors.red,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: picker,
            );
          }).then(
        (selectedDate) {
          if (selectedDate != null) {
            selectedDateCalendor = selectedDate;
          }
        },
      );
    },
    //child: Text("Show Date Picker"),
  );
}
