library simp_api;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'src/http_exception.dart';

enum RequestType { GET, PUT, POST, DELETE }

enum FilesRequestType { PUT, PATCH }

class SimpApi {
  SimpApi._internal();
  static final SimpApi instance = SimpApi._internal();

  final Map<String, String> _header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*',
  };

  Future<http.StreamedResponse?> uploadImage({
    required FilesRequestType filesRequestType,
    required String url,
    required File imageFile,
    Map<String, String>? header,
  }) async {
    final requestUrl = Uri.parse(url);
    var requestHeader = header;

    requestHeader ??= _header;

    try {
      final type = filesRequestType == FilesRequestType.PUT ? 'PUT' : 'PATCH';

      //create multipart request for POST or PATCH method
      final request = http.MultipartRequest(type, requestUrl);

      //create multipart using filepath, string or bytes
      final pic = await http.MultipartFile.fromPath("file", imageFile.path);

      //add headers
      request.headers.addAll(requestHeader);

      //add multipart to request
      request.files.add(pic);
      final response = await request.send();

      return response;
    } on UnauthorisedException {
      throw UnauthorisedException('Check the requested URL');
    } on SocketException {
      throw FetchDataException('Check your internet connection or a typo in $url');
    } catch (error) {
      debugPrint('EasyApi error @ $url : $error');
    }
    return null;
  }

  Future<http.StreamedResponse?> uploadFiles({
    required FilesRequestType filesRequestType,
    required String url,
    required List<File> files,
    Map<String, String>? header,
  }) async {
    final requestUrl = Uri.parse(url);
    var requestHeader = header;

    requestHeader ??= _header;

    try {
      final type = filesRequestType == FilesRequestType.PUT ? 'PUT' : 'PATCH';

      //create multipart request for POST or PATCH method
      final request = http.MultipartRequest(type, requestUrl);

      //create multipart using filepath, string or bytes
      final List<http.MultipartFile> mFiles = [];

      for (var doc in files) {
        final file = await http.MultipartFile.fromPath('files', doc.path);
        mFiles.add(file);
      }

      //add headers
      request.headers.addAll(requestHeader);

      mFiles.forEach((element) {
        request.files.add(element);
      });

      final response = await request.send();

      return response;
    } on UnauthorisedException {
      throw UnauthorisedException('Check the requested URL');
    } on SocketException {
      throw FetchDataException('Check your internet connection or a typo in $url');
    } catch (error) {
      debugPrint('EasyApi error @ $url : $error');
    }
    return null;
  }

  Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String url,
    Map<String, String>? header,
    Map<String, dynamic>? body,
  }) async {
    final requestUrl = Uri.parse(url);
    var requestHeader = header;

    requestHeader ??= _header;

    try {
      final http.Response? response = await _createRequest(
        requestType: requestType,
        url: requestUrl,
        body: body,
        headers: requestHeader,
      );

      return response;
    } catch (error) {
      debugPrint('EasyApi error @ $requestUrl : $error');
      return null;
    }
  }


  /// ------------------- \\\

  Future<http.Response?>? _createRequest({
    required RequestType requestType,
    required Uri url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    switch (requestType) {
      case RequestType.GET:
        return _get(url, headers);
      case RequestType.PUT:
        return _put(url, body, headers);
      case RequestType.POST:
        return _post(url, body, headers);
      case RequestType.DELETE:
        return _delete(url, body, headers);
    }
  }

  Future<http.Response?>? _get(Uri url, Map<String, String>? header) async {
    http.Response? responseJson;
    try {
      responseJson = await http.get(url, headers: header);
    } on UnauthorisedException {
      throw UnauthorisedException('Check the requested URL');
    } on SocketException {
      throw FetchDataException('Check your internet connection or a typo in $url');
    } catch (error) {
      debugPrint('EasyApi error @ $url : $error');
    }
    return responseJson ?? http.Response('', 500);
  }

  Future<http.Response?>? _post(Uri url, Map<String, dynamic>? payload, Map<String, String>? header) async {
    http.Response? responseJson;

    try {
      responseJson = await http.post(
        url,
        headers: header,
        body: jsonEncode(payload),
      );
    } on UnauthorisedException {
      throw UnauthorisedException('Check the requested URL');
    } on SocketException {
      throw FetchDataException('Check your internet connection or a typo in $url');
    } catch (error) {
      debugPrint('EasyApi error @ $url : $error');
    }
    return responseJson ?? http.Response('', 500);
  }

  Future<http.Response?>? _put(Uri url, Map<String, dynamic>? payload, Map<String, String>? header) async {
    http.Response? responseJson;
    try {
      responseJson = await http.put(
        url,
        headers: header,
        body: jsonEncode(payload),
      );
    } on UnauthorisedException {
      throw UnauthorisedException('Check the requested URL');
    } on SocketException {
      throw FetchDataException('Check your internet connection or a typo in $url');
    } catch (error) {
      debugPrint('EasyApi error @ $url : $error');
    }
    return responseJson ?? http.Response('', 500);
  }

  Future<http.Response?>? _delete(Uri url, Map<String, dynamic>? payload, Map<String, String>? header) async {
    http.Response? responseJson;
    try {
      responseJson =
      await http.delete(url, headers: header, body: jsonEncode(payload));
    } on UnauthorisedException {
      throw UnauthorisedException('Check the requested URL');
    } on SocketException {
      throw FetchDataException('Check your internet connection or a typo in $url');
    } catch (error) {
      debugPrint('EasyApi error @ $url : $error');
    }
    return responseJson ?? http.Response('', 500);
  }
}
