import 'package:adicto_school/data_manager.dart';
import 'package:adicto_school/screens/add_class_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F6),
        title: Text(
          'Classes',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddClassScreen()),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?u=a042581f4e29026024d',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDateHeader(),
          _buildDaySelector(),
          Expanded(
            child: ValueListenableBuilder<List<ScheduledClass>>(
              valueListenable: DataManager().classesNotifier,
              builder: (context, classes, child) {
                if (classes.isEmpty) {
                  return Center(
                    child: Text(
                      'No classes scheduled.',
                      style: GoogleFonts.outfit(color: Colors.grey),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: classes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = classes[index];
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
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
                          Text(
                            item.name,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDetailRow(Icons.access_time_filled, item.time),
                          const SizedBox(height: 10),
                          _buildDetailRow(
                            Icons.person,
                            'Instructor: ${item.instructor}',
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow(Icons.location_on, item.room),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 16),
            onPressed: () {},
          ),
          Text(
            'Jan 12 - 17, 2024',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    final days = [
      {'day': 'Mon', 'date': '12'},
      {'day': 'Tue', 'date': '13'},
      {'day': 'Wed', 'date': '14'},
      {'day': 'Thu', 'date': '15'},
      {'day': 'Fri', 'date': '16'},
      {'day': 'Sun', 'date': '18'},
      {'day': 'Sat', 'date': '17'},
    ];

    return SizedBox(
      height: 70,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = days[index]['date'] == '14';
          return Container(
            width: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: isSelected
                  ? const Border(
                      bottom: BorderSide(color: Color(0xFF7F56D9), width: 3),
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  days[index]['day']!,
                  style: GoogleFonts.outfit(
                    color: isSelected ? const Color(0xFF7F56D9) : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  days[index]['date']!,
                  style: GoogleFonts.outfit(
                    color: isSelected ? const Color(0xFF7F56D9) : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[400]),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }
}
