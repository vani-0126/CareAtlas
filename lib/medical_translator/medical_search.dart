import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'medical_terms.dart';
import 'medical_details.dart';
import 'package:flutter/cupertino.dart';

class MedicalSearch extends StatefulWidget {
  const MedicalSearch({super.key});
  @override
  State<MedicalSearch> createState() => _MedicalSearchState();
}

class _MedicalSearchState extends State<MedicalSearch> {
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
    MedicalTerm? result;
    try {
      result = medicalTerms.firstWhere(
        (term) => term.term.toLowerCase() == value.toLowerCase(),
      );
    } catch (_) {
      result = null;
    }

    if (result != null) {
      final term = result;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => TermDetailsPage(term: term)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = medicalTerms
        .where((term) => term.term.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1E3A8A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF1E3A8A), width: 1.4),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: CupertinoSearchTextField(
                  controller: controller,
                  placeholder: 'Search Medical Term',
                  onChanged: _onChanged,
                  onSubmitted: _onSubmitted,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(25),
              ),
              height: 35,
              width: 90,
              child: Center(
                child: Text(
                  "Translate",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: query.isEmpty
          ? Center(child: Text('Type to search'))
          : ListView(
              children: suggestions.map((term) {
                return ListTile(
                  title: Text(term.term),
                  subtitle: Text(term.definition),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TermDetailsPage(term: term),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
