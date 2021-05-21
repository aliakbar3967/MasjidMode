class Settings {
  // final bool isForgroundServiceOn;
  // final bool isTaskOn;
  bool forgroundServiceStatus = false;
  bool isDoNotDisturbPermissionStatus = false;
  bool introductionScreenStatus = false;
  bool darkMode = false;

  Settings(
      {this.forgroundServiceStatus,
      this.isDoNotDisturbPermissionStatus,
      this.introductionScreenStatus,
      this.darkMode});
}
