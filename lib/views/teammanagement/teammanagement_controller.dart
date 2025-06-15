import 'package:get/get.dart';
import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:compliancenavigator/utils/pagination/pagination_mixin.dart';

class TeammanagementController extends GetxController with PaginationMixin {
  final UserRepository userRepository;
  final List<User> _users = [];
  bool _isLoading = false;
  bool _hasReachedEnd = false;
  int _currentPage = 1;
  bool _isRefresh = false;

  TeammanagementController(this.userRepository);

  static const String teammanagementScreenId = 'Teammanagement_screen';
  static const int itemsPerPage = 10;

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
      _users.clear();
    }

    _isLoading = true;
    update([teammanagementScreenId]);

    try {
      final response = await userRepository.getAllUsers(
        page: _currentPage,
        limit: itemsPerPage,
      );

      final newUsers = response.data.data ?? [];
      final totalCount = response.data.totalCount ?? 0;

      if (newUsers.isEmpty) {
        _hasReachedEnd = true;
      } else {
        if (_isRefresh) {
          _users.clear();
        }
        _users.addAll(newUsers);
        
        // Check if we've reached the end of the list
        _hasReachedEnd = _users.length >= totalCount;
        _currentPage++;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading = false;
      _isRefresh = false;
      update([teammanagementScreenId]);
    }
  }

  bool get hasMoreData => !_hasReachedEnd;
  bool get isLoading => _isLoading;
  List<User> get items => List.unmodifiable(_users);

  @override
  void refresh() {
    _isRefresh = true;
    loadMoreData();
  }
}
