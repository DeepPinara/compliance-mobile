import 'package:compliancenavigator/data/models/dashboard_data.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'home_controller.dart';

const String kHomeRoute = '/home';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DLAppBar(
        title: 'Dashboard',
        suffixWidget: Row(
          children: [
            // Select module
            InkWell(
              child: Icon(Icons.menu),
              onTap: () {
                controller.navigationService.navigateToSelectmodule();
              },
            ),
          ],
        ),
      ),
      body: GetBuilder<HomeController>(
        id: HomeController.homeScreenId,
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.error),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.fetchDashboardData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final data = controller.dashboardData;
          if (data == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: controller.fetchDashboardData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsWrap(context, data),
                  const SizedBox(height: 28),
                  _buildGenderRatioCard(data),
                  const SizedBox(height: 28),
                  _buildExpiringContracts(data),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsWrap(BuildContext context, DashboardData data) {
    final statCards = [
      _buildStatCard(
        'Total Companies',
        data.totalCompanies.toString(),
        Icons.business,
        Colors.blueAccent,
      ),
      _buildStatCard(
        'Total Contractors',
        data.totalContractors.toString(),
        Icons.people,
        Colors.green,
      ),
      _buildStatCard(
        'Total Workmen',
        data.totalWorkmen.toString(),
        Icons.engineering,
        Colors.orange,
      ),
      _buildStatCard(
        'Pending Compliances',
        data.pendingCompliances.toString(),
        Icons.pending_actions,
        Colors.redAccent,
      ),
    ];
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: statCards
          .map((card) => SizedBox(
                width: (MediaQuery.of(context).size.width - 48) /
                    2, // 16*2 padding + 16 spacing
                child: card,
              ))
          .toList(),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      shadowColor: color.withOpacity(0.5),
      child: SizedBox(
        height: 190,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 10),
              Text(
                value,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF222B45),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderRatioCard(DashboardData data) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gender Ratio',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${data.maleRatio}%',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Male',
                        style: TextStyle(
                          color: Color(0xFF222B45),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${data.femaleRatio}%',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Female',
                        style: TextStyle(
                          color: Color(0xFF222B45),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpiringContracts(DashboardData data) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'WC Expiring Contractors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            if (data.wcExpiringContractors.isEmpty)
              const Text('No expiring contractors.',
                  style: TextStyle(color: Colors.grey)),
            ...data.wcExpiringContractors.map((contractor) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          contractor.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('MMM dd, yyyy').format(contractor.wcValidTo),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
