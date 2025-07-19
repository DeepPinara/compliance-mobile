import 'package:compliancenavigator/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:compliancenavigator/widgets/custom_card.dart';
import 'trackerhome_controller.dart';
import 'package:compliancenavigator/widgets/bottom_sheet.dart'; // Added import for DLBaseBottomSheet

// App colors definition since we're not using the theme file
const Color primaryColor = Color(0xFF2196F3);
const Color dangerColor = Color(0xFFF44336);

const String kTrackerhomeRoute = '/trackerhome';

class TrackerhomeScreen extends GetView<TrackerhomeController> {
  const TrackerhomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;

    return Scaffold(
      appBar: DLAppBar(
        title: 'Tracker Overview',
        suffixWidget: Row(
          children: [
            // Select module
            InkWell(
              child: Icon(Icons.assignment_turned_in_rounded),
              onTap: () {
                controller.navigationService.navigateToSelectmodule();
              },
            ),
          ],
        ),
      ),
      body: GetBuilder<TrackerhomeController>(
        id: TrackerhomeController.trackerhomeScreenId,
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: controller.fetchDashboardData,
            child: controller.isLoading
                ? _buildLoadingState()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        _buildHeader(theme),
                        const SizedBox(height: 16),

                        // Summary Cards
                        _buildSummaryCards(theme, controller),

                        const SizedBox(height: 16),

                        // Main Content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column - Chart
                            _buildChartSection(theme, controller),

                            // Right Column - Pending Actions and Top Principals
                            Column(
                              children: [
                                const SizedBox(height: 16),
                                _buildPendingActions(theme, controller),
                                const SizedBox(height: 16),
                                _buildRecentActivity(theme, controller),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Here\'s your tracker overview',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.hintColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_alt_rounded,
                    color: Colors.blueAccent),
                tooltip: 'Filter',
                onPressed: () => _showFilterBottomSheet(),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: theme.hintColor.withOpacity(0.7),
              ),
              const SizedBox(width: 6),
              Text(
                DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    DLBaseBottomSheet.show(
      title: 'Filter Tracker',
      child: SizedBox(
          height: Get.size.height * 0.75, child: _buildFilterContent()),
      isTitleCenter: true,
    );
  }

  Widget _buildFilterContent() {
    final List<String> statusOptions =
        TrackerApplicationStatusExtension.allStatuses;
    final List<String> appTypeOptions =
        TrackerApplicationType.values.map((e) => e.displayName).toList();
    final List<String> paymentOptions = ['All', 'Yes', 'No'];

    Set<String> selectedStatus = {'All'};
    Set<String> selectedAppTypes = {};
    String selectedPayment = 'All';
    Set<String> selectedPrincipals = {};
    DateTime? fromDate;
    DateTime? toDate;

    return StatefulBuilder(
      builder: (context, setState) {
        Widget chipWrap(
            List<String> options, Set<String> selected, String label,
            {bool multi = true}) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options.map((option) {
                  final isSelected = selected.contains(option);
                  return FilterChip(
                    label: Text(option),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() {
                        if (multi) {
                          if (val) {
                            selected.add(option);
                            if (selected.contains('All')) {
                              selected.remove('All');
                            }
                            if (option == 'All') {
                              selected.clear();
                              selected.add('All');
                            }
                          } else {
                            selected.remove(option);
                          }
                        } else {
                          selected.clear();
                          if (val) selected.add(option);
                        }
                      });
                    },
                    selectedColor: Colors.blue.shade100,
                    checkmarkColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue.shade800 : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
            ],
          );
        }

        Widget choiceChipRow(List<String> options, String selected,
            String label, void Function(String) onChanged) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options.map((option) {
                  final isSelected = selected == option;
                  return ChoiceChip(
                    label: Text(option),
                    selected: isSelected,
                    onSelected: (_) => setState(() => onChanged(option)),
                    selectedColor: Colors.blue.shade100,
                    checkmarkColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue.shade800 : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
            ],
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Range
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: _dateChip(
                                  context,
                                  'From',
                                  fromDate,
                                  (picked) =>
                                      setState(() => fromDate = picked)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _dateChip(context, 'To', toDate,
                                  (picked) => setState(() => toDate = picked)),
                            ),
                          ],
                        ),
                      ),
                      // Application Type (multi-select)
                      chipWrap(
                          appTypeOptions, selectedAppTypes, 'Application Type'),
                      // Payment Received (single select)
                      choiceChipRow(
                          paymentOptions,
                          selectedPayment,
                          'Payment Received',
                          (val) => setState(() => selectedPayment = val)),

                      // Status (single select)
                      chipWrap(statusOptions, selectedStatus, 'Status'),
                    ],
                  ),
                ),
              ),
              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: SafeArea(
                  bottom: true,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            // TODO: Apply filter logic
                            Get.back();
                          },
                          child: const Text('Apply',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedStatus.clear();
                              selectedStatus.add('All');
                              selectedAppTypes.clear();
                              selectedPayment = 'All';
                              selectedPrincipals.clear();
                              fromDate = null;
                              toDate = null;
                            });
                          },
                          child: const Text('Reset',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
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

  Widget _dateChip(BuildContext context, String label, DateTime? date,
      ValueChanged<DateTime> onPicked) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Colors.blue, // header, selected day
                  onPrimary: Colors.white, // text on header, selected day
                  onSurface: Colors.blueGrey, // default text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent, // button text color
                  ),
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          },
        );
        if (picked != null) onPicked(picked);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 18, color: Colors.blue.shade400),
            const SizedBox(width: 8),
            Text(
              date != null ? DateFormat('yyyy-MM-dd').format(date) : label,
              style: TextStyle(
                color: date != null ? Colors.blue.shade800 : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(String label, List<String> options, String? selected,
      ValueChanged<String?>? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: selected,
            items: options
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datePickerField(BuildContext context,
      {required String label, DateTime? date, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            hintText: 'Select date',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: const Icon(Icons.calendar_today, size: 18),
          ),
          controller: TextEditingController(
              text: date != null ? DateFormat('yyyy-MM-dd').format(date) : ''),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(ThemeData theme, TrackerhomeController controller) {
    // Using controller's data directly instead of dashboardStats
    final totalApplications = controller.statusChartData
        .fold<int>(0, (sum, item) => sum + item.value.toInt());
    final pendingCount =
        controller.pendingData.fold<int>(0, (sum, item) => sum + item.count);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          // First row of cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  theme,
                  'Total Applications',
                  '$totalApplications',
                  Icons.assignment,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  theme,
                  'Pending Verifications',
                  '$pendingCount',
                  Icons.assignment_late,
                  Colors.orange,
                  isAlert: pendingCount > 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Second row of cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  theme,
                  'Total Workforce',
                  '${(totalApplications * 2.5).toInt()}',
                  Icons.people,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  theme,
                  'Active Principals',
                  '${(totalApplications * 0.3).toInt()}',
                  Icons.business,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    ThemeData theme,
    String title,
    String value,
    IconData icon,
    Color color, {
    bool isAlert = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              if (isAlert)
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(left: 4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection(ThemeData theme, TrackerhomeController controller) {
    return CustomCard(
      showBorder: true,
      isElivated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Application Status',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: controller.statusChartData.isEmpty
                ? const Center(child: Text('No data available'))
                : PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 60,
                      sections: controller.statusChartData
                          .asMap()
                          .entries
                          .map((entry) {
                        final data = entry.value;
                        return PieChartSectionData(
                          color: data.color,
                          value: data.value,
                          title:
                              '${(data.value / (controller.statusChartData.fold(0.0, (sum, item) => sum + item.value)) * 100).toStringAsFixed(1)}%',
                          radius: 100,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Wrap(
              spacing: 16,
              alignment: WrapAlignment.center,
              runSpacing: 8,
              children: controller.statusChartData.map((data) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: data.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${data.label}: ${data.value}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingActions(
      ThemeData theme, TrackerhomeController controller) {
    return CustomCard(
      showBorder: true,
      isElivated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pending Actions',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Tooltip(
                message: 'Number of pending items by days overdue',
                child: Icon(
                  Icons.info_outline,
                  size: 18,
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Items requiring your attention',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
          const SizedBox(height: 16),
          ...controller.pendingData.map((data) {
            final daysText =
                data.range == '30+' ? '30+ days' : '${data.range} days';

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        daysText,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${data.count} items',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (data.count / 15).clamp(0.0, 1.0),
                      minHeight: 8,
                      backgroundColor: theme.dividerColor.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(data.color),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Navigate to pending items screen
              },
              style: TextButton.styleFrom(
                foregroundColor: theme.primaryColor,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('View All Pending Items'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(
      ThemeData theme, TrackerhomeController controller) {
    return CustomCard(
      showBorder: true,
      isElivated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text('View All'),
              // ),
            ],
          ),
          const SizedBox(height: 8),
          // Coming soon
          const Text(
            'Coming soon...',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          // Hide for now
          // ListView.separated(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: 3,
          //   separatorBuilder: (_, __) => const Divider(height: 24),
          //   itemBuilder: (context, index) {
          //     return const ListTile(
          //       contentPadding: EdgeInsets.zero,
          //       leading: CircleAvatar(
          //         child: Icon(Icons.person, size: 20),
          //       ),
          //       title: Text(
          //         'New application submitted',
          //       ),
          //       subtitle: Text(
          //         '2 hours ago',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       trailing: Icon(
          //         Icons.chevron_right,
          //         size: 20,
          //         color: Colors.black,
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Header Shimmer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 24,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: 150,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Summary Cards Shimmer
        Column(
          children: List.generate(
            2,
            (index) => Row(
              children: List.generate(
                2,
                (index) => Expanded(
                    child: Container(
                  height: 100,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
