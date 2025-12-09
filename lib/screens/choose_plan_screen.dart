import 'package:adicto_school/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({super.key});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  String selectedPlan = 'Free Tier';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      // AppBar removed
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // Title in body
              'Choose a Plan',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 20),
            _buildPlanCard(
              title: 'Free Tier',
              attendees: 'Upto 50 Attendees',
              price: '0\$/month',
              color: const Color(0xFF4ADE80), // Green
              isCurrent: true,
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              title: 'Basic Tier',
              attendees: '51-100 Attendees',
              price: '200\$/month',
              color: const Color(0xFF0085FF), // Blue
              description: 'Perfect for growing school',
              buttonText: 'Select Plan',
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              title: 'Pro Tier',
              attendees: '100+ Attendees',
              price: '300\$/month',
              color: const Color(0xFFD9A000), // Gold
              description: 'Unlimited attendees, premium insights',
              buttonText: 'Select Plan',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String attendees,
    required String price,
    required Color color,
    String? description,
    String? buttonText,
    bool isCurrent = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isCurrent
            ? Border.all(color: const Color(0xFFC6F6D5), width: 2)
            : null,
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
              Row(
                children: [
                  Icon(Icons.circle, color: color, size: 12),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ],
              ),
              if (isCurrent)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC6F6D5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Current',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF22543D),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF2ECC71),
                      size: 20,
                    ),
                  ],
                )
              else
                Radio<String>(
                  value: title,
                  groupValue: selectedPlan,
                  activeColor: color,
                  onChanged: (value) {
                    setState(() {
                      selectedPlan = value!;
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.groups, size: 20, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Text(
                attendees,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            price,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
          if (buttonText != null) ...[
            const SizedBox(height: 20),
            PrimaryButton(
              text: buttonText,
              onPressed: () {},
              color: color,
              height: 48,
            ),
          ],
        ],
      ),
    );
  }
}
