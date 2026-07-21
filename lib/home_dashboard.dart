import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/prepare_dashboard.dart';
import 'package:health_bridge/track_dashboard.dart';
import 'understand_dashboard.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});
  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  bool animateUnderstand = false;
  bool animateTrack = false;
  bool animatePrepare = false;
  bool animateOrganize = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        animateUnderstand = true;
      });
    });
    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        animateTrack = true;
      });
    });
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        animatePrepare = true;
      });
    });
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        animateOrganize = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text('After Signing in or signing up')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Understand Card - Animated
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                animateUnderstand ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateUnderstand ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UnderstandDashboard(),
                      ),
                    );
                  },
                  child: Card(
                    color: Color(0xFF3B82F6),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.medical_information,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Understand",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Medical Terms, Lab Results, and More",
                                style: GoogleFonts.inter(
                                  color: Color(0xFFFAF9F6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Spacing
            SizedBox(height: 40),

            // Track Button
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateTrack ? 0 : 20, 0),
              child: AnimatedOpacity(
                opacity: animateTrack ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrackDashboard()),
                    );
                  },
                  child: Card(
                    color: Color(0xFF10B981),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.track_changes,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Track",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Track Symptoms, Care Plans, and More",
                                style: GoogleFonts.inter(
                                  color: Color(0xFFFAF9F6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Spacing
            SizedBox(height: 40),

            // Prepare Button
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                animatePrepare ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animatePrepare ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrepareDashboard(),
                      ),
                    );
                  },
                  child: Card(
                    color: Color(0xFF9957D6),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.medical_services,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Prepare",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Prepare for Your Visits & Procedures",
                                style: GoogleFonts.inter(
                                  color: Color(0xFFFAF9F6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Spacing
            SizedBox(height: 40),

            // Organize Button
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                animateOrganize ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateOrganize ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: InkWell(
                  onTap: () {
                    //Organization Properties, Medical Records, Appointments, Medications, etc.
                  },
                  child: Card(
                    color: Color(0xFFFF4433),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_open,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Organize",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Organize Your Medical Information",
                                style: GoogleFonts.inter(
                                  color: Color(0xFFFAF9F6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
