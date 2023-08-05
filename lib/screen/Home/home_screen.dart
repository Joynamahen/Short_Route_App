import 'package:flutter/material.dart';
import 'package:short_route/screen/DatePicker/date_picker_screen.dart';

import '../Location/Location.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              MaterialPageRoute(builder: (context) =>  const DatePickerScreen()),
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
            height: 10,
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        ],
      ),
    );
  }
}
