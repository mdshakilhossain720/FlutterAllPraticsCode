enum Enviroment { development, uat, production }

abstract class AppEnviroment {
  static late String baseUrl;
  static late String envirmentName;
  static late Enviroment _envirment;
  static Enviroment get envirment => _envirment;

  static void setEnvirment(Enviroment env) {
    _envirment = env;
    switch (env) {
      case Enviroment.development:
        baseUrl = "https://dev.api.example.com";
        envirmentName = "Development";
        break;
      case Enviroment.uat:
        baseUrl = "https://uat.api.example.com";
        envirmentName = "UAT";
        break;
      case Enviroment.production:
        baseUrl = "https://api.example.com";
        envirmentName = "Production";
        break;
    }
  }
}
