import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class Pfdview extends StatefulWidget {
  Pfdview({super.key});

  @override
  State<Pfdview> createState() => _PfdviewState();
}

class _PfdviewState extends State<Pfdview> {
  late PdfController pdfController;
  @override
  void initState() {
    super.initState();
  try {
    pdfController = PdfController(
      document: PdfDocument.openAsset('assets/pdf/antinoProfilePratik.pdf'),
    );
  } catch (e) {
    log('Error loading PDF: $e');
  }
  }

  @override
  void dispose() {
    super.dispose();
    pdfController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PdfView(
  controller: pdfController,
  onDocumentError: (error) => log('Document error: $error'),
  scrollDirection: Axis.vertical,
  builders: PdfViewBuilders<DefaultBuilderOptions>(
    options: DefaultBuilderOptions(),
  ),
)
          
    );
  }
}
