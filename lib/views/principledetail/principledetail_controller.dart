import 'package:compliancenavigator/data/models/principle.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:compliancenavigator/utils/snack_bar.dart';
import 'package:get/get.dart';

class PrincipledetailController extends GetxController {
  final NavigationService navigationService;
  final PrincipleRepository _principleRepository;

  static const String principledetailScreenId = 'Principledetail_screen';

  PrincipledetailController({
    required this.navigationService,
    required PrincipleRepository principleRepository,
  }) : _principleRepository = principleRepository;

  Principle? _principle;
  Principle? get principle => _principle;
  int get principleId => _principle?.id ?? 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getArgs();
  }

  void getArgs() {
    final args = Get.arguments;
    final principleId = args['principleId'];
    final principle = args['principle'];

    if (principleId != null) {
      if (principle == null) {
        fetchPrincipleDetail(principleId);
      }
    } else {
      navigationService.goBack();
      showSnackBar('Principle ID is required');
    }
  }

  void updateLoading(
    bool isLoading,
  ) {
    _isLoading = isLoading;
    update([principledetailScreenId]);
  }

  void fetchPrincipleDetail(int principleId) {
    try {
      updateLoading(true);
      _principleRepository.getPrinciplesById(principleId).then((value) {
        _principle = value.data;
        updateLoading(false);
      });
    } catch (e) {
      updateLoading(false);
      showSnackBar(e.toString());
    }
  }
}
