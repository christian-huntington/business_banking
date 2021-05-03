import 'package:clean_framework/clean_framework.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFHandler extends ExternalDependency {

  final pw.Document _pdf;

  PDFHandler(this._pdf);

  void share(String filename) async {
    Printing.sharePdf(bytes: await _pdf.save(), filename: filename);
  }

  static createFromPDFFactory(PDFFactory factory) {
    return PDFHandler(factory.getPDFDocument());
  }
  
}

abstract class PDFFactory {
  pw.Document getPDFDocument();
}

class PDFFactoryCreditCardPaymentConfirmation extends PDFFactory {

  final String creditCardName;
  final double paymentValue;

  PDFFactoryCreditCardPaymentConfirmation(this.creditCardName, this.paymentValue);

  pw.Document getPDFDocument() {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [

              /// title
              pw.Padding(
                  padding: pw.EdgeInsets.only(top: 40.0),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text("Payment Confirmation", style: pw.TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold)),
                      ]
                  )),

              /// Credit Card Name
              pw.Padding(
                  padding: pw.EdgeInsets.only(top: 40.0),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text("Credit Card: ", style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
                        pw.Text(creditCardName, style: pw.TextStyle(fontSize: 30)),
                      ]
                  )),

              /// Payment Value
              pw.Padding(
                  padding: pw.EdgeInsets.only(top: 40.0),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text("Payment Value: ", style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
                        pw.Text(NumberFormat.simpleCurrency().format(paymentValue), style: pw.TextStyle(fontSize: 30)),
                      ]
                  )),
            ],
          ); // Center
        })); // Page
    return pdf;
  }

}


