import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> exportChartCsv({
  required String fileName,
  required List<String> headers,
  required List<List<Object?>> rows,
}) async {
  String escapeCell(Object? value) {
    final text = (value ?? '').toString();
    final escaped = text.replaceAll('"', '""');

    if (text.contains(',') ||
        text.contains('"') ||
        text.contains('\n') ||
        text.contains('\r')) {
      return '"$escaped"';
    }

    return escaped;
  }

  final csv = [
    headers.map(escapeCell).join(','),
    ...rows.map((row) => row.map(escapeCell).join(',')),
  ].join('\r\n');

  await FileSaver.instance.saveFile(
    name: fileName,
    bytes: Uint8List.fromList(utf8.encode(csv)),
    ext: 'csv',
  );
}

Future<void> exportChartExcel({
  required String fileName,
  required List<String> headers,
  required List<List<Object?>> rows,
}) async {
  final excel = Excel.createExcel();
  final sheet = excel['Chart Data'];

  sheet.appendRow(
    headers.map((header) => TextCellValue(header)).toList(),
  );

  for (final row in rows) {
    sheet.appendRow(
      row.map((value) {
        if (value == null) {
          return TextCellValue('');
        }

        if (value is num) {
          return DoubleCellValue(value.toDouble());
        }

        return TextCellValue(value.toString());
      }).toList(),
    );
  }

  final bytes = excel.save();

  if (bytes == null) {
    throw Exception('Could not generate Excel file.');
  }

  await FileSaver.instance.saveFile(
    name: fileName,
    bytes: Uint8List.fromList(bytes),
    ext: 'xlsx',
  );
}

Future<void> exportChartPdf({
  required String fileName,
  required List<String> headers,
  required List<List<Object?>> rows,
}) async {
  final document = pw.Document();

  document.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Text(
          'OneCloud Global Dashboard',
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text('Chart Data Report'),
        pw.SizedBox(height: 20),
        pw.TableHelper.fromTextArray(
          headers: headers,
          data: rows
              .map(
                (row) => row
                    .map((value) => value?.toString() ?? '')
                    .toList(),
              )
              .toList(),
          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
          cellAlignment: pw.Alignment.centerLeft,
        ),
      ],
    ),
  );

  final bytes = await document.save();

  await FileSaver.instance.saveFile(
    name: fileName,
    bytes: Uint8List.fromList(bytes),
    ext: 'pdf',
  );
}