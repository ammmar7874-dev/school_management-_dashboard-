import 'package:adicto_school/src/shared/presentation/components/desktop_header.dart';
import 'package:adicto_school/src/shared/presentation/components/desktop_sidebar.dart';

import 'package:adicto_school/src/pages/classes/presentation/classes_desktop.dart';
import 'package:adicto_school/src/pages/home/presentation/home_desktop.dart';
import 'package:adicto_school/src/pages/subscription_plan/presentation/subscription_plan_desktop.dart';
import 'package:adicto_school/src/pages/payment_methods/presentation/payment_methods_desktop.dart';

import 'package:adicto_school/src/pages/settings/presentation/settings_desktop.dart';
import 'package:adicto_school/src/pages/subscriber_detail/presentation/subscriber_detail_desktop.dart';
import 'package:adicto_school/src/pages/subscribers/presentation/subscribers_desktop.dart';
import 'package:adicto_school/src/pages/add_class/presentation/add_class_desktop.dart';
import 'package:adicto_school/src/pages/add_subscription_plan/presentation/add_subscription_plan_desktop.dart';
import 'package:adicto_school/src/pages/add_subscriber/presentation/add_subscriber_desktop.dart';
import 'package:adicto_school/src/pages/billing/presentation/billing_desktop.dart';
import 'package:adicto_school/src/pages/choose_plan/presentation/choose_plan_desktop.dart';
import 'package:adicto_school/src/pages/send_notification/presentation/send_notification_desktop.dart';
import 'package:adicto_school/src/pages/notification_history/presentation/notification_history_desktop.dart';
import 'package:adicto_school/src/pages/revenue/presentation/revenue_desktop.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String initialRoute;
  final String? initialLocalRoute; // New parameter
  final int selectedIndex;
  final Function(int) onIndexChanged;

  const MainScreen({
    super.key,
    this.initialRoute = 'Home',
    this.initialLocalRoute,
    this.selectedIndex = 0,
    required this.onIndexChanged,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Local override for pages that don't map to bottom nav indices (e.g. Billing)
  String? _localRoute;

  @override
  void initState() {
    super.initState();
    _localRoute = widget.initialLocalRoute; // Initialize with connection
  }

  // Mapping for title
  String get _pageTitle =>
      _localRoute ?? _getRouteFromIndex(widget.selectedIndex);

  @override
  void didUpdateWidget(MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      // If external index changes, clear local override to show the tab
      _localRoute = null;
    }
    // Update local route if the widget updates with a new initialLocalRoute that is different?
    // Usually initial params are only for init, but if we want to force it:
    if (widget.initialLocalRoute != oldWidget.initialLocalRoute &&
        widget.initialLocalRoute != null) {
      _localRoute = widget.initialLocalRoute;
    }
  }

  String _getRouteFromIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Classes';
      case 2:
        return 'My Plan';
      case 3:
        return 'Subscriber';
      case 4:
        return 'Setting';
      default:
        return 'Home';
    }
  }

  int _getIndexFromRoute(String route) {
    switch (route) {
      case 'Home':
        return 0;
      case 'Classes':
        return 1;
      case 'My Plan':
        return 2;
      case 'Subscriber':
        return 3;
      case 'Setting':
        return 4;
      default:
        return -1;
    }
  }

  void _onItemSelected(String item) {
    int index = _getIndexFromRoute(item);
    if (index != -1) {
      _localRoute = null;
      widget.onIndexChanged(index);
    } else {
      setState(() {
        _localRoute = item;
      });
    }
  }

  Widget _buildContent() {
    String currentRoute =
        _localRoute ?? _getRouteFromIndex(widget.selectedIndex);

    switch (currentRoute) {
      case 'Home':
        return DashboardScreen(
          onAddClass: () => _onItemSelected('AddClass'),
          onAddPlan: () => _onItemSelected('AddPlan'),
          onViewRevenue: () => _onItemSelected('Revenue'),
          onSendNotification: () => _onItemSelected('SendNotification'),
        );
      case 'Revenue':
        return RevenueOverviewScreen(onBack: () => _onItemSelected('Home'));
      case 'Classes':
        return ClassesScreen(onAddClass: () => _onItemSelected('AddClass'));
      case 'My Plan':
        return MyPlanScreen(onAddPlan: () => _onItemSelected('AddPlan'));
      case 'Subscriber':
        return SubscribersScreen(
          onAddSubscriber: () => _onItemSelected('AddSubscriber'),
        );
      case 'Billing':
        return BillingScreen(onChangePlan: () => _onItemSelected('ChoosePlan'));
      case 'Payment Method':
        return const PaymentMethodScreen();
      case 'Setting':
        return const SettingScreen();
      case 'AddClass':
        return AddClassScreen(
          onCancel: () => _onItemSelected('Classes'),
          onSave: () {
            // Logic to save class
            _onItemSelected('Classes');
          },
        );
      case 'AddPlan':
        return AddPlanScreen(
          onCancel: () => _onItemSelected('My Plan'),
          onSave: () {
            // Logic to save plan
            _onItemSelected('My Plan');
          },
        );
      case 'AddSubscriber':
        return AddSubscriberScreen(
          // Assuming this constructor exists like others
          onCancel: () => _onItemSelected('Subscriber'),
          onSave: () {
            _onItemSelected('Subscriber');
          },
        );
      case 'SubscriberDetail':
        return SubscriberDetailsScreen(
          onBack: () => _onItemSelected('Subscriber'),
        );
      case 'AppTier':
        return BillingScreen(
          onChangePlan: () {
            // Navigate to ChoosePlan route within the shell if possible,
            // or just update local route.
            // Since we want to keep the shell, we should probably just change the local route?
            // But wait, the previous code pushed a MaterialPageRoute.
            // Let's stick to the shell pattern.
            setState(() {
              _localRoute = 'ChoosePlan';
            });
          },
        );
      case 'ChoosePlan':
        return ChoosePlanScreen(
          onCancel: () {
            setState(() {
              _localRoute = 'AppTier';
            });
          },
        );
      case 'SendNotification':
        return SendNotificationScreen(
          onCancel: () => _onItemSelected('Home'), // Return to dashboard
          onSend: () => _onItemSelected('Home'),
        );
      case 'NotificationHistory':
        return NotificationHistoryScreen(
          onNewNotification: () => _onItemSelected('SendNotification'),
        );
      default:
        return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedItem:
                _localRoute ?? _getRouteFromIndex(widget.selectedIndex),
            onItemSelected: _onItemSelected,
          ),
          Expanded(
            child: Column(
              children: [
                Header(
                  pageTitle: _pageTitle,
                  onNotificationPressed: () {
                    _onItemSelected('NotificationHistory');
                  },
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFFAF9F6),
                    child: _buildContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
