import 'package:first_project_mas_ade/ui/absent/absent_screen.dart';
import 'package:first_project_mas_ade/ui/attend/attend_screen.dart';
import 'package:first_project_mas_ade/ui/attendance_history/attendance_history_screen.dart';
import 'package:first_project_mas_ade/ui/halo/halo_screen.dart';
import 'package:first_project_mas_ade/ui/quote_history/quote_history.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          SizedBox(
            height: 50,
            child: AppBar(
              backgroundColor: Colors.blueAccent,
              centerTitle: true,
              title: const Text(
                "Attendance - Flutter App Admin",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Content
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                menuItem(
                  context,
                  'assets/images/ic_absen.png',
                  "Attendance Record",
                  const AbsentScreen(),
                ),
                const SizedBox(height: 20),
                menuItem(
                  context,
                  'assets/images/ic_history.png',
                  "Absent Record",
                  const AttendScreen(),
                ),
                const SizedBox(height: 20),
                menuItem(
                  context,
                  'assets/images/ic_leave.png',
                  "Attendance History Record",
                  const AttendanceHistoryScreen(),
                ),
                const SizedBox(height: 20),
                menuItem(
                  context,
                  'assets/images/cat.gif',
                  "Put Some Quote",
                  const QuoteSubmissionScreen(),
                ),
                menuItem(
                  context,
                  'assets/images/nyan-cat.gif',
                  "Quote History Record",
                  const QuoteHistoryScreen(),
                ),
              ],
            ),
          ),

          // Footer
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: AppBar(
              backgroundColor: Colors.blueAccent,
              centerTitle: true,
              title: const Text(
                "IDN Boarding School Solo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(BuildContext context, String imagePath, String title, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(imagePath),
            height: 80,
            width: 80,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
