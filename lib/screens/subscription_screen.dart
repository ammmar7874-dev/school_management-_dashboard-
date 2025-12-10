import 'package:adicto_school/data_manager.dart';
import 'package:adicto_school/screens/add_subscription_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataManager = DataManager();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      // No AppBar, handled by MainScreen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddSubscriptionPlanScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF0085FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ValueListenableBuilder<List<SubscriptionPlan>>(
        valueListenable: dataManager.plansNotifier,
        builder: (context, plans, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...plans.asMap().entries.map((entry) {
                final index = entry.key;
                final plan = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.name,
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  size: 16,
                                  color: Color(0xFF2ECC71),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  plan.price,
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF2ECC71),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  plan.duration,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${plan.entries} Entries',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F0FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFF7F56D9),
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddSubscriptionPlanScreen(
                                          planToEdit: plan,
                                          planIndex: index,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE5E5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Delete Plan',
                                        style: GoogleFonts.outfit(),
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete "${plan.name}"?',
                                        style: GoogleFonts.outfit(),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.outfit(),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            dataManager.deletePlan(index);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Delete',
                                            style: GoogleFonts.outfit(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
