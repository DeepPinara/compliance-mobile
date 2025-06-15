enum LoadingState {
  initial,
  loading,
  loaded,
  error,
}

enum AuthStatus {
  signedOut,
  signedIn,
  loading,
}

enum ThemeMode {
  light,
  dark,
  system,
}

enum MinWageZone {
  zone1,
  zone2,
  zone3,
  central;

  String get value {
    switch (this) {
      case MinWageZone.zone1:
        return 'Zone 1';
      case MinWageZone.zone2:
        return 'Zone 2';
      case MinWageZone.zone3:
        return 'Zone 3';
      case MinWageZone.central:
        return 'Central';
    }
  }
}

enum Selectmodule {
  compliance,
  tracker,
}

enum TrackerApplicationType {
  bocw,
  clraNew,
  clraRenewal,
  clraAmendment,
}

// extension TrackerApplicationTypeExtension
extension TrackerApplicationTypeExtension on TrackerApplicationType {
  String get displayName {
    switch (this) {
      case TrackerApplicationType.bocw:
        return 'BOCW';
      case TrackerApplicationType.clraNew:
        return 'CLRA New';
      case TrackerApplicationType.clraRenewal:
        return 'CLRA Renewal';
      case TrackerApplicationType.clraAmendment:
        return 'CLRA Amendment';
    }
  }
}
