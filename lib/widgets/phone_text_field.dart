import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/themes/text_field_theme.dart';
import 'package:compliancenavigator/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CountryInfo {
  final String name;
  final String dialCode;
  final String code;
  final String flagUrl;

  CountryInfo({
    required this.name,
    required this.dialCode,
    required this.code,
    required this.flagUrl,
  });

  factory CountryInfo.fromJson(String name, Map<String, dynamic> json) {
    return CountryInfo(
      name: name,
      dialCode: json['dial_code'] as String,
      code: json['code'] as String,
      flagUrl: 'https://flagcdn.com/h160/${json['code'].toLowerCase()}.png',
    );
  }
}

class DLPhoneTextField extends StatefulWidget {
  const DLPhoneTextField({
    super.key,
    required this.controller,
    this.label = '',
    this.hint = '',
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.readOnly = false,
    this.enabled = true,
    this.isRequired = false,
    this.initialCountry = 'Australia',
    this.onCountryChanged,
  });

  final TextEditingController controller;
  final String? label;
  final String hint;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool enabled;
  final bool isRequired;
  final String initialCountry;
  final Function(CountryInfo?)? onCountryChanged;

  @override
  State<DLPhoneTextField> createState() => _DLPhoneTextFieldState();
}

class _DLPhoneTextFieldState extends State<DLPhoneTextField> {
  final FocusNode _focusNode = FocusNode();
  CountryInfo? _selectedCountry;
  final Map<String, Map<String, dynamic>> _countriesData = {};
  List<CountryInfo> _countries = [];

  @override
  void initState() {
    super.initState();
    _initializeCountriesData();
    _selectInitialCountry();
  }

  void _initializeCountriesData() {
    _countriesData.addAll({
      "Afghanistan": {"dial_code": "+93", "code": "AF"},
      "Aland Islands": {"dial_code": "+358", "code": "AX"},
      "Albania": {"dial_code": "+355", "code": "AL"},
      "Algeria": {"dial_code": "+213", "code": "DZ"},
      "AmericanSamoa": {"dial_code": "+1684", "code": "AS"},
      "Andorra": {"dial_code": "+376", "code": "AD"},
      "Angola": {"dial_code": "+244", "code": "AO"},
      "Anguilla": {"dial_code": "+1264", "code": "AI"},
      "Antarctica": {"dial_code": "+672", "code": "AQ"},
      "Antigua and Barbuda": {"dial_code": "+1268", "code": "AG"},
      "Argentina": {"dial_code": "+54", "code": "AR"},
      "Armenia": {"dial_code": "+374", "code": "AM"},
      "Aruba": {"dial_code": "+297", "code": "AW"},
      "Australia": {"dial_code": "+61", "code": "AU"},
      "Austria": {"dial_code": "+43", "code": "AT"},
      "Azerbaijan": {"dial_code": "+994", "code": "AZ"},
      "Bahamas": {"dial_code": "+1242", "code": "BS"},
      "Bahrain": {"dial_code": "+973", "code": "BH"},
      "Bangladesh": {"dial_code": "+880", "code": "BD"},
      "Barbados": {"dial_code": "+1246", "code": "BB"},
      "Belarus": {"dial_code": "+375", "code": "BY"},
      "Belgium": {"dial_code": "+32", "code": "BE"},
      "Belize": {"dial_code": "+501", "code": "BZ"},
      "Benin": {"dial_code": "+229", "code": "BJ"},
      "Bermuda": {"dial_code": "+1441", "code": "BM"},
      "Bhutan": {"dial_code": "+975", "code": "BT"},
      "Bolivia, Plurinational State of": {"dial_code": "+591", "code": "BO"},
      "Bosnia and Herzegovina": {"dial_code": "+387", "code": "BA"},
      "Botswana": {"dial_code": "+267", "code": "BW"},
      "Brazil": {"dial_code": "+55", "code": "BR"},
      "British Indian Ocean Territory": {"dial_code": "+246", "code": "IO"},
      "Brunei Darussalam": {"dial_code": "+673", "code": "BN"},
      "Bulgaria": {"dial_code": "+359", "code": "BG"},
      "Burkina Faso": {"dial_code": "+226", "code": "BF"},
      "Burundi": {"dial_code": "+257", "code": "BI"},
      "Cambodia": {"dial_code": "+855", "code": "KH"},
      "Cameroon": {"dial_code": "+237", "code": "CM"},
      "Canada": {"dial_code": "+1", "code": "CA"},
      "Cape Verde": {"dial_code": "+238", "code": "CV"},
      "Cayman Islands": {"dial_code": "+ 345", "code": "KY"},
      "Central African Republic": {"dial_code": "+236", "code": "CF"},
      "Chad": {"dial_code": "+235", "code": "TD"},
      "Chile": {"dial_code": "+56", "code": "CL"},
      "China": {"dial_code": "+86", "code": "CN"},
      "Christmas Island": {"dial_code": "+61", "code": "CX"},
      "Cocos (Keeling) Islands": {"dial_code": "+61", "code": "CC"},
      "Colombia": {"dial_code": "+57", "code": "CO"},
      "Comoros": {"dial_code": "+269", "code": "KM"},
      "Congo": {"dial_code": "+242", "code": "CG"},
      "Congo, The Democratic Republic of the Congo": {
        "dial_code": "+243",
        "code": "CD"
      },
      "Cook Islands": {"dial_code": "+682", "code": "CK"},
      "Costa Rica": {"dial_code": "+506", "code": "CR"},
      "Cote d'Ivoire": {"dial_code": "+225", "code": "CI"},
      "Croatia": {"dial_code": "+385", "code": "HR"},
      "Cuba": {"dial_code": "+53", "code": "CU"},
      "Cyprus": {"dial_code": "+357", "code": "CY"},
      "Czech Republic": {"dial_code": "+420", "code": "CZ"},
      "Denmark": {"dial_code": "+45", "code": "DK"},
      "Djibouti": {"dial_code": "+253", "code": "DJ"},
      "Dominica": {"dial_code": "+1767", "code": "DM"},
      "Dominican Republic": {"dial_code": "+1849", "code": "DO"},
      "Ecuador": {"dial_code": "+593", "code": "EC"},
      "Egypt": {"dial_code": "+20", "code": "EG"},
      "El Salvador": {"dial_code": "+503", "code": "SV"},
      "Equatorial Guinea": {"dial_code": "+240", "code": "GQ"},
      "Eritrea": {"dial_code": "+291", "code": "ER"},
      "Estonia": {"dial_code": "+372", "code": "EE"},
      "Ethiopia": {"dial_code": "+251", "code": "ET"},
      "Falkland Islands (Malvinas)": {"dial_code": "+500", "code": "FK"},
      "Faroe Islands": {"dial_code": "+298", "code": "FO"},
      "Fiji": {"dial_code": "+679", "code": "FJ"},
      "Finland": {"dial_code": "+358", "code": "FI"},
      "France": {"dial_code": "+33", "code": "FR"},
      "French Guiana": {"dial_code": "+594", "code": "GF"},
      "French Polynesia": {"dial_code": "+689", "code": "PF"},
      "Gabon": {"dial_code": "+241", "code": "GA"},
      "Gambia": {"dial_code": "+220", "code": "GM"},
      "Georgia": {"dial_code": "+995", "code": "GE"},
      "Germany": {"dial_code": "+49", "code": "DE"},
      "Ghana": {"dial_code": "+233", "code": "GH"},
      "Gibraltar": {"dial_code": "+350", "code": "GI"},
      "Greece": {"dial_code": "+30", "code": "GR"},
      "Greenland": {"dial_code": "+299", "code": "GL"},
      "Grenada": {"dial_code": "+1473", "code": "GD"},
      "Guadeloupe": {"dial_code": "+590", "code": "GP"},
      "Guam": {"dial_code": "+1671", "code": "GU"},
      "Guatemala": {"dial_code": "+502", "code": "GT"},
      "Guernsey": {"dial_code": "+44", "code": "GG"},
      "Guinea": {"dial_code": "+224", "code": "GN"},
      "Guinea-Bissau": {"dial_code": "+245", "code": "GW"},
      "Guyana": {"dial_code": "+595", "code": "GY"},
      "Haiti": {"dial_code": "+509", "code": "HT"},
      "Holy See (Vatican City State)": {"dial_code": "+379", "code": "VA"},
      "Honduras": {"dial_code": "+504", "code": "HN"},
      "Hong Kong": {"dial_code": "+852", "code": "HK"},
      "Hungary": {"dial_code": "+36", "code": "HU"},
      "Iceland": {"dial_code": "+354", "code": "IS"},
      "India": {"dial_code": "+91", "code": "IN"},
      "Indonesia": {"dial_code": "+62", "code": "ID"},
      "Iran, Islamic Republic of Persian Gulf": {
        "dial_code": "+98",
        "code": "IR"
      },
      "Iraq": {"dial_code": "+964", "code": "IQ"},
      "Ireland": {"dial_code": "+353", "code": "IE"},
      "Isle of Man": {"dial_code": "+44", "code": "IM"},
      "Israel": {"dial_code": "+972", "code": "IL"},
      "Italy": {"dial_code": "+39", "code": "IT"},
      "United Kingdom": {"dial_code": "+44", "code": "GB"},
      "United States": {"dial_code": "+1", "code": "US"},
    });

    _countries = _countriesData.entries
        .map((entry) => CountryInfo.fromJson(entry.key, entry.value))
        .toList();

    // Sort countries alphabetically
    _countries.sort((a, b) => a.name.compareTo(b.name));
  }

  void _selectInitialCountry() {
    // Find the initial country in the list
    for (var country in _countries) {
      if (country.name == widget.initialCountry) {
        _selectedCountry = country;
        break;
      }
    }

    // Default to a country if the specified one isn't found
    _selectedCountry ??= _countries.firstWhere(
      (c) => c.name == 'Australia',
      orElse: () => _countries.first,
    );

    // Notify about the selected country
    if (widget.onCountryChanged != null) {
      widget.onCountryChanged!(_selectedCountry);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _showCountrySelectionSheet() async {
    CountryInfo? selectedCountry = _selectedCountry;
    List<CountryInfo> filteredCountries = List.from(_countries);

    await DLBaseBottomSheet.show(
      title: 'Select Country',
      showCloseButton: true,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  decoration: DLInputDecorationTheme.getDecoration(
                    hint: 'Search country',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    setState(() {
                      if (query.isEmpty) {
                        filteredCountries = List.from(_countries);
                      } else {
                        final lowercaseQuery = query.toLowerCase();
                        filteredCountries = _countries
                            .where((country) =>
                                country.name
                                    .toLowerCase()
                                    .contains(lowercaseQuery) ||
                                country.dialCode
                                    .toLowerCase()
                                    .contains(lowercaseQuery) ||
                                country.code
                                    .toLowerCase()
                                    .contains(lowercaseQuery))
                            .toList();
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = filteredCountries[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            country.flagUrl,
                            width: 30,
                            height: 20,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 30,
                                height: 20,
                                color: Colors.grey[300],
                                child: const Center(child: Text('🏳️')),
                              );
                            },
                          ),
                        ),
                        title: Text(country.name),
                        subtitle: Text(country.dialCode),
                        onTap: () {
                          selectedCountry = country;
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Update the selected country after the bottom sheet is closed
    if (selectedCountry != null && selectedCountry != _selectedCountry) {
      setState(() {
        _selectedCountry = selectedCountry;
      });
      if (widget.onCountryChanged != null) {
        widget.onCountryChanged!(selectedCountry);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 4),
            child: Row(
              children: [
                Text(
                  widget.label!,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country selection part
            GestureDetector(
              onTap: _showCountrySelectionSheet,
              child: Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.textFieldBorderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_selectedCountry != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          _selectedCountry!.flagUrl,
                          width: 24,
                          height: 16,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 24,
                              height: 16,
                              color: Colors.grey[300],
                              child: const Center(child: Text('🏳️')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _selectedCountry!.dialCode,
                        style: Get.textTheme.titleMedium,
                      ),
                    ],
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Phone number input
            Expanded(
              child: TextFormField(
                focusNode: _focusNode,
                controller: widget.controller,
                onChanged: widget.onChanged,
                onTapOutside: (_) => _focusNode.unfocus(),
                onFieldSubmitted: widget.onSubmitted,
                validator: widget.validator,
                readOnly: widget.readOnly,
                enabled: widget.enabled,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s-]')),
                ],
                textInputAction: TextInputAction.next,
                style: Get.textTheme.titleMedium,
                decoration: DLInputDecorationTheme.phoneNumberDecoration(
                  hint: widget.hint,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
          ],
        ),
      ],
    );
  }
}