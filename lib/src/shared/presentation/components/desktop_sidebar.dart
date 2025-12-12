import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final String selectedItem;
  final Function(String) onItemSelected;

  const Sidebar({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          // Logo Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Adicto School',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildMenuItem(
                  icon: Icons.home,
                  title: 'Home',
                  isSelected: selectedItem == 'Home',
                  onTap: () => onItemSelected('Home'),
                ),
                _buildMenuItem(
                  icon: Icons.grid_view,
                  title: 'Classes',
                  isSelected: selectedItem == 'Classes',
                  onTap: () => onItemSelected('Classes'),
                ),
                _buildMenuItem(
                  icon: Icons.description,
                  title: 'My Plan',
                  isSelected: selectedItem == 'My Plan',
                  onTap: () => onItemSelected('My Plan'),
                ),
                _buildMenuItem(
                  icon: Icons.person,
                  title: 'Subscriber',
                  isSelected: selectedItem == 'Subscriber',
                  onTap: () => onItemSelected('Subscriber'),
                ),
                _buildMenuItem(
                  icon: Icons.receipt,
                  title: 'Billing',
                  isSelected: selectedItem == 'Billing',
                  onTap: () => onItemSelected('Billing'),
                ),
                _buildMenuItem(
                  icon: Icons.credit_card,
                  title: 'Payment Method',
                  isSelected: selectedItem == 'Payment Method',
                  onTap: () => onItemSelected('Payment Method'),
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  title: 'Setting',
                  isSelected: selectedItem == 'Setting',
                  onTap: () => onItemSelected('Setting'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey[600],
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
