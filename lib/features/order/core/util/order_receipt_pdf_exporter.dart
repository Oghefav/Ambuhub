import 'dart:io';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/order/core/util/order_line_format.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/domain/entities/order_line_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// Builds a black-and-white receipt PDF (no nav/actions) and opens the system share sheet.
class OrderReceiptPdfExporter {
  static const PdfColor _black = PdfColors.black;
  static const PdfColor _grey = PdfColors.grey700;

  /// PDF-safe currency (Helvetica lacks the naira glyph).
  static String _pdfCurrency(num amount) => formatCurrency(amount, symbol: 'NGN ');

  static Future<void> share(OrderEntity order) async {
    final bytes = await buildPdfBytes(order);
    final filename = _safeFilename(order.receiptNumber);

    try {
      await Printing.sharePdf(bytes: bytes, filename: filename);
      return;
    } catch (e, st) {
      debugPrint('Printing.sharePdf failed: $e\n$st');
    }

    await _shareViaSharePlus(bytes, filename, order.receiptNumber);
  }

  static Future<void> _shareViaSharePlus(
    Uint8List bytes,
    String filename,
    String receiptNumber,
  ) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);

    final result = await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/pdf', name: filename)],
        subject: 'Ambuhub receipt $receiptNumber',
        text: 'Ambuhub receipt $receiptNumber',
      ),
    );

    if (result.status == ShareResultStatus.unavailable) {
      throw Exception('No app available to share the PDF');
    }
  }

  static String _safeFilename(String receiptNumber) {
    final sanitized = receiptNumber.replaceAll(RegExp(r'[^\w\-]+'), '_');
    return sanitized.isEmpty ? 'ambuhub_receipt.pdf' : '$sanitized.pdf';
  }

  static Future<Uint8List> buildPdfBytes(OrderEntity order) async {
    final theme = pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
    );
    final issuedAt = formatDateTimeShort(order.createdAt ?? order.paidAt);

    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: theme,
          margin: const pw.EdgeInsets.all(32),
        ),
        build: (context) => [
          _header(order, issuedAt),
          pw.SizedBox(height: 12),
          pw.Divider(color: _grey, thickness: 0.5),
          pw.SizedBox(height: 16),
          _sectionTitle('ITEMS'),
          pw.SizedBox(height: 8),
          ...order.lines.map(_lineBlock),
          pw.SizedBox(height: 16),
          _subtotalBlock(order.subtotalNgn),
          pw.SizedBox(height: 16),
          _paymentReferenceBlock(order),
          pw.SizedBox(height: 20),
          pw.Divider(color: _black, thickness: 1),
          pw.SizedBox(height: 16),
          pw.Center(
            child: pw.Text(
              'Thank you for using Ambuhub',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: _black,
              ),
            ),
          ),
        ],
      ),
    );

    return doc.save();
  }

  static pw.Widget _header(OrderEntity order, String issuedAt) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: _grey),
            borderRadius: pw.BorderRadius.circular(6),
          ),
          child: pw.Text(
            'AMBUHUB RECEIPT',
            style: pw.TextStyle(fontSize: 9, color: _black),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          order.receiptNumber,
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: _black,
          ),
        ),
        pw.SizedBox(height: 6),
        pw.RichText(
          text: pw.TextSpan(
            children: [
              pw.TextSpan(
                text: 'Issued ',
                style: const pw.TextStyle(fontSize: 10, color: _grey),
              ),
              pw.TextSpan(
                text: issuedAt.isEmpty ? '—' : issuedAt,
                style: const pw.TextStyle(fontSize: 10, color: _black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _sectionTitle(String label) {
    return pw.Text(
      label,
      style: pw.TextStyle(
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
        color: _black,
      ),
    );
  }

  static pw.Widget _lineBlock(OrderLineEntity item) {
    final children = <pw.Widget>[
      pw.Text(
        item.title.toTitleCase(),
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: _black,
        ),
      ),
      pw.SizedBox(height: 4),
      pw.Text(
        '${item.categoryName} · ${item.departmentName}',
        style: const pw.TextStyle(fontSize: 10, color: _grey),
      ),
      pw.SizedBox(height: 4),
      pw.Text(
        formatOrderLineQuantityDetail(item).replaceAll('₦', 'NGN '),
        style: const pw.TextStyle(fontSize: 10, color: _black),
      ),
    ];

    if (item.hireStart != null) {
      children.addAll([
        pw.SizedBox(height: 4),
        pw.Text(
          '${formatDateTimeShort(item.hireStart)} -> ${formatDateTimeShort(item.hireEnd)}',
          style: const pw.TextStyle(fontSize: 10, color: _black),
        ),
      ]);
    }

    children.addAll([
      pw.SizedBox(height: 6),
      pw.Text(
        _pdfCurrency(item.lineTotalNgn),
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: _black,
        ),
      ),
      pw.SizedBox(height: 14),
      pw.Divider(color: PdfColors.grey300, thickness: 0.25),
      pw.SizedBox(height: 14),
    ]);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: children,
    );
  }

  static pw.Widget _subtotalBlock(int subtotalNgn) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: _black, width: 1),
        borderRadius: pw.BorderRadius.circular(8),
        color: PdfColors.grey100,
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Subtotal (NGN)',
            style: pw.TextStyle(fontSize: 12, color: _grey),
          ),
          pw.Text(
            _pdfCurrency(subtotalNgn),
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: _black,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _paymentReferenceBlock(OrderEntity order) {
    final providerLabel = order.paystackSimulated
        ? '${order.paymentProvider} (simulated)'
        : order.paymentProvider;

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: _grey, width: 0.5),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Payment reference:',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: _black,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            order.paystackReference.toUpperCase(),
            style: pw.TextStyle(
              fontSize: 12,
              letterSpacing: 0.5,
              color: _black,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(
                  text: 'Provider: ',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: _black,
                  ),
                ),
                pw.TextSpan(
                  text: providerLabel,
                  style: const pw.TextStyle(fontSize: 10, color: _black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
