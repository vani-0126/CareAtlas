import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/Dashboards/prepare_dashboard.dart';
import 'package:health_bridge/Dashboards/track_dashboard.dart';
import 'package:health_bridge/HealthSummary/models/health_summary.dart';
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
  HealthSummary healthSummary = HealthSummary();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text('Main Dashboard')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCEBFF),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.explore,
                    size: 36,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "CareAtlas",
                        style: GoogleFonts.inter(
                          color: Color(0xFF20354D),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Your health made easier to understand.",
                        style: GoogleFonts.inter(
                          color: Color(0xFF66788A),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your health journey organized.",
                  style: GoogleFonts.inter(
                    color: Color(0xFF20354D),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Understand your health. Prepare for visits. Track your progress.",
                  style: GoogleFonts.inter(
                    color: Color(0xFF66788A),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),

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
                const SizedBox(height: 20),

                // Track Button
                AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  transform: Matrix4.translationValues(
                    0,
                    animateTrack ? 0 : 20,
                    0,
                  ),
                  child: AnimatedOpacity(
                    opacity: animateTrack ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 800),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackDashboard(),
                          ),
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
                const SizedBox(height: 20),

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
                            builder: (context) =>
                                PrepareDashboard(healthSummary: healthSummary),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
