import 'dart:convert';

import 'package:fujii_photo_calendar/domain/entities/daily_anniversaries_entity.dart';
import 'package:fujii_photo_calendar/data/mappers/anniv_mappers.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'anniv_api_service.g.dart';

class AnnivApiService {
  AnnivApiService({http.Client? client, this.baseUrl, this.baseVersion = 'v3'})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String? baseUrl;
  final String baseVersion; // 'v3' | 'v2'

  String get _base => baseUrl ?? 'https://api.whatistoday.cyou';

  Future<DailyAnniversariesEntity> getAnnivV3(String mmdd) async {
    final uri = Uri.parse('$_base/v3/anniv/$mmdd');
    final resp = await _client.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Anniv API error: ${resp.statusCode}');
    }
    final map = jsonDecode(resp.body) as Map<String, dynamic>;
    return parseAnnivV3(mmdd: mmdd, json: map);
  }

  Future<DailyAnniversariesEntity> getAnniv(String mmdd) {
    if (baseVersion == 'v3') return getAnnivV3(mmdd);
    // v2 fallback (currently same as v3 path/shape would differ in future)
    return getAnnivV3(mmdd);
  }
}

@Riverpod(keepAlive: true)
AnnivApiService annivApiService(Ref ref) => AnnivApiService();
