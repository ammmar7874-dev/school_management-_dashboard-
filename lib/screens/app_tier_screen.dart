import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTierScreen extends StatelessWidget {
  const AppTierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      // No AppBar
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Tier & Billing',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 10,
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
                        'Current Tier',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0085FF),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6E4FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Pro',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF0055CC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.people, color: Colors.grey[700], size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '42 Active Attendees',
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pro Tier allows unlimited attendees',
                    style: GoogleFonts.outfit(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF913BDB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Change Plan',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Billing History',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            _buildBillingCard(
              'Pro Plan - January 2025',
              'January 1, 2025',
              '500\$',
              'Paid',
              const Color(0xFF4ADE80),
            ),
            const SizedBox(height: 12),
            _buildBillingCard(
              'Pro Plan - January 2025',
              'December 1, 2025',
              '500\$',
              'Paid',
              const Color(0xFF4ADE80),
            ),
            const SizedBox(height: 12),
            _buildBillingCard(
              'Pro Plan - January 2025',
              'March 1, 2025',
              '500\$',
              'Pending',
              const Color(0xFFFFCC00),
            ),
            const SizedBox(height: 12),
            _buildBillingCard(
              'Pro Plan - January 2025',
              'January 1, 2025',
              '500\$',
              'Free',
              const Color(0xFFFFBBAA),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingCard(
    String title,
    String date,
    String amount,
    String status,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
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
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.outfit(
                    color: status == 'Pending'
                        ? Colors.orange
                        : (status == 'Free' ? Colors.deepOrange : Colors.green),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.blue[400]),
              const SizedBox(width: 8),
              Text(
                date,
                style: GoogleFonts.outfit(
                  color: Colors.blue[400],
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.monetization_on, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                amount,
                style: GoogleFonts.outfit(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
