import 'package:flutter/material.dart';

class SuggestionEnginePage extends StatelessWidget {
  const SuggestionEnginePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suggestion Engine',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F3D66),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Manage intelligent suggestions and recommendation rules.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _infoCard(
                  'Active Rules',
                  '12',
                  Icons.rule_folder_outlined,
                ),
                _infoCard(
                  'Suggestions Generated',
                  '1,248',
                  Icons.auto_awesome_outlined,
                ),
                _infoCard(
                  'Pending Reviews',
                  '18',
                  Icons.pending_actions_outlined,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Suggestion Rules',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F3D66),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _ruleTile(
                      'User Activity Suggestions',
                      'Suggest actions based on recent user activity.',
                      true,
                    ),
                    _ruleTile(
                      'Service Recommendations',
                      'Recommend services based on usage patterns.',
                      true,
                    ),
                    _ruleTile(
                      'Notification Suggestions',
                      'Suggest relevant notifications to users.',
                      false,
                    ),
                    _ruleTile(
                      'Search Suggestions',
                      'Generate suggestions from recent searches.',
                      true,
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

  static Widget _infoCard(
    String title,
    String value,
    IconData icon,
  ) {
    return SizedBox(
      width: 220,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF1677C8),
                size: 30,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F3D66),
                      ),
                    ),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _ruleTile(
    String title,
    String description,
    bool enabled,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E7EF),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Color(0xFF1677C8),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            enabled
                ? Icons.check_circle
                : Icons.cancel_outlined,
            color: enabled
                ? Colors.green
                : Colors.grey,
          ),
        ],
      ),
    );
  }
}