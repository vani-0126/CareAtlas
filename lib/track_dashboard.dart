import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackDashboard extends StatefulWidget {
  const TrackDashboard({super.key});
  @override
  State<TrackDashboard> createState() => _TrackDashboardState();
}

class _TrackDashboardState extends State<TrackDashboard> {
  bool animateTreatmentTimeline = false;
  bool animateSymptom = false;
  bool animateTrack = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        animateTrack = true;
      });
    });
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        animateTreatmentTimeline = true;
      });
    });
    Future.delayed(Duration(milliseconds: 900), () {
      setState(() {
        animateSymptom = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      appBar: AppBar(title: Text('Track Dashboard')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateTrack ? 0 : 20, 0),
              child: AnimatedOpacity(
                opacity: animateTrack ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.track_changes,
                            size: 35,
                            color: Colors.greenAccent,
                          ),
                          SizedBox(width: 15),

                          Text(
                            "Track",
                            style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      Text(
                        "Monitor your health journey with easy-to-follow tools and insights.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),

            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                animateTreatmentTimeline ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateTreatmentTimeline ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: InkWell(
                  onTap: () {
                    //Taken to Page with Medical Translator
                  },
                  child: Card(
                    color: Color(0xFF32CD32),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.timeline, color: Colors.white, size: 35),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Treatment Timeline",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "View treatments and milestones",
                                style: GoogleFonts.inter(
                                  color: Color(0xFFFAF9F6),
                                  fontSize: 14,
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
            SizedBox(height: 60),

            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                animateSymptom ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateSymptom ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: InkWell(
                  onTap: () {
                    //Taken to Page with Medical Translator
                  },
                  child: Card(
                    color: Color(0xFF93C572),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_note, color: Colors.white, size: 35),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Symptom Tracker",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Record symptoms over time",
                                style: GoogleFonts.inter(
                                  color: Color(0xFFFAF9F6),
                                  fontSize: 14,
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
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
