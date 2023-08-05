import 'package:flutter/material.dart';
import 'package:short_route/screen/Location/Location.dart';
// import 'package:short_route/screen/Location/location.dart';
import 'package:short_route/util/constant.dart';
import 'package:intl/intl.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({Key? key}) : super(key: key);

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime dateTime = DateTime.now();
  TextEditingController dateController = TextEditingController();
  bool _showLocations = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            padding: const EdgeInsets.all(15.0),
            primary: Colors.white,
            backgroundColor: const Color.fromARGB(255, 39, 108, 46),
            textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  LocationScreen()),
            );
          },
          child: const Center(child: Text("Next")),
        ),
      ],
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 39, 77, 108),
                    size: 45,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.notifications,
                    color: Color.fromARGB(255, 39, 77, 108),
                    size: 45,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.person_pin,
                    color: Color.fromARGB(255, 39, 77, 108),
                    size: 45,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: dateController,
              onTap: () async {
                DateTime? date = await pickDateTime();
                if (date != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd, HH:mm:ss a').format(date);
                  setState(() {
                    dateController.text = formattedDate;
                    _showLocations = true;
                  });
                }
              },
              readOnly: true,
              cursorColor: textSecondary,
              style: const TextStyle(color: textSecondary, fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                filled: true,
                fillColor: Colors.white30,
                labelText: 'Select Date',
                labelStyle: const TextStyle(color: textPrimary, fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: bgPrimary),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: textWarning,
                    )),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: textWarning,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: bgPrimary),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _showLocations
              ? Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Whitelist',
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                            color: Color.fromARGB(255, 39, 108, 46),
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 0, 212, 0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Badulla railway Station',
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 82, 152, 89),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 0, 212, 0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'X3Q5+259, Post Office Road, Badulla 90000',
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 82, 152, 89),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 0, 212, 0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Uva Provincial Council Library Service Auditorium',
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 82, 152, 89),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      this.dateTime = dateTime;
    });
    return dateTime;
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: dateTime,
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: textPrimary, // header background color
                onPrimary: textActive, // header text color
                onSurface: textPrimary, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: textPrimary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: textPrimary, // header background color
              onPrimary: textActive, // header text color
              onSurface: textPrimary, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: textPrimary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      });
}
