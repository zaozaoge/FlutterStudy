import 'dart:async';

import 'package:dio/dio.dart';
import 'dart:collection';
import '../common/Global.dart';

class CacheObject {
  Response response;
  int timeStamp;

  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  //确保迭代器顺序和插入的顺序一致，使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  onRequest(RequestOptions options) {
    if (!Global.profile.cache.enable) {
      return options;
    }
    print("请求完成");
    print(options.data.toString());
    bool refresh = options.extra["refresh"] == true;
    //如果是下拉刷新，先删除相关缓存
    if (refresh) {
      if (options.extra["list"] == true) {
        //如果是列表，则只要url中包含当前path的缓存全部删除
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        //如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }
      return options;
    }
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          //若缓存已经过期，则删除缓存继续向服务器请求
          cache.remove(key);
        }
      }
    }
  }

  @override
  FutureOr onError(DioError err) {
    //错误状态不缓存
    return super.onError(err);
  }

  @override
  FutureOr onResponse(Response response) {
    //如果启用缓存则将结果保存到缓存
    if (Global.profile.cache.enable) {
      _saveCache(response);
    }
    return super.onResponse(response);
  }

  void delete(String key) {
    cache.remove(key);
  }

  void _saveCache(Response response) {
    RequestOptions options = response.request;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      //如果缓存数量超过最大的限制，则移除最早的一条记录
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(response);
    }
  }
}
