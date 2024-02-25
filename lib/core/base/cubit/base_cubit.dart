import 'package:favorite_books_app/core/cache/local_database_manager.dart';
import 'package:favorite_books_app/core/init/app_state/app_state.dart';
import 'package:favorite_books_app/core/init/navigation/navigation_service.dart';
import 'package:favorite_books_app/core/init/network/dio_manager.dart';
import 'package:flutter/material.dart';

 mixin BaseCubit {
  BuildContext? context;

  DioManager dioManager = DioManager.instance;
  NavigationService navigation = NavigationService.instance;
  AppStateManager appStateManager = AppStateManager.instance;
  LocalDatabaseManager localDatabaseManager = LocalDatabaseManager.instance;
  void setContext(BuildContext context);
  void init();
}
