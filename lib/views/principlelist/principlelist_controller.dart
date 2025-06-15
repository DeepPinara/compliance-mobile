import 'package:compliancenavigator/data/models/principle.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/utils/pagination/pagination_mixin.dart';

class PrinciplelistController extends GetxController with PaginationMixin {
  final PrincipleRepository _principleRepository;
  final NavigationService navigationService;
  final List<Principle> _principles = [];
  bool _hasReachedEnd = false;
  bool _isRefresh = false;
  int _currentPage = 1;
  static const int itemsPerPage = 10;

  PrinciplelistController({
    required PrincipleRepository principleRepository,
    required NavigationService navigationService,
  }) : _principleRepository = principleRepository,
       navigationService = navigationService;

  static const String principlelistScreenId = 'Principlelist_screen';

  @override
  void onInit() {
    super.onInit();
    loadMoreData();
  }

  @override
  Future<void> loadMoreData() async {
    if (isPaginating || (_hasReachedEnd && !_isRefresh)) return;

    if (_isRefresh) {
      _currentPage = 1;
      _hasReachedEnd = false;
      _principles.clear();
    }

    isPaginating = true;
    update([principlelistScreenId]);

    try {
      final response = await _principleRepository.getPrinciples(
        page: _currentPage,
        limit: itemsPerPage,
      );

      if (response.success && response.data.data != null) {
        final newPrinciples = response.data.data!;
        final totalCount = response.data.totalCount ?? 0;

        if (newPrinciples.isEmpty) {
          _hasReachedEnd = true;
        } else {
          if (_isRefresh) {
            _principles.clear();
          }
          _principles.addAll(newPrinciples);
          
          // Check if we've reached the end of the list
          _hasReachedEnd = _principles.length >= totalCount;
          _currentPage++;
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Failed to load principles');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isPaginating = false;
      _isRefresh = false;
      update([principlelistScreenId]);
    }
  }

  bool get hasMoreData => !_hasReachedEnd;
  bool get isLoading => isPaginating && _principles.isEmpty;
  List<Principle> get items => _principles;

  @override
  void refresh() {
    _isRefresh = true;
    loadMoreData();
  }
}
