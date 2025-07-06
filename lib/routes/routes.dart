part of 'route_imports.dart';

class Routes {
  List<GetPage> getGetXPages() {
    return [
      GetPage(
        name: kSplashRoute,
        page: () => const SplashScreen(),
        binding: SplashBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
          milliseconds: AppConstants.kScreenTransitionDuration,
        ),
      ),
      GetPage(
        name: kLoginRoute,
        page: () => const LoginScreen(),
        binding: LoginBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kDashboardRoute,
        page: () => const DashboardScreen(),
        binding: DashboardBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kCompliancemenuRoute,
        page: () => const CompliancemenuScreen(),
        binding: CompliancemenuBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kTeammanagementRoute,
        page: () => const TeammanagementScreen(),
        binding: TeammanagementBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kProfileRoute,
        page: () => const ProfileScreen(),
        binding: ProfileBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kPrinciplelistRoute,
        page: () => const PrinciplelistScreen(),
        binding: PrinciplelistBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kPrincipledetailRoute,
        page: () => const PrincipledetailScreen(),
        binding: PrincipledetailBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kSelectmoduleRoute,
        page: () => const SelectmoduleScreen(),
        binding: SelectmoduleBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kTrackerdashboardRoute,
        page: () => const TrackerdashboardScreen(),
        binding: TrackerdashboardBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kCreateapplicationtrackerRoute,
        page: () => const CreateapplicationtrackerScreen(),
        binding: CreateapplicationtrackerBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kTrackermenuRoute,
        page: () => const TrackermenuScreen(),
        binding: TrackermenuBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kTrackerdocforvalidationRoute,
        page: () => const TrackerdocforvalidationScreen(),
        binding: TrackerdocforvalidationBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kTrackerapplicationdetailRoute,
        page: () => const TrackerapplicationdetailScreen(),
        binding: TrackerapplicationdetailBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kTrackerlistRoute,
        page: () => const TrackerlistScreen(),
        binding: TrackerlistBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      ),
      GetPage(
        name: kTrackerhomeRoute,
        page: () => const TrackerhomeScreen(),
        binding: TrackerhomeBinding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(
            milliseconds: AppConstants.kScreenTransitionDuration),
      )
    ];
  }
}
