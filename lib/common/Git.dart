import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/Global.dart';
import '../models/index.dart';

class Git {
  BuildContext context;
  Options options;

  Git([this.context]) {
    options = Options(extra: {"context": context});
  }

  static Dio dio =
      new Dio(BaseOptions(baseUrl: 'https://api.github.com/', headers: {
    HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
        "application/vnd.github.symmetra-preview+json",
  }));

  static void init() {
    //添加缓存插件
    dio.interceptors.add(Global.netCache);
    //设置用户token,为空代表未登陆
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    //在调试模式下需要抓包测试，所以我们使用代理，并禁用Https证书校验
/*    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 10.1.10.250:8888";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }*/
  }

  //登录接口，登录成功后返回用户信息
  Future<User> login(String login, String pwd) async {
    String basic = 'Basic ' + base64Encode(utf8.encode("$login:$pwd"));
    debugPrint(basic);
    var r = await dio.request("/user",
        options: options.merge(
          headers: {HttpHeaders.authorizationHeader: basic},
          /*extra: {"noCache": true}*/
        ));
    debugPrint("请求Uri:${r.request.uri.toString()}");
    debugPrint("请求Header:${r.request.headers}");
    debugPrint("请求结果:${r.data}");

    //登录成功后更新公共头，此后所有请求都会带上用户身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    Global.netCache.cache.clear();
    //更新profile中的token信息
    Global.profile.token = basic;
    return User.fromJson(r.data);
  }

  //获取用户项目列表
  Future<List<Repo>> getRepos(
      {Map<String, dynamic> queryParams, refresh = false}) async {
    if (refresh) {
      //列表下拉刷新，需要删除缓存（拦截器中会读写这些信息）
      options.extra.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get<List>("user/repos",
        queryParameters: queryParams,
        options: options.merge(
            headers: {HttpHeaders.authorizationHeader: Global.profile.token}));
    debugPrint("请求Uri:${r.request.uri.toString()}");
    debugPrint("请求Header:${r.request.headers}");
    debugPrint("请求结果:${r.data}");
    return r.data.map((value) => Repo.fromJson(value)).toList();
  }
}
