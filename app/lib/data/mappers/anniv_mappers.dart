import 'package:fujii_photo_calendar/domain/entities/daily_anniversaries_entity.dart';

DailyAnniversariesEntity parseAnnivV3({
  required String mmdd,
  required Map<String, dynamic> json,
}) {
  final items = <String>[
    for (final k in ['anniv1', 'anniv2', 'anniv3', 'anniv4', 'anniv5'])
      if ((json[k] as String?)?.trim().isNotEmpty == true)
        (json[k] as String).trim(),
  ];
  return DailyAnniversariesEntity(mmdd: mmdd, items: items);
}
