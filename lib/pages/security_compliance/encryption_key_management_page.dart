import 'package:flutter/material.dart';

class EncryptionKeyManagementPage extends StatelessWidget {
  const EncryptionKeyManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = [
      ['db-master-key', 'AES-256', 'Database Encryption', '12 days ago', 'Active'],
      ['payments-signing-key', 'RSA-4096', 'Payment Signing', '30 days ago', 'Active'],
      ['file-storage-key', 'AES-256', 'S3 Object Encryption', '5 days ago', 'Active'],
      ['legacy-api-key', 'AES-128', 'Legacy API Auth', '210 days ago', 'Expiring Soon'],
      ['backup-archive-key', 'AES-256', 'Backup Encryption', '45 days ago', 'Active'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),title: const Text('Encryption Key Management'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Encryption Key Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Manage cryptographic keys, rotation, and usage across services.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Keys', '52', Icons.vpn_key_outlined, Colors.blue),
            const SizedBox(width: 14),
            _stat('Active Keys', '47', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Expiring Soon', '3', Icons.warning_amber_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Rotations This Month', '9', Icons.autorenew, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Key Name')),
              DataColumn(label: Text('Algorithm')),
              DataColumn(label: Text('Usage')),
              DataColumn(label: Text('Last Rotated')),
              DataColumn(label: Text('Status')),
            ],
            rows: keys.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
