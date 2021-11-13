import 'package:flutter_spacex/network/api.dart';
import 'package:flutter_spacex/network/storage.dart';
import 'api.dart';
import 'models.dart';

class Repository {
  final SpaceXApi _spaceXApi = SpaceXApi();

  List<LaunchModel>? launchesData;

  final Cache _cache = Cache();
  final Storage _storage = Storage();
  Observable<String> favoritesObservable = Observable<String>();

  Future<bool> starLaunch(String launchId, bool value) async {
    await _storage.setStarred(launchId, value);
    favoritesObservable.emit(launchId);
    return _storage.isStarred(launchId);
  }

  Future<bool> isLaunchStarred(String launchId) async {
    return _storage.isStarred(launchId);
  }

  Future<void> refreshLaunchesData() async {
    launchesData = null;
    _cache.flush();

    launchesData = await _getLaunches();
    launchesData?.sort((item1, item2) {
      final item1Time = DateTime.parse(item1.utcDate);
      final item2Time = DateTime.parse(item2.utcDate);

      final item1TimeDiffWithNow = item1Time.difference(DateTime.now());
      final item2TimeDiffWithNow = item2Time.difference(DateTime.now());

      if (!item1TimeDiffWithNow.isNegative &&
          !item2TimeDiffWithNow.isNegative) {
        return -item2Time.compareTo(item1Time);
      } else if (item1TimeDiffWithNow.isNegative &&
          item2TimeDiffWithNow.isNegative) {
        return item2Time.compareTo(item1Time);
      } else if (item1TimeDiffWithNow.isNegative) {
        return 1;
      } else {
        return -1;
      }
    });
  }

  Future<LaunchModel> getDetailedDataForLaunch(String launchId) async {
    if (_cache.isCached<LaunchModel>(launchId)) {
      return _cache.get<LaunchModel>(launchId);
    }
    return _cache.save<LaunchModel>(launchId, _getLaunchData(launchId));
  }

  Future<RocketModel?> getRocketForLaunch(LaunchModel launch) async {
    final itemId = launch.rocketId;
    if (itemId == null) return null;
    if (_cache.isCached<RocketModel>(itemId)) {
      return _cache.get<RocketModel>(itemId);
    }
    return _cache.save<RocketModel>(itemId, _getRocketData(itemId));
  }

  Future<LaunchpadModel?> getLaunchpadForLaunch(LaunchModel launch) async {
    final itemId = launch.launchpadId;
    if (itemId == null) return null;
    if (_cache.isCached<LaunchpadModel>(itemId)) {
      return _cache.get<LaunchpadModel>(itemId);
    }
    return _cache.save<LaunchpadModel>(itemId, _getLaunchpadData(itemId));
  }

  Future<List<PayloadModel>> getPayloadsForLaunch(LaunchModel launch) async {
    return Future.wait(launch.payloads.map((itemId) {
      if (_cache.isCached<PayloadModel>(itemId)) {
        return _cache.get<PayloadModel>(itemId);
      }
      return _cache.save<PayloadModel>(itemId, _getPayloadData(itemId));
    }));
  }

  Future<List<LaunchModel>> _getLaunches() async {
    final launchesResponse = await _spaceXApi.requestUpcomingLaunches();

    return launchesResponse
        .map((element) => LaunchModel.fromJson(element))
        .toList();
  }

  Future<LaunchModel> _getLaunchData(String id) async =>
      LaunchModel.fromJson(await _spaceXApi.requestLaunchDetails(id));

  Future<RocketModel> _getRocketData(String id) async =>
      RocketModel.fromJson(await _spaceXApi.requestRocketData(id));

  Future<LaunchpadModel> _getLaunchpadData(String id) async =>
      LaunchpadModel.fromJson(await _spaceXApi.requestLaunchpadData(id));

  Future<PayloadModel> _getPayloadData(String id) async =>
      PayloadModel.fromJson(await _spaceXApi.requestPayloadData(id));
}

class Cache {
  Map<Type, Map<String, dynamic>> store = {};

  void flush() {
    store = {};
  }

  Future<T> save<T>(String id, Future<T> item) async {
    if (store[T] == null) store[T] = {};
    store[T]![id] = await item;
    return item;
  }

  bool isCached<T>(String id) => store[T]?.containsKey(id) ?? false;

  Future<T> get<T>(String id) async => store[T]![id]!;
}

class Observable<T> {
  final List<void Function(T)> _subscribers = [];

  void Function() subscribe(void Function(T) listener) {
    _subscribers.add(listener);
    return (() => _subscribers.remove(listener));
  }

  void emit(T item) {
    for (var element in _subscribers) {
      element(item);
    }
  }
}
