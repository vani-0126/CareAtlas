import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/HealthSummary/allergies.dart';
import 'package:health_bridge/HealthSummary/health_notes.dart';
import 'package:health_bridge/HealthSummary/medical_conditions.dart';
import 'package:health_bridge/HealthSummary/medical_history.dart';
import 'package:health_bridge/HealthSummary/medications.dart';
import 'package:health_bridge/HealthSummary/models/health_summary.dart';
import 'package:health_bridge/Database/database_helper.dart';

class ManagmentScreen extends StatefulWidget {
  final HealthSummary healthSummary;

  const ManagmentScreen({super.key, required this.healthSummary});
  @override
  State<ManagmentScreen> createState() => ManagmentScreenState();
}

class ManagmentScreenState extends State<ManagmentScreen> {
  Future<void> _refreshHealthSummary() async {
    final db = DatabaseHelper.instance;

    final conditions = await db.getSummaryEntries('conditions');
    final medications = await db.getSummaryEntries('medications');
    final allergies = await db.getSummaryEntries('allergies');
    final histories = await db.getSummaryEntries('medical_histories');
    final notes = await db.getSummaryEntries('health_notes');

    if (!mounted) return;

    setState(() {
      widget.healthSummary.conditions = conditions;
      widget.healthSummary.medications = medications;
      widget.healthSummary.allergies = allergies;
      widget.healthSummary.histories = histories;
      widget.healthSummary.notes = notes;
    });
  }

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
              "Which category would you like to manage your information",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 40),
            Card(
              color: const Color.fromARGB(248, 177, 63, 221),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicalConditions(
                        healthSummary: widget.healthSummary,
                        fromManagmentScreen: true,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.manage_accounts,
                        size: 35,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Medical Conditions",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: const Color.fromARGB(248, 177, 63, 221),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Medications(
                        healthSummary: widget.healthSummary,
                        fromManagmentScreen: true,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.manage_accounts,
                        size: 35,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Medications",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: const Color.fromARGB(248, 177, 63, 221),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Allergies(
                        healthSummary: widget.healthSummary,
                        fromManagmentScreen: true,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.manage_accounts,
                        size: 35,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Allergies",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: const Color.fromARGB(248, 177, 63, 221),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicalHistory(
                        healthSummary: widget.healthSummary,
                        fromManagmentScreen: true,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.manage_accounts,
                        size: 35,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Medical History",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: const Color.fromARGB(248, 177, 63, 221),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HealthNotes(
                        healthSummary: widget.healthSummary,
                        fromManagmentScreen: true,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.manage_accounts,
                        size: 35,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Health Notes",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
