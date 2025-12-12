import 'package:flutter/material.dart';

class NotificationHistoryScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNewNotification;

  const NotificationHistoryScreen({
    super.key,
    this.onBack,
    this.onNewNotification,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 1100;
        final isVerySmall = constraints.maxWidth < 800;

        return Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notification History',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (!isVerySmall)
                      Text(
                        'View and manage all sent and scheduled Notifications',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: onNewNotification ?? () {},
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'New Notifications',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Summary Cards
                if (isSmallScreen)
                  Column(
                    children: [
                      _buildSummaryCard(
                        label: 'Total Sent',
                        value: '248',
                        icon: Icons.check_circle,
                        iconColor: Colors.green,
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryCard(
                        label: 'Scheduled',
                        value: '12',
                        icon: Icons.calendar_today,
                        iconColor: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryCard(
                        label: 'This Month',
                        value: '89',
                        icon: Icons.trending_up,
                        iconColor: Colors.purple,
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          label: 'Total Sent',
                          value: '248',
                          icon: Icons.check_circle,
                          iconColor: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSummaryCard(
                          label: 'Scheduled',
                          value: '12',
                          icon: Icons.calendar_today,
                          iconColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSummaryCard(
                          label: 'This Month',
                          value: '89',
                          icon: Icons.trending_up,
                          iconColor: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),
                // Send Message Section Header
                Row(
                  children: [
                    Icon(Icons.send, color: Colors.blue, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Send Message',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Notification Table or List
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Table Header (Hidden on small screens if reusing row style, or simplified)
                      if (!isSmallScreen)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'TITLE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'SENT TIME',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'STATUS',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'ACTIONS',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Table Rows
                      _buildNotificationRow(
                        title: 'New Salsa Class Today',
                        description: 'Join us for an exciting salsa session...',
                        sentTime: 'July 5, 2025 - 5:00 PM',
                        status: 'Sent',
                        isSent: true,
                        isSmallScreen: isSmallScreen,
                      ),
                      _buildNotificationRow(
                        title: 'New Salsa Class Today',
                        description: 'Join us for an exciting salsa session...',
                        sentTime: 'July 5, 2025 - 5:00 PM',
                        status: 'Sent',
                        isSent: true,
                        isSmallScreen: isSmallScreen,
                      ),
                      _buildNotificationRow(
                        title: 'New Salsa Class Today',
                        description: 'Join us for an exciting salsa session...',
                        sentTime: 'July 5, 2025 - 5:00 PM',
                        status: 'Scheduled',
                        isSent: false,
                        isSmallScreen: isSmallScreen,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Pagination
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 16,
                  children: [
                    Text(
                      'Showing 1 to 3 of 3 results',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {},
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationRow({
    required String title,
    required String description,
    required String sentTime,
    required String status,
    required bool isSent,
    required bool isSmallScreen,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    _buildStatusBadge(status, isSent),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sentTime,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    sentTime,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IntrinsicWidth(
                      child: _buildStatusBadge(status, isSent),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatusBadge(String status, bool isSent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isSent
            ? Colors.green.withOpacity(0.1)
            : Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isSent ? Colors.green[700] : Colors.blue[700],
        ),
      ),
    );
  }
}
