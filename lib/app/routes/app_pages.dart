// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:dices/app/modules/helper/bindings/helper_binding.dart';
import 'package:dices/app/modules/helper/views/helper_view.dart';
import 'package:get/get.dart'; 
 
import '../modules/dices/bindings/dices_binding.dart'; 
import '../modules/dices/views/dices_view.dart'; 
import '../modules/home/bindings/home_binding.dart'; 
import '../modules/home/views/home_view.dart'; 
 
part 'app_routes.dart'; 
 
 class AppPages {
  AppPages._(); 
 
  static const INITIAL = Routes.DICES; 
 
  static final routes = [ 
    GetPage( 
      name: _Paths.HOME, 
      page: () => HomeView(), 
      binding: HomeBinding(), 
      transition: null, 
    ), 
    GetPage( 
      name: _Paths.DICES, 
      page: () => DicesView(), 
      binding: DicesBinding(), 
      transition: null, 
    ), 
    GetPage( 
      name: _Paths.HELPER, 
      page: () => HelperView(), 
      binding: HelperBinding(), 
      transition: null, 
    ), 
  ];
}
