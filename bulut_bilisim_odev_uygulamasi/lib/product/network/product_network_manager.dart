class ProductNetworkManager {
  static ProductNetworkManager? _instance;
  static ProductNetworkManager get instance {
    _instance ??= ProductNetworkManager._init();
    return _instance!;
  }

  ProductNetworkManager._init();

  static const String _baseUrl = "http://coffee.veminsoft.com:5000/api";

  final loginUrl = Uri.parse("$_baseUrl/Login");

  final signupUrl = Uri.parse("$_baseUrl/User");

  //User URLS
  //---------

  final updateUserProfile = Uri.parse("$_baseUrl/User/UpdateUserInfo");

  Uri getUser(String id) => Uri.parse("$_baseUrl/User/$id");

  Uri getUserHomeStatistics(String id) =>
      Uri.parse("$_baseUrl/Statistic/GetStatistics/$id");

  //---------

  //Employee URLS
  //---------

  final employeLoginUrl = Uri.parse("$_baseUrl/EmployeeLogin");
  Uri getEmploye(String id) => Uri.parse("$_baseUrl/Employee/$id");

  //---------
  //Coffee System URLS
  //---------
  Uri getUserCoffeeSystem(String id) =>
      Uri.parse("$_baseUrl/CafeMainBuild/GetCafeMainBuild?userId=$id");
  //---------
}
