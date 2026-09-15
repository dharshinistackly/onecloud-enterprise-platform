import 'package:flutter/material.dart';

class DocumentAiOcrPage extends StatelessWidget {
  const DocumentAiOcrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final documents = [
      ['Vendor_Invoice_2201.pdf', 'Invoice', '99.2%', '2 hrs ago', 'Processed'],
      ['Employee_ID_Proof.jpg', 'ID Document', '97.8%', '5 hrs ago', 'Processed'],
      ['Purchase_Order_1187.pdf', 'Purchase Order', '98.6%', '1 day ago', 'Processed'],
      ['Contract_Scan_045.pdf', 'Contract', '95.4%', '3 hrs ago', 'Review Needed'],
      ['Receipt_Batch_009.jpg', 'Receipt', '96.9%', '4 hrs ago', 'Processed'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Document AI / OCR'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Document AI / OCR', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Extract structured data from scanned documents and images.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Documents Processed', '4,820', Icons.document_scanner_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Avg Accuracy', '97.6%', Icons.verified_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Review Needed', '12', Icons.flag_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Avg Processing Time', '2.1s', Icons.speed_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Document')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Confidence')),
              DataColumn(label: Text('Processed On')),
              DataColumn(label: Text('Status')),
            ],
            rows: documents.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
