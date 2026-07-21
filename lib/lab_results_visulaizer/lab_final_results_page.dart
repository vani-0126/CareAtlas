import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lab_results_data.dart';

class LabResultDetailsPage extends StatefulWidget {
  final LabResult term;
  final double value;

  const LabResultDetailsPage({
    super.key,
    required this.term,
    required this.value,
  });

  @override
  State<LabResultDetailsPage> createState() => _LabResultDetailsPageState();
}

class _LabResultDetailsPageState extends State<LabResultDetailsPage> {
  String getStatus() {
    if (widget.value < widget.term.minValue) {
      return "Low";
    } else if (widget.value > widget.term.maxValue) {
      return "High";
    } else {
      return "Normal";
    }
  }

  String getExplanation() {
    if (widget.value < widget.term.minValue) {
      return widget.term.lowExplanation;
    } else if (widget.value > widget.term.maxValue) {
      return widget.term.highExplanation;
    } else {
      return widget.term.normalExplanation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
            Text(
              widget.term.testName,
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Range:",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${widget.term.minValue} - ${widget.term.maxValue} ${widget.term.unit}",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Description:",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.term.description,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Result:",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${widget.value}",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status:",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                SizedBox(width: 10),

                Text(
                  getStatus(),
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Text(
              "Explanation:",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(height: 10),
            Text(
              getExplanation(),
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Notes:",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.term.notes.map((note) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "• $note",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Image.asset(widget.term.image, height: 180, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
