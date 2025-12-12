import 'package:flutter/material.dart';

class SubscribersScreen extends StatelessWidget {
  final VoidCallback? onAddSubscriber;
  final VoidCallback? onViewSubscriber;

  const SubscribersScreen({
    super.key,
    this.onAddSubscriber,
    this.onViewSubscriber,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 1000;

        return Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              _buildHeader(isSmallScreen),
              const SizedBox(height: 24),
              // Filter and Sort Section
              _buildFilters(isSmallScreen),
              const SizedBox(height: 24),
              // Subscribers Table/List
              Expanded(
                child: Container(
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
                      // Header (only for large screens)
                      if (!isSmallScreen) _buildTableHeader(),
                      // List
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          // Remove NeverScrollableScrollPhysics to allow scrolling if needed
                          // But strictly, if the parent is expanded, this should scroll.
                          // Wait, the original code had NeverScrollableScrollPhysics inside an Expanded column?
                          // That implies the outer container wasn't scrollable?
                          // Check original code: Expanded -> Container -> Column -> Expanded -> ListView(shrinkWrap, NeverScrollable).
                          // This means the ListView wouldn't scroll, but it was wrapped in Expanded.
                          // If the list is long, it would overflow or be clipped if the parent doesn't scroll.
                          // Usually one wants the ListView to scroll.
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            if (isSmallScreen) ...[
                              _buildSubscriberMobileCard(
                                name: 'Maria Khan',
                                memberSince: 'Member Since Jan 2024',
                                phone: '+40 700 556644',
                                email: 'maria@example.com',
                                plan: '1 Month Pass',
                                planColor: Colors.green,
                              ),
                              _buildSubscriberMobileCard(
                                name: 'John Doe',
                                memberSince: 'Member Since Jan 2024',
                                phone: '+40 700 556644',
                                email: 'john@example.com',
                                plan: 'Unlimited Monthly',
                                planColor: Colors.blue,
                              ),
                              _buildSubscriberMobileCard(
                                name: 'Sarah Johnson',
                                memberSince: 'Member Since Jan 2024',
                                phone: '+40 700 556644',
                                email: 'sarah@example.com',
                                plan: '3 Months Pass',
                                planColor: Colors.orange,
                              ),
                            ] else ...[
                              _buildSubscriberRow(
                                name: 'Maria Khan',
                                memberSince: 'Member Since Jan 2024',
                                phone: '+40 700 556644',
                                email: 'maria@example.com',
                                plan: '1 Month Pass',
                                planColor: Colors.green,
                              ),
                              _buildSubscriberRow(
                                name: 'John Doe',
                                memberSince: 'Member Since Jan 2024',
                                phone: '+40 700 556644',
                                email: 'john@example.com',
                                plan: 'Unlimited Monthly',
                                planColor: Colors.blue,
                              ),
                              _buildSubscriberRow(
                                name: 'Sarah Johnson',
                                memberSince: 'Member Since Jan 2024',
                                phone: '+40 700 556644',
                                email: 'sarah@example.com',
                                plan: '3 Months Pass',
                                planColor: Colors.orange,
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Pagination
                      _buildPagination(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Subscribers',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage your subscription plans and pricing',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: onAddSubscriber ?? () {},
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'Add Subscriber',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(bool isSmallScreen) {
    if (isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.filter_list, color: Colors.grey[600], size: 20),
              const SizedBox(width: 8),
              Text(
                'Filter by Status:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildRadioButton('All', true),
                const SizedBox(width: 16),
                _buildRadioButton('Active', false),
                const SizedBox(width: 16),
                _buildRadioButton('Expired', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: DropdownButton<String>(
              value: 'Name (A-Z)',
              isExpanded: true,
              underline: const SizedBox(),
              items: ['Name (A-Z)', 'Name (Z-A)', 'Date']
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (value) {},
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Filter by Status
        Row(
          children: [
            Icon(Icons.filter_list, color: Colors.grey[600], size: 20),
            const SizedBox(width: 8),
            Text(
              'Filter by Status:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                _buildRadioButton('All', true),
                const SizedBox(width: 16),
                _buildRadioButton('Active', false),
                const SizedBox(width: 16),
                _buildRadioButton('Expired', false),
              ],
            ),
          ],
        ),
        // Sort Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: DropdownButton<String>(
            value: 'Name (A-Z)',
            underline: const SizedBox(),
            items: ['Name (A-Z)', 'Name (Z-A)', 'Date']
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'NAME',
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
              'PHONE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'EMAIL',
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
              'PLAN',
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
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Wrap(
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
                icon: Icon(Icons.chevron_left, color: Colors.grey[400]),
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
              const SizedBox(width: 4),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.grey[400]),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriberMobileCard({
    required String name,
    required String memberSince,
    required String phone,
    required String email,
    required String plan,
    required Color planColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Icon(Icons.person, color: Colors.grey[600], size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      memberSince,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: planColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  plan,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: _getDarkerColor(planColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  phone,
                  style: TextStyle(color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  email,
                  style: TextStyle(color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onViewSubscriber ?? () {},
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.blue[700],
                size: 16,
              ),
              label: Text(
                'View Details',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[700]!,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButton(String label, bool isSelected) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey[400]!,
              width: 2,
            ),
            color: Colors.white,
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildSubscriberRow({
    required String name,
    required String memberSince,
    required String phone,
    required String email,
    required String plan,
    required Color planColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: Icon(Icons.person, color: Colors.grey[600], size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        memberSince,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              phone,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              email,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: planColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    plan,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _getDarkerColor(planColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onViewSubscriber ?? () {},
                child: Text(
                  'View >',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[700]!,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDarkerColor(Color color) {
    if (color == Colors.green) return Colors.green[700]!;
    if (color == Colors.blue) return Colors.blue[700]!;
    if (color == Colors.orange) return Colors.orange[700]!;
    return color;
  }
}
