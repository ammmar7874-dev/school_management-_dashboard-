import 'package:flutter/material.dart';

class ScheduledClass {
  final String name;
  final String instructor;
  final String date;
  final String time;
  final String room;
  final String type;
  final String description;

  ScheduledClass({
    required this.name,
    required this.instructor,
    required this.date,
    required this.time,
    required this.room,
    required this.type,
    required this.description,
  });
}

class SubscriptionPlan {
  final String name;
  final String price;
  final String duration;
  final String entries;
  final String description;

  SubscriptionPlan({
    required this.name,
    required this.price,
    required this.duration,
    required this.entries,
    required this.description,
  });
}

class DataManager {
  static final DataManager _instance = DataManager._internal();

  factory DataManager() {
    return _instance;
  }

  DataManager._internal();

  final ValueNotifier<List<ScheduledClass>> classesNotifier = ValueNotifier([
    ScheduledClass(
      name: 'Salsa Beginners',
      instructor: 'Maria Gomez',
      date: 'Wed 14',
      time: '6:00 PM - 7:00 PM',
      room: 'Studio A - Downtown Branch',
      type: 'Dance',
      description: 'Learn the basics of Salsa dancing.',
    ),
    ScheduledClass(
      name: 'Zumba Beginners',
      instructor: 'Maria Gomez',
      date: 'Wed 14',
      time: '6:00 PM - 7:00 PM',
      room: 'Studio A - Downtown Branch',
      type: 'Fitness',
      description: 'Fun energetic dance workout.',
    ),
    ScheduledClass(
      name: 'Yoga Flow',
      instructor: 'Maria Gomez',
      date: 'Wed 14',
      time: '6:00 PM - 7:00 PM',
      room: 'Studio A - Downtown Branch',
      type: 'Wellness',
      description: 'Relax and stretch with Yoga Flow.',
    ),
    ScheduledClass(
      name: 'HIIT Training',
      instructor: 'Maria Gomez',
      date: 'Wed 14',
      time: '6:00 PM - 7:00 PM',
      room: 'Studio A - Downtown Branch',
      type: 'Fitness',
      description: 'High Intensity Interval Training.',
    ),
  ]);

  final ValueNotifier<List<SubscriptionPlan>> plansNotifier = ValueNotifier([
    SubscriptionPlan(
      name: '10 Class Pack',
      price: '200\$',
      duration: '30 days',
      entries: '10',
      description: '',
    ),
    SubscriptionPlan(
      name: 'Monthly Unlimited',
      price: '200\$',
      duration: '30 days',
      entries: 'Unlimited',
      description: '',
    ),
    SubscriptionPlan(
      name: '5 Class Pack',
      price: '200\$',
      duration: '30 days',
      entries: '5',
      description: '',
    ),
    SubscriptionPlan(
      name: 'Weekly Pass',
      price: '200\$',
      duration: '30 days',
      entries: 'Unlimited',
      description: '',
    ),
    SubscriptionPlan(
      name: 'Annual Membership',
      price: '200\$',
      duration: '30 days',
      entries: 'Unlimited',
      description: '',
    ),
  ]);

  void addClass(ScheduledClass newClass) {
    classesNotifier.value = [...classesNotifier.value, newClass];
  }

  void addPlan(SubscriptionPlan newPlan) {
    plansNotifier.value = [...plansNotifier.value, newPlan];
  }
}
