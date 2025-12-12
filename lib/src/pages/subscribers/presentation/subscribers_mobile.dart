import 'package:adicto_school/src/pages/add_subscriber/presentation/add_subscriber_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adicto_school/src/pages/subscriber_detail/presentation/subscriber_detail_screen.dart';

class SubscriptionHistoryScreen extends StatefulWidget {
  const SubscriptionHistoryScreen({super.key});

  @override
  State<SubscriptionHistoryScreen> createState() =>
      _SubscriptionHistoryScreenState();
}

class _SubscriptionHistoryScreenState extends State<SubscriptionHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    } else {
      // Also update when animation settles (for drag gestures)
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = _tabController.index == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0085FF) : Colors.grey[400],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            text,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      // No AppBar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddSubscriberScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF0085FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                _buildTabButton('Active', 0),
                const SizedBox(width: 12),
                _buildTabButton('Expired', 1),
                const SizedBox(width: 12),
                _buildTabButton('Completed', 2),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildList(status: 'Active'),
                _buildList(status: 'Expired'),
                _buildList(status: 'Completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList({required String status}) {
    // Mock data
    final List<Map<String, dynamic>> users = [
      {
        'name': 'Ayesha Khan',
        'plan': 'Monthly Unlimited',
        'phone': '+971 50 123 4567',
        'email': 'ayesha@example.com',
        'pack': '10-Class Pack',
        'used': 6,
        'total': 10,
        'status': 'Active',
      },
      if (status == 'Expired')
        {
          'name': 'Ahmed',
          'plan': 'Monthly Unlimited',
          'phone': '+971 50 123 4567',
          'email': 'ahmed@example.com',
          'pack': '10-Class Pack',
          'used': 6,
          'total': 10,
          'status': 'Expired',
        },
      if (status == 'Active')
        {
          'name': 'Sarah Khan',
          'plan': 'Monthly Unlimited',
          'phone': '+971 50 123 4567',
          'email': 'sarah@example.com',
          'pack': '10-Class Pack',
          'used': 6,
          'total': 10,
          'status': 'Active',
        },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final user = users[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SubscriberDetailScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
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
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(Icons.person, color: Colors.blue[700]),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'],
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user['plan'],
                              style: GoogleFonts.outfit(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: user['status'] == 'Active'
                            ? const Color(0xFF2ECC71)
                            : Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user['status'],
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 12,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContactRow(Icons.phone, user['phone']),
                        const SizedBox(height: 8),
                        _buildContactRow(Icons.email, user['email']),
                        const SizedBox(height: 8),
                        _buildContactRow(
                          Icons.confirmation_number_outlined,
                          user['pack'],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'May 1-May 31, 2025',
                          style: GoogleFonts.outfit(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Classes Used',
                                    style: GoogleFonts.outfit(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${user['used']} / ${user['total']}',
                                    style: GoogleFonts.outfit(fontSize: 10),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: user['used'] / user['total'],
                                backgroundColor: Colors.grey[200],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF0085FF),
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ],
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
      },
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
