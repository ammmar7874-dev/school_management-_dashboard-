import 'package:flutter/material.dart';

class ChoosePlanScreen extends StatelessWidget {
  final VoidCallback? onCancel;

  const ChoosePlanScreen({super.key, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Plan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            // Plan Cards
            // Plan Cards
            LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 1000;
                // On small screens, stack them.
                if (isSmallScreen) {
                  return Column(
                    children: [
                      _buildPlanCard(
                        icon: Icons.check_circle,
                        iconColor: Colors.green,
                        tierName: 'Free Tier',
                        label: 'Current',
                        labelColor: Colors.green,
                        labelIcon: Icons.check,
                        attendees: 'Upto 50 Attendees',
                        price: '0\$/month',
                        priceColor: Colors.green,
                        description:
                            'Ideal for small classes, individual tutors, or testing the platform.',
                        features: [
                          'Host up to 50 attendees per class',
                          'Access to basic class scheduling features',
                          'Limited email notifications for attendees',
                          'Access to 1 instructor profile',
                          'Basic attendance tracking and reporting',
                          'Community support only',
                          'Up to 5 class recordings per month',
                          'No integration with external tools (e.g., Zoom, Google Calendar)',
                        ],
                        buttonColor: Colors.green.withOpacity(0.2),
                        buttonTextColor: Colors.green[700]!,
                        isCurrent: true,
                      ),
                      const SizedBox(height: 16),
                      _buildPlanCard(
                        icon: Icons.star,
                        iconColor: Colors.blue,
                        tierName: 'Basic Tier',
                        label: 'Recommended',
                        labelColor: Colors.blue,
                        labelIcon: Icons.circle,
                        attendees: '51-100 Attendees',
                        price: '200\$/month',
                        priceColor: Colors.blue,
                        description:
                            'Perfect for growing schools or educational startups.',
                        features: [
                          'Host up to 100 attendees per class',
                          'Includes all Free Tier features, plus:',
                          'Custom branding (logos, colors)',
                          'Add up to 3 instructor profiles',
                          'Access to basic analytics dashboard',
                          '10 GB storage for class materials',
                          'Email & chat support',
                          'Integration with Zoom/Google Meet',
                          'Priority access to new features',
                        ],
                        buttonColor: Colors.blue,
                        buttonTextColor: Colors.white,
                        isRecommended: true,
                      ),
                      const SizedBox(height: 16),
                      _buildPlanCard(
                        icon: Icons.workspace_premium,
                        iconColor: Colors.orange,
                        tierName: 'Pro Tier',
                        label: '',
                        labelColor: Colors.grey,
                        labelIcon: Icons.circle,
                        attendees: '100+ Attendees',
                        price: '300\$/month',
                        priceColor: Colors.orange,
                        description:
                            'Best for established schools or large institutions.',
                        features: [
                          'Host unlimited attendees per class',
                          'Includes all Basic Tier features, plus:',
                          'Unlimited instructor profiles',
                          'Advanced analytics & performance tracking',
                          'Automated email campaigns for engagement',
                          '25 GB storage for resources & recordings',
                          'Premium support (24/7) with a dedicated manager',
                          'Integration with multiple LMS platforms',
                          'Advanced security features (SSO, encryption)',
                        ],
                        buttonColor: Colors.orange,
                        buttonTextColor: Colors.white,
                      ),
                    ],
                  );
                } else {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildPlanCard(
                            icon: Icons.check_circle,
                            iconColor: Colors.green,
                            tierName: 'Free Tier',
                            label: 'Current',
                            labelColor: Colors.green,
                            labelIcon: Icons.check,
                            attendees: 'Upto 50 Attendees',
                            price: '0\$/month',
                            priceColor: Colors.green,
                            description:
                                'Ideal for small classes, individual tutors, or testing the platform.',
                            features: [
                              'Host up to 50 attendees per class',
                              'Access to basic class scheduling features',
                              'Limited email notifications for attendees',
                              'Access to 1 instructor profile',
                              'Basic attendance tracking and reporting',
                              'Community support only',
                              'Up to 5 class recordings per month',
                              'No integration with external tools (e.g., Zoom, Google Calendar)',
                            ],
                            buttonColor: Colors.green.withOpacity(0.2),
                            buttonTextColor: Colors.green[700]!,
                            isCurrent: true,
                            hasFixedSize: true, // Enable Expanded
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildPlanCard(
                            icon: Icons.star,
                            iconColor: Colors.blue,
                            tierName: 'Basic Tier',
                            label: 'Recommended',
                            labelColor: Colors.blue,
                            labelIcon: Icons.circle,
                            attendees: '51-100 Attendees',
                            price: '200\$/month',
                            priceColor: Colors.blue,
                            description:
                                'Perfect for growing schools or educational startups.',
                            features: [
                              'Host up to 100 attendees per class',
                              'Includes all Free Tier features, plus:',
                              'Custom branding (logos, colors)',
                              'Add up to 3 instructor profiles',
                              'Access to basic analytics dashboard',
                              '10 GB storage for class materials',
                              'Email & chat support',
                              'Integration with Zoom/Google Meet',
                              'Priority access to new features',
                            ],
                            buttonColor: Colors.blue,
                            buttonTextColor: Colors.white,
                            isRecommended: true,
                            hasFixedSize: true, // Enable Expanded
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildPlanCard(
                            icon: Icons.workspace_premium,
                            iconColor: Colors.orange,
                            tierName: 'Pro Tier',
                            label: '',
                            labelColor: Colors.grey,
                            labelIcon: Icons.circle,
                            attendees: '100+ Attendees',
                            price: '300\$/month',
                            priceColor: Colors.orange,
                            description:
                                'Best for established schools or large institutions.',
                            features: [
                              'Host unlimited attendees per class',
                              'Includes all Basic Tier features, plus:',
                              'Unlimited instructor profiles',
                              'Advanced analytics & performance tracking',
                              'Automated email campaigns for engagement',
                              '25 GB storage for resources & recordings',
                              'Premium support (24/7) with a dedicated manager',
                              'Integration with multiple LMS platforms',
                              'Advanced security features (SSO, encryption)',
                            ],
                            buttonColor: Colors.orange,
                            buttonTextColor: Colors.white,
                            hasFixedSize: true, // Enable Expanded
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required IconData icon,
    required Color iconColor,
    required String tierName,
    required String label,
    required Color labelColor,
    required IconData labelIcon,
    required String attendees,
    required String price,
    required Color priceColor,
    required String description,
    required List<String> features,
    required Color buttonColor,
    required Color buttonTextColor,
    bool isCurrent = false,
    bool isRecommended = false,
    bool hasFixedSize = false,
  }) {
    Widget content = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          // Features
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
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
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: iconColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: iconColor, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          tierName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    if (label.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: labelColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(labelIcon, size: 14, color: labelColor),
                            const SizedBox(width: 4),
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: labelColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Text(
                      attendees,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: priceColor,
                  ),
                ),
              ],
            ),
          ),
          // Content
          if (hasFixedSize) Expanded(child: content) else content,
          // Button
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: buttonTextColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Select Plan',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
