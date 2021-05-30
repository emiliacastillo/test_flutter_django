//import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:test_flutter_python/data/api/api.dart';
import 'package:test_flutter_python/data/api/api_impl.dart';
import 'package:test_flutter_python/data/api/network/network_handler.dart';
import 'package:test_flutter_python/data/converter/converter.dart';
import 'package:test_flutter_python/data/converter/converter_impl.dart';
import 'package:test_flutter_python/data/dao/dao.dart';
import 'package:test_flutter_python/data/dao/dao_impl.dart';
import 'package:test_flutter_python/data/repository/repository.dart';
import 'package:test_flutter_python/data/repository/repository_impl.dart';
import 'package:test_flutter_python/ui/home/home_bloc.dart';
import 'package:test_flutter_python/ui/new_record/new_record_bloc.dart';
import 'package:test_flutter_python/ui/selectip/selectip_bloc.dart';
import 'package:test_flutter_python/ui/splash/splash_bloc.dart';
import 'package:test_flutter_python/utils/logger.dart';
import '../ui/_base/bloc_base.dart';

///Part dependency injector engine and Part service locator.
///The main purpose of [Injector] is to provide bloCs instances and initialize the app components depending the current scope.
///To reuse a bloc instance in the widget's tree feel free to use the [BlocProvider] mechanism.
class Injector {
  ///Singleton instance
  static Injector instance;

  kiwi.Container container = kiwi.Container();

  ///Is the app in debug mode?
  bool isInDebugMode() {
    var debugMode = false;
    assert(debugMode = true);
    return debugMode;
  }

  ///returns the current instance of the logger
  Logger getLogger() => container.resolve();

  ///returns a new bloc instance
  T getNewBloc<T extends BaseBloC>() => container.resolve();

  T getDependency<T>() => container.resolve();

  ///API base url
  String apiBaseUrl;

  static initDemo() {
    if (instance == null) {
      instance = Injector._startDemo();
    }
  }
//apiBaseUrl este es el ip del api si lo tengo ya definido http://ip:port
  static initProd({String apiBaseUrl=''}) {
    if (instance == null) {
    instance = Injector._startProd(apiBaseUrl: apiBaseUrl);
    }
  }

  Injector._startDemo() {
    _registerDemo();
    _initialize();
  }

  Injector._startProd({this.apiBaseUrl}) {
    if(instance!=null){
      
    }
    _registerProd(this.apiBaseUrl);
    _initialize();
  }

  _initialize() {
    _registerCommon();
    _registerBloCs();
    _registerMappers();
  }

  _registerDemo() {}

  _registerProd(String baseURL) {
    ///Network
    container.registerSingleton((c) => NetworkHandler(
          baseURL,
          c.resolve(),
          c.resolve(),
        ));

    ///Dao
    container.registerSingleton<Dao, DaoImpl>((c) => DaoImpl());

    ///Api
    container.registerSingleton<Api, ApiImpl>(
        (c) => ApiImpl(c.resolve(), c.resolve()));

    ///Repositories
    container.registerSingleton<Repository, RepositoryImpl>(
        (c) => RepositoryImpl(c.resolve(), c.resolve()));

    ///Sync Manager
/*     container.registerSingleton<SyncManager, SyncManagerImpl>(
        (c) => SyncManagerImpl(c.resolve()));*/
  }

  _registerMappers() {
    container
        .registerSingleton<ApiConverter, ConverterImpl>((c) => ConverterImpl());
  }

  _registerBloCs() {
    container.registerFactory((c) => SplashBloC(c.resolve()));
    container.registerFactory((c) => HomeBloC(
          c.resolve(),
        ));
    container.registerFactory((c) => NewRecordBloC(c.resolve()));
    container.registerFactory((c) => SelectIpdBloC(c.resolve()));
  }

  _registerCommon() {
    if (isInDebugMode()) {
      container.registerSingleton<Logger, LoggerImpl>((c) => LoggerImpl());
    } else {
      container.registerSingleton<Logger, LoggerEmptyImpl>(
        (c) => LoggerEmptyImpl(),
      );
    }
  }
}
