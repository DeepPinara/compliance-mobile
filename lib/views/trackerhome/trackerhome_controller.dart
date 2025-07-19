import 'dart:developer';

import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:compliancenavigator/data/models/dashboard_stats_model.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';

// Data classes for charts and UI
// Data class for chart items
class ChartData {
  final String label;
  final double value;
  final Color color;

  const ChartData(this.label, this.value, this.color);
}

// Data class for pending items
class PendingData {
  final String range;
  final int count;
  final Color color;

  const PendingData(this.range, this.count, this.color);
}

// Data class for principal items
class PrincipalData {
  final String name;
  final int applications;
  final double progress;
  final Color color;

  const PrincipalData(this.name, this.applications, this.progress, this.color);
}

// Extension for string utilities
extension StringExtension on String {
  String toTitleCase() {
    if (length <= 1) return toUpperCase();
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

class TrackerhomeController extends GetxController {
  static const String trackerhomeScreenId = 'tracker_home_screen';

  final TrackerRepository trackerRepository;
  final NavigationService navigationService;

  // Controller state
  bool _isLoading = true;
  String? _error;
  DashboardStats? _dashboardData;

  // Chart data
  final List<ChartData> statusChartData = [];
  final List<PendingData> pendingData = [];
  final List<PrincipalData> topPrincipalsData = [];
  final List<String> applicationStatusChart = [];

  // Status colors mapping
  final Map<String, Color> statusColors = {
    'Completed': Colors.green,
    'In Progress': Colors.blue,
    'Pending': Colors.orange,
    'Overdue': Colors.red,
  };

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  DashboardStats? get dashboardData => _dashboardData;

  TrackerhomeController({
    required this.trackerRepository,
    required this.navigationService,
  });

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  // Update state and refresh UI
  void _updateState({
    bool? isLoading,
    String? error,
    DashboardStats? dashboardData,
  }) {
    if (isLoading != null) _isLoading = isLoading;
    if (error != null) _error = error;
    if (dashboardData != null) {
      _dashboardData = dashboardData;
      _prepareChartData();
    }

    // Update UI with the specific screen ID
    update([trackerhomeScreenId]);
  }

  // Fetch dashboard data
  Future<void> fetchDashboardData() async {
    try {
      _isLoading = true;
      update([trackerhomeScreenId]);

      // TODO: Replace with actual API call
      // final response = await trackerRepository.getTrackerDashboardStats();
      // _dashboardData = response;

      // Mock data for now
      await Future.delayed(const Duration(milliseconds: 500));

      // Prepare chart data
      _prepareChartData();

      _isLoading = false;
      update([trackerhomeScreenId]);
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      update([trackerhomeScreenId]);
    }
  }

  // Refresh data
  Future<void> refreshData() async {
    await fetchDashboardData();
  }

  // Get pie chart sections for application status
  List<PieChartSectionData> getPieChartSections() {
    if (statusChartData.isEmpty) return [];

    return statusChartData.map((data) {
      final total = statusChartData.fold(0.0, (sum, item) => sum + item.value);
      final percentage = (data.value / total * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: data.color,
        value: data.value,
        title: '$percentage%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  // Get status color based on activity type
  Color _getStatusColor(String status) {
    return statusColors[status] ?? Colors.grey;
  }

  // Get color for pending items based on range
  Color _getPendingColor(String range) {
    if (range.contains('30+')) return const Color(0xFFEF4444); // red
    if (range.contains('16-30')) return const Color(0xFFF59E0B); // amber
    if (range.contains('8-15')) return const Color(0xFF3B82F6); // blue
    return const Color(0xFF8B5CF6); // purple (default for 0-7 range)
  }

  // Prepare chart data
  void _prepareChartData() {
    // Clear existing data
    statusChartData.clear();
    pendingData.clear();
    topPrincipalsData.clear();

    if (_dashboardData != null) {
      // TODO: Uncomment and implement with actual data from _dashboardData
      /*
      // Example implementation with actual data
      if (_dashboardData!.statusSummary != null) {
        statusChartData.addAll([
          ChartData(
            'Completed', 
            _dashboardData!.statusSummary!.completed.toDouble(), 
            _getStatusColor('Completed')
          ),
          // Add other statuses
        ]);
      }
      
      if (_dashboardData!.pendingApplications != null) {
        pendingData.addAll([
          PendingData(
            '0-7', 
            _dashboardData!.pendingApplications!.pending0to7, 
            _getPendingColor('0-7')
          ),
          // Add other ranges
        ]);
      }
      
      if (_dashboardData!.topPrincipals != null) {
        for (var principal in _dashboardData!.topPrincipals!) {
          topPrincipalsData.add(
            PrincipalData(
              principal.name,
              principal.applicationCount,
              principal.progress,
              _getStatusColor(principal.status),
            ),
          );
        }
      }
      */
    } else {
      // Fallback to sample data if _dashboardData is null
      statusChartData.addAll([
        ChartData('Completed', 45, _getStatusColor('Completed')),
        ChartData('In Progress', 30, _getStatusColor('In Progress')),
        ChartData('Pending', 15, _getStatusColor('Pending')),
        ChartData('Overdue', 10, _getStatusColor('Overdue')),
      ]);

      pendingData.addAll([
        PendingData('0-7', 5, _getPendingColor('0-7')),
        PendingData('8-15', 10, _getPendingColor('8-15')),
        PendingData('16-30', 8, _getPendingColor('16-30')),
        PendingData('30+', 3, _getPendingColor('30+')),
      ]);

      topPrincipalsData.addAll([
        PrincipalData('Principal 1', 15, 0.75, _getStatusColor('In Progress')),
        PrincipalData('Principal 2', 10, 0.50, _getStatusColor('In Progress')),
      ]);
    }
  }

  void updateApplicationStatusChart({required String selectedvalue}) {
    if (applicationStatusChart.contains(selectedvalue)) {
      applicationStatusChart.remove(selectedvalue);
    } else {
      applicationStatusChart.add(selectedvalue);
    }
    update([trackerhomeScreenId]);
  }
}
