class RemoteEndpoints {
  static const String _baseUrl = 'https://app.automatedfishfarm.com';

  static Uri get authentication => Uri.parse('$_baseUrl/token');
  static Uri get devices => Uri.parse('$_baseUrl/GetAllDevice');
  static Uri get users => Uri.parse('$_baseUrl/Users/GetAllUsers');
  static Uri get toggleStatus => Uri.parse('$_baseUrl/SwitchOnOFF');
  static Uri get toggleScheduler => Uri.parse('$_baseUrl/UseSchedule');
  static Uri get relayTemperature => Uri.parse('$_baseUrl/ChangeTempLimit');
  static Uri get schedules => Uri.parse('$_baseUrl/GetRelaySchedules');
  static Uri get upsertSchedule => Uri.parse('$_baseUrl/UpdateOrInsertRelaySchedule');
  static Uri get deleteSchedule => Uri.parse('$_baseUrl/DeleteRelaySchedule');
  static Uri get connectionMode => Uri.parse('$_baseUrl/ChangeConnectionMode');
}
