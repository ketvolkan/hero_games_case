import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'storage_key_enums.dart';
import 'storage_model.dart';

class CustomStorageService extends GetxService {
  static Box<dynamic>? _storage;

  @override
  void onInit() {
    _storage = Hive.box(StorageKeys.customStorage.name);
    super.onInit();
  }

  bool isExist(String key) {
    return (_storage?.get(key) != null);
  }

  void removeModel(StorageKeys key) {
    _storage?.delete(key.name);
  }

  R? readModel<R, T>({required StorageKeys key, required T parseModel}) {
    final cacheData = _storage?.get(key.name);
    if (cacheData == null) return null;
    final json = jsonDecode(cacheData);
    var cacheObject = StorageModel.fromJson<R, T>(json, parseModel);
    return cacheObject.data;
  }

  Future<void> writeModel(StorageKeys key, dynamic data) async {
    var registerModel = StorageModel(
      key: key.name,
      data: data,
    );
    final json = jsonEncode(registerModel);
    await _storage?.put(key.name, json);
  }

  Future<void> write(String key, dynamic value) async {
    await _storage?.put(key, value);
  }

  T? read<T>(String key) {
    return _storage?.get(key);
  }

  Future<void> remove(String key) async {
    return await _storage?.delete(key);
  }

  Future<void> cleanStorage() async {
    await _storage?.clear();
  }
}
