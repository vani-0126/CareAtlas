import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'lab_results_data.dart';
import 'enter_value_page.dart';

class LabHomePage extends StatefulWidget {
  const LabHomePage({super.key});

  @override
  State<LabHomePage> createState() => _LabHomePageState();
}

class _LabHomePageState extends State<LabHomePage> {
  final controller = TextEditingController();
  String query = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() => query = value);
  }

  void _onSubmitted(String value) {
    LabResult? result;
    try {
      result = labResults.firstWhere(
        (term) => term.testName.toLowerCase() == value.toLowerCase(),
      );
    } catch (_) {
      result = null;
    }

    if (result != null) {
      final term = result;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => EnterValuePage(labResult: term)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = labResults
        .where(
          (term) => term.testName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Results Visualizer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1E3A8A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue, width: 1.4),
                borderRadius: BorderRadius.circular(25),
              ),
              child: CupertinoSearchTextField(
                controller: controller,
                placeholder: 'Search for a labtest',
                onChanged: _onChanged,
                onSubmitted: _onSubmitted,
              ),
            ),
            if (query.isEmpty)
              const Center(child: Text("Type to search and click on a test")),

            if (query.isNotEmpty)
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: suggestions.map((term) {
                  return ListTile(
                    title: Text(term.testName),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EnterValuePage(labResult: term),
                      ),
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.science, size: 35, color: Colors.greenAccent),
                SizedBox(width: 15),

                Text(
                  "Common Lab Tests",
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text(
                "Complete Blood Count (CBC)",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              leading: Icon(Icons.bloodtype, color: Colors.red, size: 30),
              backgroundColor: const Color.fromARGB(255, 212, 242, 255),
              collapsedBackgroundColor: Colors.white,
              textColor: Color(0xFF1E3A8A),
              collapsedTextColor: Color(0xFF1E3A8A),
              iconColor: Colors.cyan,
              collapsedIconColor: Colors.cyan,

              children: [
                ListTile(
                  title: Text(
                    "White Blood Cells (WBC)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.health_and_safety,
                    color: const Color.fromARGB(255, 244, 185, 180),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EnterValuePage(
                          labResult: labResults.firstWhere(
                            (test) =>
                                test.testName == "White Blood Cell (WBC) Count",
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "Red Blood Cells (RBC)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(Icons.bloodtype, color: Colors.red, size: 20),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Hemoglobin (HGB)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(Icons.bloodtype, color: Colors.red, size: 20),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Platelets (PLT)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.healing,
                    color: const Color.fromARGB(255, 244, 228, 190),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Hematocrit (Hct)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(Icons.bloodtype, color: Colors.red, size: 20),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text(
                "Basic Metabolic Pannel (BMP)",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              leading: Icon(Icons.biotech, color: Colors.green, size: 30),
              backgroundColor: const Color.fromARGB(255, 212, 242, 255),
              collapsedBackgroundColor: Colors.white,
              textColor: Color(0xFF1E3A8A),
              collapsedTextColor: Color(0xFF1E3A8A),
              iconColor: Colors.cyan,
              collapsedIconColor: Colors.cyan,
              children: [
                ListTile(
                  title: Text(
                    "Glucose",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(Icons.query_stats, color: Colors.red, size: 20),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Calcium",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.accessibility_new,
                    color: const Color.fromARGB(255, 175, 151, 244),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Sodium",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.water_drop,
                    color: Colors.lightBlueAccent,
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Potassium",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.water_drop,
                    color: Colors.lightBlueAccent,
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Chloride",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.water_drop,
                    color: Colors.lightBlueAccent,
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Biocarbonate",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.water_drop,
                    color: Colors.lightBlueAccent,
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),

                ListTile(
                  title: Text(
                    "Carbon Dioxide",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.water_drop,
                    color: Colors.lightBlueAccent,
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text(
                "Kidney Function",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              leading: Icon(
                Icons.water_drop,
                color: Colors.lightBlueAccent,
                size: 30,
              ),
              backgroundColor: const Color.fromARGB(255, 212, 242, 255),
              collapsedBackgroundColor: Colors.white,
              textColor: Color(0xFF1E3A8A),
              collapsedTextColor: Color(0xFF1E3A8A),
              iconColor: Colors.cyan,
              collapsedIconColor: Colors.cyan,
              children: [
                ListTile(
                  title: Text(
                    "Blood Urea Nitrogen (BUN)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.filter_alt,
                    color: Color(0xFF0EA5E9),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Creatinine",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.filter_alt,
                    color: Color(0xFF0EA5E9),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text(
                "Liver Function",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              leading: Icon(
                Icons.monitor_heart,
                color: Colors.greenAccent,
                size: 30,
              ),
              backgroundColor: const Color.fromARGB(255, 212, 242, 255),
              collapsedBackgroundColor: Colors.white,
              textColor: Color(0xFF1E3A8A),
              collapsedTextColor: Color(0xFF1E3A8A),
              iconColor: Colors.cyan,
              collapsedIconColor: Colors.cyan,
              children: [
                ListTile(
                  title: Text(
                    "Alanine Transaminase (ALT)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.monitor_heart,
                    color: Color(0xFF10B981),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Aspartate Aminotransferase (AST)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.monitor_heart,
                    color: Color(0xFF10B981),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Alkaline Phosphatase (ALP)",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.monitor_heart,
                    color: Color(0xFF10B981),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Bilirubin",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.biotech,
                    color: Color(0xFF10B981),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Total Protein",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.biotech,
                    color: Color(0xFF10B981),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text(
                "Lipid Panel",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              leading: Icon(Icons.favorite, color: Colors.amber, size: 30),
              backgroundColor: const Color.fromARGB(255, 212, 242, 255),
              collapsedBackgroundColor: Colors.white,
              textColor: Color(0xFF1E3A8A),
              collapsedTextColor: Color(0xFF1E3A8A),
              iconColor: Colors.cyan,
              collapsedIconColor: Colors.cyan,
              children: [
                ListTile(
                  title: Text(
                    "Total Cholestrol",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "HDL",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "LDL",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Triglycerides",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.cyan),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
