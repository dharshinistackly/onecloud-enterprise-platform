import 'package:flutter/material.dart';

class SmsNotificationsPage extends StatelessWidget {
  const SmsNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = [
      ['OTP Verification', '+91 98XXX XX210', 'Delivered', '2 min ago', 'Delivered'],
      ['Payment Confirmation', '+91 87XXX XX432', 'Delivered', '1 hr ago', 'Delivered'],
      ['Appointment Reminder', '+91 90XXX XX876', 'Delivered', '3 hrs ago', 'Delivered'],
      ['Delivery Update', '+91 99XXX XX154', 'Failed', '5 hrs ago', 'Failed'],
      ['Account Alert', '+91 96XXX XX098', 'Delivered', '1 day ago', 'Delivered'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('SMS Notifications'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('SMS Notifications', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Track SMS delivery for OTPs, alerts, and reminders.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('SMS Sent', '5,620', Icons.sms_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Delivery Rate', '97.2%', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 14),
            _stat('Failed', '28', Icons.error_outline, Colors.red),
            const SizedBox(width: 14),
            _stat('Avg Delivery Time', '3.4s', Icons.speed_outlined, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Message')),
              DataColumn(label: Text('Recipient')),
              DataColumn(label: Text('Delivery')),
              DataColumn(label: Text('Time')),
              DataColumn(label: Text('Status')),
            ],
            rows: messages.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
