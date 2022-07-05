class Settings {
  // final bool isForgroundServiceOn;
  // final bool isTaskOn;
  bool isDoNotDisturbPermissionStatus = false;
  bool introductionScreenStatus = false;
  bool darkMode = false;

  Settings(
      {
      required this.isDoNotDisturbPermissionStatus,
      required this.introductionScreenStatus,
      required this.darkMode});
}
