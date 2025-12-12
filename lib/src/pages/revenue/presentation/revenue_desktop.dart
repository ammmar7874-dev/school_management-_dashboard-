import 'package:flutter/material.dart';

class RevenueOverviewScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const RevenueOverviewScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 1100;

        return Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total Revenue Card
                _buildTotalRevenueCard(),
                const SizedBox(height: 24),

                // Charts Section
                if (isSmallScreen)
                  Column(
                    children: [
                      _buildMonthlyEarningsChart(),
                      const SizedBox(height: 24),
                      _buildTopPlansCard(),
                    ],
                  )
                else
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 2, child: _buildMonthlyEarningsChart()),
                        const SizedBox(width: 16),
                        Expanded(flex: 1, child: _buildTopPlansCard()),
                      ],
                    ),
                  ),

                const SizedBox(height: 24),

                // Bottom Metrics
                if (isSmallScreen)
                  Column(
                    children: [
                      _buildSmallMetricCard(
                        title: 'Avg Monthly Revenue',
                        value: '\$1,056',
                        icon: Icons.trending_up,
                        iconColor: Colors.green,
                        iconBgColor: const Color(0x3356E393),
                      ),
                      const SizedBox(height: 16),
                      _buildSmallMetricCard(
                        title: 'Growth Rate',
                        value: '+12.5%',
                        icon: Icons.info_outline,
                        iconColor: Colors.blue,
                        iconBgColor: const Color(0x332563EB),
                      ),
                      const SizedBox(height: 16),
                      _buildSmallMetricCard(
                        title: 'Total Plan Sold',
                        value: '1,324',
                        icon: Icons.credit_card,
                        iconColor: Colors.orange,
                        iconBgColor: const Color(0x33F59F0A),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: _buildSmallMetricCard(
                          title: 'Avg Monthly Revenue',
                          value: '\$1,056',
                          icon: Icons.trending_up,
                          iconColor: Colors.green,
                          iconBgColor: const Color(0x3356E393),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSmallMetricCard(
                          title: 'Growth Rate',
                          value: '+12.5%',
                          icon: Icons.info_outline,
                          iconColor: Colors.blue,
                          iconBgColor: const Color(0x332563EB),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSmallMetricCard(
                          title: 'Total Plan Sold',
                          value: '1,324',
                          icon: Icons.credit_card,
                          iconColor: Colors.orange,
                          iconBgColor: const Color(0x33F59F0A),
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

  Widget _buildTotalRevenueCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2B60EB), Color(0xFF9035EA)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
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
                'Total Revenue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '\$16900.89',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Since Jan, 2024',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.attach_money,
              size: 48,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMonthlyEarningsChart() {
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
            const Text(
              'Monthly Earnings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '2025',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: CustomPaint(
            painter: MonthlyEarningsBarChartPainter(),
            child: Container(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTopPlansCard() {
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
        const Text(
          'Top Plans Sold',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        _buildPlanItem(
          planName: '10-Class Pack',
          sold: '20 Sold',
          amount: '\$2,600.00',
          icon: Icons.layers,
          iconColor: Colors.blue,
          progress: 0.65,
        ),
        const SizedBox(height: 16),
        _buildPlanItem(
          planName: '5-Class Pack',
          sold: '32 Sold',
          amount: '\$2,100.00',
          icon: Icons.layers,
          iconColor: Colors.green,
          progress: 0.52,
        ),
        const SizedBox(height: 16),
        _buildPlanItem(
          planName: 'Monthly Unlimited',
          sold: '18 Sold',
          amount: '\$1,600.00',
          icon: Icons.layers,
          iconColor: Colors.purple,
          progress: 0.40,
        ),
        const SizedBox(height: 16),
        _buildPlanItem(
          planName: 'Single Class',
          sold: '44 Sold',
          amount: '\$1,040.00',
          icon: Icons.layers,
          iconColor: Colors.orange,
          progress: 0.25,
        ),
      ],
    ),
  );
}

Widget _buildPlanItem({
  required String planName,
  required String sold,
  required String amount,
  required IconData icon,
  required Color iconColor,
  required double progress,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sold,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                    minHeight: 4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _buildSmallMetricCard({
  required String title,
  required String value,
  required IconData icon,
  required Color iconColor,
  required Color iconBgColor,
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
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
      ],
    ),
  );
}

class MonthlyEarningsBarChartPainter extends CustomPainter {
  final List<double> monthlyData = [
    800,
    1200,
    1000,
    1800,
    1500,
    1400,
    900,
    1600,
    1700,
    1500,
    1300,
    1400,
  ];
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final double maxValue = 2000;

  @override
  void paint(Canvas canvas, Size size) {
    final double chartWidth = size.width - 80;
    final double chartHeight = size.height - 60;
    final double barWidth = chartWidth / monthlyData.length - 8;
    final double startX = 60;
    final double startY = 20;

    // Draw Y-axis title (vertical, on the far left)
    final yAxisTitle = TextSpan(
      text: 'Revenue (R)',
      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
    );
    final yAxisTitlePainter = TextPainter(
      text: yAxisTitle,
      textDirection: TextDirection.ltr,
    );
    yAxisTitlePainter.layout();
    canvas.save();
    canvas.translate(5, startY + chartHeight / 2);
    canvas.rotate(-1.5708); // -90 degrees in radians
    yAxisTitlePainter.paint(canvas, Offset(-yAxisTitlePainter.width / 2, 0));
    canvas.restore();

    // Draw Y-axis labels (to the right of the title, left of chart)
    final yAxisLabels = [0, 500, 1000, 1500, 2000];
    final textStyle = TextStyle(fontSize: 10, color: Colors.grey[600]);
    final double labelX = 20.0; // Position labels to the right of the title

    for (int i = 0; i < yAxisLabels.length; i++) {
      final y =
          startY +
          (chartHeight - (i * (chartHeight / (yAxisLabels.length - 1))));
      final yAxisTextSpan = TextSpan(
        text: yAxisLabels[i].toString(),
        style: textStyle,
      );
      final yAxisTextPainter = TextPainter(
        text: yAxisTextSpan,
        textDirection: TextDirection.ltr,
      );
      yAxisTextPainter.layout();
      yAxisTextPainter.paint(
        canvas,
        Offset(labelX, y - yAxisTextPainter.height / 2),
      );
    }

    // Draw bars
    final barPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (int i = 0; i < monthlyData.length; i++) {
      final barHeight = (monthlyData[i] / maxValue) * chartHeight;
      final x = startX + (i * (chartWidth / monthlyData.length)) + 4;
      final y = startY + chartHeight - barHeight;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(4),
        ),
        barPaint,
      );
    }

    // Draw X-axis labels
    for (int i = 0; i < months.length; i++) {
      final x = startX + (i * (chartWidth / months.length)) + barWidth / 2;
      final monthTextSpan = TextSpan(text: months[i], style: textStyle);
      final monthTextPainter = TextPainter(
        text: monthTextSpan,
        textDirection: TextDirection.ltr,
      );
      monthTextPainter.layout();
      monthTextPainter.paint(
        canvas,
        Offset(x - monthTextPainter.width / 2, startY + chartHeight + 8),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
