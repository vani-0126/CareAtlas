import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/medical_translator/medical_search.dart';
import 'lab_results_visulaizer/lab_home_page.dart';
import 'AI_medicalExplanation/AI_medicalExplainer.dart';

class UnderstandDashboard extends StatefulWidget {
  const UnderstandDashboard({super.key});
  @override
  State<UnderstandDashboard> createState() => _UnderstandDashboardState();
}

class _UnderstandDashboardState extends State<UnderstandDashboard> {
  bool animateTitle = false;
  bool animateMedicalTranslator = false;
  bool animateLabResultsVisualizer = false;
  bool animateAIMedicalExplanation = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        animateTitle = true;
      });
    });
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        animateMedicalTranslator = true;
      });
    });
    Future.delayed(Duration(milliseconds: 900), () {
      setState(() {
        animateLabResultsVisualizer = true;
      });
    });
    Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        animateAIMedicalExplanation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      appBar: AppBar(title: Text('Understand Dashboard')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateTitle ? 0 : 20, 0),
              child: AnimatedOpacity(
                opacity: animateTitle ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.medical_information,
                            size: 35,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(width: 15),

                          Text(
                            "Understand",
                            style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      Text(
                        "Learn medical information with clear explanations and helpful tools.",
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
                animateMedicalTranslator ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateMedicalTranslator ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicalSearch()),
                    );
                  },

                  child: Card(
                    color: Color.fromRGBO(137, 207, 240, 1),
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
                          Icon(Icons.menu_book, color: Colors.white, size: 35),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Medical Terms Translator",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Translate complex medical terminology.",
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
                animateLabResultsVisualizer ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateLabResultsVisualizer ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LabHomePage()),
                    );
                  },
                  child: Card(
                    color: Color(0xFFA7C7E7),
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
                          Icon(Icons.science, color: Colors.white, size: 35),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Lab Results Visualizer",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Understand blood tests and lab values.",
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
                animateAIMedicalExplanation ? 0 : 20,
                0,
              ),
              child: AnimatedOpacity(
                opacity: animateAIMedicalExplanation ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AiMedicalexplainer(),
                      ),
                    );
                  },
                  child: Card(
                    color: Color(0xFF87CEEB),
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
                          Icon(Icons.smart_toy, color: Colors.white, size: 35),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "AI Medical Explanation",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Ask questions and receive easy explanations.",
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
          ], //Ending brackets and paranthesis
        ),
      ),
    );
  }
}
