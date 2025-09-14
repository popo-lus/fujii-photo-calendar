import 'package:fujii_photo_calendar/core/utils/invite_code_generator.dart';
import 'package:fujii_photo_calendar/data/services/invite_service.dart';
import 'package:fujii_photo_calendar/domain/entities/invite_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/invite_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'invite_repository_impl.g.dart';

class InviteRepositoryImpl implements InviteRepository {
  InviteRepositoryImpl(this._service);
  final InviteService _service;

  @override
  Future<InviteEntity> create({
    required String ownerUid,
    DateTime? expiresAt,
    int length = 20,
    int maxRetry = 1,
  }) async {
    // Firestore ルールの都合で invites の get が許可されない環境があるため、
    // 衝突確認は行わず、十分に長いコードを一度で発行する。
    final code = generateInviteCode(length: length);
    await _service.put(
      code: code,
      ownerUid: ownerUid,
      disabled: false,
      expiresAt: expiresAt,
    );
    return InviteEntity(
      code: code,
      ownerUid: ownerUid,
      disabled: false,
      expiresAt: expiresAt,
      createdAt: null,
    );
  }

  @override
  Future<InviteEntity?> getByCode(String code) async {
    final json = await _service.getJson(code);
    if (json == null) return null;
    return InviteEntity(
      code: code,
      ownerUid: (json['ownerUid'] as String?) ?? '',
      disabled: (json['disabled'] as bool?) ?? false,
      expiresAt: (json['expiresAt'] is Timestamp)
          ? (json['expiresAt'] as Timestamp).toDate()
          : null,
      createdAt: (json['createdAt'] is Timestamp)
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  @override
  Future<void> disable(String code) => _service.updateDisabled(code, true);
}

@Riverpod(keepAlive: true)
InviteRepository inviteRepository(Ref ref) {
  final service = ref.watch(inviteServiceProvider);
  return InviteRepositoryImpl(service);
}
