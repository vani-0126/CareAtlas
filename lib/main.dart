import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Dashboards/home_dashboard.dart';
import 'database/database_helper.dart';
import 'package:health_bridge/safety_privacy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: WelcomePage());
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool animateMain = false;
  bool animateButtons = false;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      final db = await DatabaseHelper.instance.database;
      print('Database opened: ${db.isOpen}');
    } catch (e) {
      print('Database error: $e');
    }

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        animateMain = true;
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        animateButtons = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Temporary Logo
            AnimatedOpacity(
              opacity: animateMain ? 1.0 : 0.0,
              duration: Duration(milliseconds: 800),
              child: Icon(Icons.explore, size: 70, color: Color(0xFF1E3A8A)),
            ),
            SizedBox(height: 100),
            //Title/App Name
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateMain ? 0 : 20, 0),

              child: AnimatedOpacity(
                opacity: animateMain ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: Text(
                  "CareAtlas",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Subtitle/Tagline
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateMain ? 0 : 20, 0),
              child: AnimatedOpacity(
                opacity: animateMain ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: Text(
                  "Understand More. Worry Less!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Description
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateMain ? 0 : 20, 0),
              child: AnimatedOpacity(
                opacity: animateMain ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: Text(
                  "A single place to understand medical information, prepare for appointments, track your health, and organize care.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            //Get Started Button
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                animateButtons ? 0 : 20,
                0,
              ),

              child: AnimatedOpacity(
                opacity: animateButtons ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 100),
                    textStyle: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeDashboard()),
                    );
                  },
                  child: Text("Get Started"),
                ),
              ),
            ),
            SizedBox(height: 22),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SafetyPrivacyPage(),
                  ),
                );
              },
              child: Text(
                "Privacy & Safety",
                style: GoogleFonts.inter(
                  color: Colors.blueGrey,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
