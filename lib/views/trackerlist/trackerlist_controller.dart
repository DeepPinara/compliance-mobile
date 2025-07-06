import 'package:compliancenavigator/data/models/list_api_response.dart';
import 'package:compliancenavigator/data/models/tracker_application.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/data/services/network_service.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:compliancenavigator/utils/pagination/pagination_mixin.dart';
import 'package:get/get.dart';

class TrackerlistController extends GetxController with PaginationMixin {
  static const String trackerlistScreenId = 'Trackerlist_screen';

  final TrackerRepository _trackerRepository;
  final NetworkService _networkService;
  final NavigationService navigationService;

  TrackerlistController({
    required TrackerRepository trackerRepository,
    required NetworkService networkService,
    required this.navigationService,
  })  : _trackerRepository = trackerRepository,
        _networkService = networkService;

  final List<TrackerApplication> _documents = [];
  bool _isLoading = false;
  bool _hasReachedEnd = false;
  int _currentPage = 1;
  static const int itemsPerPage = 10;
  bool _isRefresh = false;

  List<TrackerApplication> get documents => _documents;
  bool get hasMoreData => !_hasReachedEnd;
  bool get isLoading => _isLoading;
  List<TrackerApplication> get items => List.unmodifiable(_documents);

  @override
  void refresh() {
    _isRefresh = true;
    loadMoreData();
  }

  @override
  void onInit() {
    super.onInit();
    loadMoreData();
  }

  @override
  Future<void> loadMoreData() async {
    if (_isLoading || (_hasReachedEnd && !_isRefresh)) return;

    if (_isRefresh) {
      _currentPage = 1;
      _hasReachedEnd = false;
      _documents.clear();
    }

    _isLoading = true;
    update([trackerlistScreenId]);

    try {
      final ListApiResponse<TrackerApplication> response =
          await _trackerRepository.fetchTrackerForAdmin(
        page: _currentPage,
        limit: itemsPerPage,
      );

      final newDocuments = response.data ?? [];
      final totalCount = response.totalCount ?? 0;

      if (newDocuments.isEmpty) {
        _hasReachedEnd = true;
      } else {
        if (_isRefresh) {
          _documents.clear();
        }
        _documents.addAll(newDocuments);

        // Check if we've reached the end of the list
        _hasReachedEnd = _documents.length >= totalCount;
        _currentPage++;
        update([trackerlistScreenId]);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading = false;
      _isRefresh = false;
      update([trackerlistScreenId]);
    }
  }

  Future<void> onSearch(String query) async {
    // _searchQuery.value = query.trim();
    await loadMoreData();
  }
}
