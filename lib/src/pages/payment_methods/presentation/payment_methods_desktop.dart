import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatelessWidget {
  final VoidCallback? onAddCard;

  const PaymentMethodScreen({super.key, this.onAddCard});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 800;

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
                      'Payment Methods',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select a payment method',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: onAddCard ?? () {},
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Add New Card',
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
                // Payment Method Cards
                _buildPaymentCard(
                  cardType: 'Visa',
                  cardNumber: '1234',
                  expires: '12/26',
                  isDefault: true,
                  onEdit: () {},
                  onRemove: () {},
                  isSmallScreen: isSmallScreen,
                ),
                const SizedBox(height: 16),
                _buildPaymentCard(
                  cardType: 'Mastercard',
                  cardNumber: '1234',
                  expires: '12/26',
                  isDefault: false,
                  onEdit: () {},
                  onRemove: () {},
                  isSmallScreen: isSmallScreen,
                ),
                const SizedBox(height: 16),
                _buildPaymentCard(
                  cardType: 'Visa',
                  cardNumber: '1234',
                  expires: '12/26',
                  isDefault: false,
                  onEdit: () {},
                  onRemove: () {},
                  isSmallScreen: isSmallScreen,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentCard({
    required String cardType,
    required String cardNumber,
    required String expires,
    required bool isDefault,
    required VoidCallback onEdit,
    required VoidCallback onRemove,
    required bool isSmallScreen,
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
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildCardLogo(cardType),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildCardDetails(cardType, cardNumber, expires),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDefaultBadge(isDefault),
                    Row(
                      children: [
                        TextButton(
                          onPressed: onEdit,
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                        ),
                        TextButton(
                          onPressed: onRemove,
                          child: Text(
                            'Remove',
                            style: TextStyle(color: Colors.red[600]),
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
                _buildCardLogo(cardType),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCardDetails(cardType, cardNumber, expires),
                ),
                _buildDefaultBadge(isDefault),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: onEdit,
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.delete_outline,
                    size: 16,
                    color: Colors.red[600],
                  ),
                  label: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCardLogo(String cardType) {
    return Container(
      width: 50,
      height: 30,
      decoration: BoxDecoration(
        color: cardType == 'Visa' ? Colors.blue : Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          cardType == 'Visa' ? 'VISA' : 'MC',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCardDetails(String cardType, String cardNumber, String expires) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$cardType ..... $cardNumber',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Expires $expires',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildDefaultBadge(bool isDefault) {
    if (isDefault) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Default',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.green[700],
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Set as default',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
  }
}
