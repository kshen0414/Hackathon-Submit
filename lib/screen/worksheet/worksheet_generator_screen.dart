import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../model/question.dart';
import '../../services/question_generator.dart';
import '../pdf/save_and_open_pdf.dart';

class WorksheetGeneratorScreen extends StatefulWidget {
  final String initialOperation;

  const WorksheetGeneratorScreen({
    Key? key,
    required this.initialOperation,
  }) : super(key: key);

  @override
  _WorksheetGeneratorScreenState createState() =>
      _WorksheetGeneratorScreenState();
}

class _WorksheetGeneratorScreenState extends State<WorksheetGeneratorScreen> {
  String _subject = 'Math';
  late String _topic;
  int _questionCount = 10;
  String _difficultyLevel = 'Medium';

  @override
  void initState() {
    super.initState();
    _topic = widget.initialOperation;
  }

  Future<File> generateWorksheetPdf() async {
    final pdf = pw.Document();
    final questions = List.generate(
        _questionCount,
        (index) =>
            QuestionGenerator.generateMathQuestion(_topic, _difficultyLevel));

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide.none,
              ),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '$_subject Worksheet: $_topic',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Name: _______________________',
                        style: pw.TextStyle(fontSize: 12)),
                    pw.Text('Date: ${DateTime.now().toString().split(' ')[0]}',
                        style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Text('Class: _______________________',
                    style: pw.TextStyle(fontSize: 12)),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Wrap(
            spacing: 43,
            runSpacing: 30,
            children: questions.asMap().entries.map((entry) {
              int idx = entry.key;
              Question question = entry.value;

              // Return different layouts based on operation type
              return _topic == 'Division'
                  ? pw.Container(
                      width: 130,
                      height: 130,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(),
                      ),
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('${idx + 1}',
                                style: pw.TextStyle(fontSize: 12)),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  '${question.number2}', // divisor
                                  style: pw.TextStyle(
                                      fontSize: 24,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                pw.SizedBox(width: 5),
                                pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                      left: pw.BorderSide(width: 2),
                                      top: pw.BorderSide(width: 2),
                                    ),
                                  ),
                                  padding: pw.EdgeInsets.only(left: 10, top: 5),
                                  child: pw.Text(
                                    '${question.number1}', // dividend
                                    style: pw.TextStyle(
                                        fontSize: 24,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : pw.Container(
                      width: 130,
                      height: 130,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(),
                      ),
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text('${idx + 1}',
                                  style: pw.TextStyle(fontSize: 12)),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              '${question.number1}',
                              style: pw.TextStyle(
                                  fontSize: 24, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  question.operation,
                                  style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                pw.Text(
                                  '${question.number2}',
                                  style: pw.TextStyle(
                                      fontSize: 24,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 5),
                            pw.Container(
                              width: 110,
                              height: 1,
                              color: PdfColors.black,
                            ),
                          ],
                        ),
                      ),
                    );
            }).toList(),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Answers',
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Wrap(
            spacing: 25,
            runSpacing: 10,
            children: questions.asMap().entries.map((entry) {
              int idx = entry.key;
              Question question = entry.value;
              return pw.Container(
                width: 100,
                height: 30,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Center(
                  child: pw.Text(
                    '${idx + 1}: ${question.answer}',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );

    return SaveAndOpenDocument.savePdf(
        name: 'worksheet_${DateTime.now().millisecondsSinceEpoch}.pdf',
        pdf: pdf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                height: 44,
                width: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white.withOpacity(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0,
                  ),
                  child: Icon(Icons.keyboard_backspace, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF487CFC),
              Color(0xFF487CFC).withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 120),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_topic Worksheet Generator',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Number of Questions: $_questionCount',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    Slider(
                      value: _questionCount.toDouble(),
                      min: 5,
                      max: 20,
                      divisions: 3,
                      label: _questionCount.toString(),
                      activeColor: Color(0xFF487CFC),
                      onChanged: (double value) {
                        setState(() {
                          _questionCount = value.round();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Difficulty Level',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: _difficultyLevel,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _difficultyLevel = newValue!;
                          });
                        },
                        items: <String>['Easy', 'Medium', 'Hard']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Color(0xFF487CFC),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            final pdfFile = await generateWorksheetPdf();
                            SaveAndOpenDocument.openPdf(pdfFile);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Error generating PDF: $e')),
                            );
                          }
                        },
                        child: Text(
                          'Generate Worksheet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getOperationSymbol(String operation) {
    switch (operation) {
      case 'Addition':
        return '+';
      case 'Subtraction':
        return '-';
      case 'Multiplication':
        return '×';
      case 'Division':
        return '÷';
      default:
        return '';
    }
  }
}
