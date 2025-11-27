import 'package:cleanarchitectureflutter/flaver_config.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnviroment.setEnvirment(Enviroment.uat);
  main();
  
}