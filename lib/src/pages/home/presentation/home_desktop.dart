import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback? onAddPlan;
  final VoidCallback? onAddClass;
  final VoidCallback? onViewRevenue;
  final VoidCallback? onSendNotification;

  const DashboardScreen({
    super.key,
    this.onAddPlan,
    this.onAddClass,
    this.onViewRevenue,
    this.onSendNotification,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth < 900;

        return Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row - Metric Cards
                if (isTablet) ...[
                  _buildMetricCard(
                    title: 'Active Users',
                    value: '128',
                    trend: '+8.2% from last month',
                    icon: Icons.person,
                    iconColor: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildClickableMetricCard(
                    title: 'Total Revenue',
                    value: '\$12,400',
                    trend: '+12.2% from last month',
                    icon: Icons.attach_money,
                    iconColor: Colors.green,
                    onTap: onViewRevenue,
                  ),
                  const SizedBox(height: 16),
                  _buildMetricCard(
                    title: 'New Subscription This Month',
                    value: '27',
                    trend: '+15.2% from last month',
                    icon: Icons.person_add,
                    iconColor: Colors.purple,
                  ),
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          title: 'Active Users',
                          value: '128',
                          trend: '+8.2% from last month',
                          icon: Icons.person,
                          iconColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildClickableMetricCard(
                          title: 'Total Revenue',
                          value: '\$12,400',
                          trend: '+12.2% from last month',
                          icon: Icons.attach_money,
                          iconColor: Colors.green,
                          onTap: onViewRevenue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(
                          title: 'New Subscription This Month',
                          value: '27',
                          trend: '+15.2% from last month',
                          icon: Icons.person_add,
                          iconColor: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                // Middle Row - Charts
                if (isTablet) ...[
                  _buildChartCard(
                    title: 'Monthly Earnings',
                    timeframe: '2025',
                    timeframeIcon: Icons.calendar_today,
                    child: _buildLineChart(),
                  ),
                  const SizedBox(height: 16),
                  _buildChartCard(
                    title: 'Attendance Trends',
                    timeframe: 'Last 7 days',
                    timeframeIcon: Icons.bar_chart,
                    child: _buildBarChart(),
                  ),
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: _buildChartCard(
                          title: 'Monthly Earnings',
                          timeframe: '2025',
                          timeframeIcon: Icons.calendar_today,
                          child: _buildLineChart(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildChartCard(
                          title: 'Attendance Trends',
                          timeframe: 'Last 7 days',
                          timeframeIcon: Icons.bar_chart,
                          child: _buildBarChart(),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                // Bottom Row - Action Cards
                if (isTablet) ...[
                  _buildActionCard(
                    title: 'Create new Class',
                    icon: Icons.group,
                    iconColor: Colors.blue,
                    buttonColor: Colors.blue,
                    buttonText: 'Add',
                    onTap: onAddClass,
                  ),
                  const SizedBox(height: 16),
                  _buildActionCard(
                    title: 'Add new Plan',
                    icon: Icons.calendar_today,
                    iconColor: Colors.green,
                    buttonColor: Colors.green,
                    buttonText: 'Add',
                    onTap: onAddPlan,
                  ),
                  const SizedBox(height: 16),
                  _buildActionCard(
                    title: 'Send Notification',
                    icon: Icons.notifications,
                    iconColor: Colors.orange,
                    buttonColor: Colors.orange,
                    buttonText: 'Send',
                    onTap: onSendNotification,
                  ),
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          title: 'Create new Class',
                          icon: Icons.group,
                          iconColor: Colors.blue,
                          buttonColor: Colors.blue,
                          buttonText: 'Add',
                          onTap: onAddClass,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionCard(
                          title: 'Add new Plan',
                          icon: Icons.calendar_today,
                          iconColor: Colors.green,
                          buttonColor: Colors.green,
                          buttonText: 'Add',
                          onTap: onAddPlan,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionCard(
                          title: 'Send Notification',
                          icon: Icons.notifications,
                          iconColor: Colors.orange,
                          buttonColor: Colors.orange,
                          buttonText: 'Send',
                          onTap: onSendNotification,
                        ),
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String trend,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
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
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.arrow_upward, size: 16, color: Colors.green),
                  Text(
                    trend,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClickableMetricCard({
    required String title,
    required String value,
    required String trend,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        print('Total Revenue card clicked'); // Console log
        if (onTap != null) {
          print('Calling callback...'); // Debug
          onTap();
        } else {
          print('ERROR: onTap callback is null!'); // Debug
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
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
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.arrow_upward,
                      size: 16,
                      color: Colors.green,
                    ),
                    Text(
                      trend,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required String timeframe,
    required IconData timeframeIcon,
    required Widget child,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Icon(timeframeIcon, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    timeframe,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(height: 200, child: child),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    // Simple line chart representation
    return CustomPaint(painter: LineChartPainter(), child: Container());
  }

  Widget _buildBarChart() {
    // Simple bar chart representation
    return CustomPaint(painter: BarChartPainter(), child: Container());
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color buttonColor,
    required String buttonText,
    VoidCallback? onTap,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: title == 'Add new Plan' && onAddPlan != null
                  ? onAddPlan
                  : title == 'Create new Class' && onAddClass != null
                  ? onAddClass
                  : title == 'Send Notification' && onTap != null
                  ? onTap
                  : () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

// Simple Line Chart Painter
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Calculate Y-axis title dimensions first
    final yAxisTitleStyle = TextStyle(
      fontSize: 10,
      color: Colors.grey[700],
      fontWeight: FontWeight.w500,
    );
    final yAxisTitleSpan = TextSpan(
      text: 'Revenue (R)',
      style: yAxisTitleStyle,
    );
    final yAxisTitlePainter = TextPainter(
      text: yAxisTitleSpan,
      textDirection: TextDirection.ltr,
    );
    yAxisTitlePainter.layout();

    // Y-axis labels
    final yAxisLabels = ['8k', '10k', '12k', '14k', '16k'];
    final yAxisValues = [0.8, 0.65, 0.5, 0.35, 0.2];
    final yAxisLabelStyle = TextStyle(fontSize: 9, color: Colors.grey[600]);

    // Draw Y-axis label on the left (vertical/rotated)
    final middleY = size.height * 0.5;
    canvas.save();
    canvas.translate(5 + yAxisTitlePainter.height / 2, middleY);
    canvas.rotate(-1.5708); // -90 degrees in radians
    yAxisTitlePainter.paint(
      canvas,
      Offset(-yAxisTitlePainter.width / 2, -yAxisTitlePainter.height / 2),
    );
    canvas.restore();

    // Draw Y-axis value labels to the right of the title
    final valueOffset = 5 + yAxisTitlePainter.height + 8;
    for (var i = 0; i < yAxisLabels.length; i++) {
      final textSpan = TextSpan(text: yAxisLabels[i], style: yAxisLabelStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final yPos = size.height * yAxisValues[i];
      // Position to the right of the title with some spacing
      textPainter.paint(
        canvas,
        Offset(valueOffset, yPos - textPainter.height / 2),
      );
    }

    final path = Path();
    final points = [
      Offset(size.width * 0.15, size.height * 0.7),
      Offset(size.width * 0.25, size.height * 0.6),
      Offset(size.width * 0.35, size.height * 0.5),
      Offset(size.width * 0.45, size.height * 0.55),
      Offset(size.width * 0.55, size.height * 0.45),
      Offset(size.width * 0.65, size.height * 0.4),
      Offset(size.width * 0.75, size.height * 0.35),
      Offset(size.width * 0.85, size.height * 0.3),
      Offset(size.width * 0.95, size.height * 0.25),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw points
    final pointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    for (var point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }

    // Draw X-axis labels
    final textStyle = TextStyle(fontSize: 10, color: Colors.grey[600]);
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
    ];
    for (var i = 0; i < months.length && i < points.length; i++) {
      final textSpan = TextSpan(text: months[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(points[i].dx - textPainter.width / 2, size.height - 20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple Bar Chart Painter
class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Calculate Y-axis title dimensions first
    final yAxisTitleStyle = TextStyle(
      fontSize: 10,
      color: Colors.grey[700],
      fontWeight: FontWeight.w500,
    );
    final yAxisTitleSpan = TextSpan(
      text: 'Attendance Count',
      style: yAxisTitleStyle,
    );
    final yAxisTitlePainter = TextPainter(
      text: yAxisTitleSpan,
      textDirection: TextDirection.ltr,
    );
    yAxisTitlePainter.layout();

    // Y-axis labels
    final yAxisLabels = ['0', '20', '40', '60'];
    final yAxisValues = [0.95, 0.7, 0.45, 0.2];
    final yAxisLabelStyle = TextStyle(fontSize: 9, color: Colors.grey[600]);

    // Draw Y-axis label on the left (vertical/rotated)
    final middleY = size.height * 0.5;
    canvas.save();
    canvas.translate(5 + yAxisTitlePainter.height / 2, middleY);
    canvas.rotate(-1.5708); // -90 degrees in radians
    yAxisTitlePainter.paint(
      canvas,
      Offset(-yAxisTitlePainter.width / 2, -yAxisTitlePainter.height / 2),
    );
    canvas.restore();

    // Draw Y-axis value labels to the right of the title
    final valueOffset = 5 + yAxisTitlePainter.height + 8;
    for (var i = 0; i < yAxisLabels.length; i++) {
      final textSpan = TextSpan(text: yAxisLabels[i], style: yAxisLabelStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final yPos = size.height * yAxisValues[i];
      // Position to the right of the title with some spacing
      textPainter.paint(
        canvas,
        Offset(valueOffset, yPos - textPainter.height / 2),
      );
    }

    final barWidth = ((size.width - 40) / 7 - 8) * 0.6; // Reduced bar width
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [45, 52, 38, 48, 55, 42, 35];

    for (var i = 0; i < days.length; i++) {
      final barHeight = (values[i] / 60) * size.height * 0.75;
      final spacing =
          (size.width - 40 - (barWidth * 7)) /
          6; // Calculate spacing between bars
      final x = 40 + i * (barWidth + spacing) + spacing / 2;
      final y = size.height - barHeight - 20;

      final paint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(4),
        ),
        paint,
      );

      // Draw X-axis labels
      final textStyle = TextStyle(fontSize: 9, color: Colors.grey[600]);
      final textSpan = TextSpan(text: days[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + barWidth / 2 - textPainter.width / 2, size.height - 15),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
