import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class AddDeviceCall {
  static Future<ApiCallResponse> call({
    String? apiKey = '',
    String? field1 = '',
    String? field2 = '',
    String? field3 = '',
    String? field4 = '',
    String? field5 = '',
    String? field6 = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'addDevice',
      apiUrl: 'https://api.thingspeak.com/update',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'api_key': apiKey,
        'field1': field1,
        'field2': field2,
        'field3': field3,
        'field4': field4,
        'field5': field5,
        'field6': field6 ?? field3,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
