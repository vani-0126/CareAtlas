import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrepareDashboard extends StatefulWidget {
  const PrepareDashboard({super.key});
  @override
  State<PrepareDashboard> createState() => _PrepareDashboardState();
}

class _PrepareDashboardState extends State<PrepareDashboard> {
  bool animateSummary = false;
  bool animateQuestion = false;
  bool animatePrepare = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        animatePrepare = true;
      });
    });
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        animateQuestion = true;
      });
    });
    Future.delayed(Duration(milliseconds: 900), () {
      setState(() {
        animateSummary = true;
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
              transform: Matrix4.translationValues(
                0,
                animatePrepare ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animatePrepare ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.event_note,
                            size: 35,
                            color: Colors.purple,
                          ),
                          SizedBox(width: 15),

                          Text(
                            "Prepare",
                            style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      Text("Get ready for appointments with helpful tools"),
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
                animateQuestion ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateQuestion ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: InkWell(
                  onTap: () {
                    //Taken to Page with Medical Translator
                  },
                  child: Card(
                    color: Color(0xFFCF9FFF),
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
                          Icon(Icons.quiz, color: Colors.white, size: 35),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Question Builder",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Prepare questions before visits",
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
                animateSummary ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateSummary ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: InkWell(
                  onTap: () {
                    //Taken to Page with Medical Translator
                  },
                  child: Card(
                    color: Color(0xFFD57DED),
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
                          Icon(
                            Icons.description,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "My Health Summary",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Review Important Visit notes",
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
