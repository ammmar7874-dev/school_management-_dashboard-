import 'package:adicto_school/src/shared/presentation/widgets/common_widgets.dart';
import 'package:adicto_school/src/shared/presentation/widgets/screen_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  int defaultMethodIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ScreenWithBottomNav(
      title: 'Payment Methods',
      currentIndex: 4, // More index
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Saved Cards',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            _buildPaymentCard(
              index: 0,
              type: 'Visa',
              last4: '1234',
              expires: '12/26',
              isDefault: defaultMethodIndex == 0,
            ),
            const SizedBox(height: 16),
            _buildPaymentCard(
              index: 1,
              type: 'Mastercard',
              last4: '1234',
              expires: '12/26',
              isDefault: defaultMethodIndex == 1,
            ),
            const SizedBox(height: 16),
            _buildPaymentCard(
              index: 2,
              type: 'Visa',
              last4: '1234',
              expires: '12/26',
              isDefault: defaultMethodIndex == 2,
            ),
            const SizedBox(height: 32),
            PrimaryButton(text: 'Add New Payment Method', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard({
    required int index,
    required String type,
    required String last4,
    required String expires,
    required bool isDefault,
  }) {
    return CustomCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        type == 'Visa' ? 'VISA' : 'MC',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          color: type == 'Visa' ? Colors.blue : Colors.red,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$type ..... $last4',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      Text(
                        'Expires $expires',
                        style: GoogleFonts.outfit(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isDefault)
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
                    'Default',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF22543D),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    defaultMethodIndex = index;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      isDefault
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isDefault ? const Color(0xFF0085FF) : Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Set as default',
                      style: GoogleFonts.outfit(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Edit',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF0085FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      Icon(Icons.delete, size: 16, color: Colors.red[400]),
                      const SizedBox(width: 4),
                      Text(
                        'Remove',
                        style: GoogleFonts.outfit(
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
