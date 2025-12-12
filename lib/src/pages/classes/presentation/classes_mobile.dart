import 'package:adicto_school/src/shared/data/data_manager.dart';
import 'package:adicto_school/src/pages/add_class/presentation/add_class_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataManager = DataManager();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      // No AppBar
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddClassScreen()),
          );
        },
        backgroundColor: const Color(0xFF0085FF),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Classes',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildDateHeader(),
            const SizedBox(height: 16),
            _buildDaySelector(),
            const SizedBox(height: 16),
            ValueListenableBuilder<List<ScheduledClass>>(
              valueListenable: dataManager.classesNotifier,
              builder: (context, classes, _) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: classes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = classes[index];
                    return _buildClassCard(item);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(ScheduledClass item) {
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
                item.name,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF333333),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: item.type == 'Yoga'
                      ? Colors.purple[50]
                      : Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.type,
                  style: GoogleFonts.outfit(
                    color: item.type == 'Yoga' ? Colors.purple : Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildDetailRow(Icons.access_time, item.time)),
              Expanded(child: _buildDetailRow(Icons.person, item.instructor)),
            ],
          ),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.location_on, 'Room 304'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.outfit(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _buildDateHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
          Text(
            'Jan 12 - 17, 2024',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    final days = ['Sun 11', 'Mon 12', 'Tue 13', 'Wed 14', 'Thu 15', 'Fri 16'];
    return SizedBox(
      height: 70,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: days.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == 3;
          return Container(
            constraints: const BoxConstraints(minWidth: 60),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF3F0FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: const Color(0xFF7F56D9), width: 1.5)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  days[index].split(' ')[0],
                  style: GoogleFonts.outfit(
                    color: isSelected ? const Color(0xFF7F56D9) : Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  days[index].split(' ')[1],
                  style: GoogleFonts.outfit(
                    color: isSelected
                        ? const Color(0xFF7F56D9)
                        : const Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
