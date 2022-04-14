import 'dart:convert';
import 'package:flustars/flustars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Request {
  // 通过获取缓存判断是否物理设备 切换访问的mock url
  static final bool _isPhysical = SpUtil.getBool("isPhysical", defValue: false)!;
  // 以下mock为个人本地搭建 可自行使用apifox或apipost等工具进行自定义配置
  static String baseUrl = _isPhysical ? 'http://192.168.2.115:4523/mock/829140' : 'http://127.0.0.1:4523/mock/829140';

  // 配置 Dio 实例
  static final BaseOptions _options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000,
  );
  // 创建 Dio 实例
  static final Dio _dio = Dio(_options);

  // 所有的请求都会走_request
  static Future<T> _request<T>(String path, {String? method, Map? params, data}) async {

    // restful 请求处理
    if (params != null) {
      params.forEach((key, value) {
        if (path.contains(key)) {
          path = path.replaceAll(":$key", value.toString());
        }
      });
    }
    print('接口路径为：$path');
    if (method == 'get') print('发送的params为： $params');
    if (method == 'post') print('发送的data为： $data, 发送的params为： $params');
    try {
      Response response = await _dio.request(path,
          data: data, options: Options(method: method));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('response: ${response.data}');
        try {
          if (response.data['code'] != 200) {
            print('服务端错误码为${response.data['code']}, 错误信息为：${response.data['message']}');
            EasyLoading.showInfo('${response.data['message']}');
            return response.data;
          } else {
            LogUtil.v(response.data, tag: '响应的数据为：');
            if (response.data is Map) {
              return response.data;
            } else {
              return json.decode(response.data.toString());
            }
          }
        } catch (e) {
          LogUtil.v(e, tag: '解析响应数据异常');
          return Future.error('解析响应数据异常');
        }
      } else {
        LogUtil.v(response.statusCode, tag: 'HTTP错误，状态码为：');
        EasyLoading.showInfo('HTTP错误，状态码为：${response.statusCode}');
        _handleHttpError(response.statusCode!);
        return Future.error('HTTP错误');
      }
    } on DioError catch (e, s) {
      LogUtil.v(_dioError(e), tag: '请求异常');
      EasyLoading.showInfo(_dioError(e));
      return Future.error(_dioError(e));
    } catch (e, s) {
      LogUtil.v(e, tag: '未知异常');
      return Future.error('未知异常');
    }
  }

  // 处理 Dio 异常
  static String _dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.receiveTimeout:
        return "服务器异常，请稍后重试！";
      case DioErrorType.sendTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.response:
        return "服务器异常，请稍后重试！";
      case DioErrorType.cancel:
        return "请求已被取消，请重新请求";
      default:
        return "Dio异常";
    }
  }

  // 处理 Http 错误码
  static void _handleHttpError(int errorCode) {
    String message;
    switch (errorCode) {
      case 400:
        message = '请求语法错误';
        break;
      case 401:
        message = '未授权，请登录';
        break;
      case 403:
        message = '拒绝访问';
        break;
      case 404:
        message = '请求出错';
        break;
      case 408:
        message = '请求超时';
        break;
      case 500:
        message = '服务器异常';
        break;
      case 501:
        message = '服务未实现';
        break;
      case 502:
        message = '网关错误';
        break;
      case 503:
        message = '服务不可用';
        break;
      case 504:
        message = '网关超时';
        break;
      case 505:
        message = 'HTTP版本不受支持';
        break;
      default:
        message = '请求失败，错误码：$errorCode';
    }
    EasyLoading.showError(message);
  }

  static Future<T> get<T>(String path, {Map? params}) {
    return _request(path, method: 'get', params: params);
  }

  static Future<T> post<T>(String path, {Map? params, data}) {
    return _request(path, method: 'post', params: params, data: data);
  }

}
