import 'package:fujii_photo_calendar/data/mappers/request_mappers.dart';
import 'package:fujii_photo_calendar/data/services/requests_service.dart';
import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/data/services/auth_service.dart';
import 'package:fujii_photo_calendar/domain/entities/request_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/request_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_repository_impl.g.dart';

class RequestRepositoryImpl implements RequestRepository {
  RequestRepositoryImpl(this._service, this._auth);
  final RequestsService _service;
  final AuthService _auth;

  @override
  Future<void> submit({
    required String ownerUid,
    required String comment,
  }) async {
    final viewer = _auth.getCurrentUser();
    final requesterUid = viewer?.userUid;
    if (requesterUid == null || requesterUid.isEmpty) {
      throw const AuthDomainException(
        code: 'not-authenticated',
        message: 'ログインが必要です',
      );
    }
    await _service.addRequest(
      ownerUid: ownerUid,
      json: {'requesterUid': requesterUid, 'comment': comment},
    );
  }

  @override
  Stream<List<RequestEntity>> watchRecent({
    required String ownerUid,
    int retentionDays = 14,
  }) {
    return _service
        .watchRecent(ownerUid: ownerUid, retentionDays: retentionDays)
        .map(
          (list) => list
              .map(
                (json) => mapJsonToRequestEntity(
                  (json['id'] as String?) ?? '',
                  ownerUid,
                  json,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<void> delete({required String ownerUid, required String requestId}) {
    return _service.delete(ownerUid: ownerUid, requestId: requestId);
  }
}

@Riverpod(keepAlive: true)
RequestRepository requestRepository(Ref ref) {
  final service = ref.watch(requestsServiceProvider);
  final auth = ref.watch(authServiceProvider);
  return RequestRepositoryImpl(service, auth);
}

// 最近のリクエストを監視（14日）
@Riverpod(keepAlive: true)
Stream<List<RequestEntity>> recentRequestsStream(Ref ref, String ownerUid) {
  final repo = ref.watch(requestRepositoryProvider);
  return repo.watchRecent(ownerUid: ownerUid, retentionDays: 14);
}
