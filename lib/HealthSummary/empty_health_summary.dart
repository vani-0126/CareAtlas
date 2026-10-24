import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/HealthSummary/medical_conditions.dart';
import 'models/health_summary.dart';

class EmptyHealthSummary extends StatefulWidget {
  final HealthSummary healthSummary;

  const EmptyHealthSummary({super.key, required this.healthSummary});
  @override
  State<EmptyHealthSummary> createState() => _EmptyHealthSummaryState();
}

class _EmptyHealthSummaryState extends State<EmptyHealthSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 181, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 181, 247),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "My Health Summary",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to your health summary! To get started please press the button below to start adding your health information. This will help you keep track of your health and make it easier for your doctor to understand your health history.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 175),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicalConditions(
                        healthSummary: widget.healthSummary,
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(35),
                splashColor: Colors.white.withValues(),
                highlightColor: Colors.white.withValues(),
                child: Card(
                  color: const Color.fromARGB(248, 177, 63, 221),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Let's get started by adding your health information!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
