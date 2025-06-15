import 'package:compliancenavigator/data/models/dashboard_data.dart';
import 'package:compliancenavigator/modules/dashboard/dashboard_repository.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

 static const String homeScreenId = 'Home_screen';


  final DashboardRepository dashboardRepository;
  final NavigationService navigationService;
  DashboardData? dashboardData;
  bool isLoading = false;
  String error = '';

  HomeController({required this.dashboardRepository, required this.navigationService});


  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading = true;
      error = '';
      update([homeScreenId]);

      dashboardData = await dashboardRepository.dashboardData();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      update([homeScreenId]);
    }
  }

  // Add your controller logic here
}
