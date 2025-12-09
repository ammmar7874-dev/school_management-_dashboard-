import 'package:adicto_school/widgets/common_widgets.dart';
import 'package:adicto_school/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationHistoryScreen extends StatelessWidget {
  const NotificationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: const CustomAppBar(title: 'Notification History'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationItem(
            title: 'Class Rescheduled',
            date: 'June 14, 2025 - 4:30 PM',
            status: 'Sent',
            statusColor: const Color(0xFF4ADE80), // Green
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            title: 'Assignment Due Tomorrow',
            date: 'June 14, 2025 - 4:30 PM',
            status: 'Sent',
            statusColor: const Color(0xFF4ADE80),
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            title: 'Weekly Report Available',
            date: 'June 14, 2025 - 4:30 PM',
            status: 'Scheduled',
            statusColor: const Color(0xFF60A5FA), // Blue
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            title: 'Exam Scheduled Updated',
            date: 'June 14, 2025 - 4:30 PM',
            status: 'Sent',
            statusColor: const Color(0xFF4ADE80),
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            title: 'Library Hours Extended',
            date: 'June 14, 2025 - 4:30 PM',
            status: 'Scheduled',
            statusColor: const Color(0xFFFFCC00), // Orange/Yellow
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            title: 'Holiday Announcement',
            date: 'June 14, 2025 - 4:30 PM',
            status: 'Sent',
            statusColor: const Color(0xFF4ADE80),
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            title: 'Class Rescheduled',
            date: 'June 14, 2025 - 4:30 PM',
            status: 'Sent',
            statusColor: const Color(0xFF4ADE80),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String date,
    required String status,
    required Color statusColor,
  }) {
    return CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          StatusBadge(text: status, color: statusColor),
        ],
      ),
    );
  }
}
