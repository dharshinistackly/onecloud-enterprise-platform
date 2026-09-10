import 'package:flutter/material.dart';

class ResourceBookingPage extends StatelessWidget {
  const ResourceBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = [
      ['Conference Room A', 'Sales Team', '11 Sep 2026, 10:00 AM', '1 hr', 'Booked'],
      ['Conference Room B', 'Engineering Team', '12 Sep 2026, 9:30 AM', '1.5 hrs', 'Booked'],
      ['Projector Unit 2', 'Marketing Team', '13 Sep 2026, 2:00 PM', '2 hrs', 'Booked'],
      ['Meeting Pod 3', 'Rahul Menon', '11 Sep 2026, 4:00 PM', '30 min', 'Available'],
      ['Video Conf Studio', 'Leadership', '14 Sep 2026, 11:00 AM', '1 hr', 'Booked'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      appBar: AppBar(title: const Text('Resource Booking'), backgroundColor: const Color(0xFF0F3D66), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Resource Booking', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Book rooms, equipment, and shared resources for events.'),
          const SizedBox(height: 20),
          Row(children: [
            _stat('Total Resources', '18', Icons.meeting_room_outlined, const Color(0xFF0F3D66)),
            const SizedBox(width: 14),
            _stat('Currently Booked', '11', Icons.event_busy_outlined, Colors.orange),
            const SizedBox(width: 14),
            _stat('Available Now', '7', Icons.event_available_outlined, Colors.green),
            const SizedBox(width: 14),
            _stat('Avg Utilization', '68%', Icons.pie_chart_outline, Colors.indigo),
          ]),
          const SizedBox(height: 20),
          Expanded(child: Card(elevation: 0, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
            columns: const [
              DataColumn(label: Text('Resource')),
              DataColumn(label: Text('Booked By')),
              DataColumn(label: Text('Date & Time')),
              DataColumn(label: Text('Duration')),
              DataColumn(label: Text('Status')),
            ],
            rows: bookings.map((a) => DataRow(cells: [for (final item in a) DataCell(Text(item))])).toList(),
          )))),
        ]),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Icon(icon, color: color, size: 29), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))])]))));
  }
}
