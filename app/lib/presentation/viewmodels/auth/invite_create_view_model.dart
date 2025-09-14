import 'package:fujii_photo_calendar/domain/entities/invite_entity.dart';
import 'package:fujii_photo_calendar/domain/usecases/create_invite_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/data/services/auth_service.dart';

part 'invite_create_view_model.freezed.dart';
part 'invite_create_view_model.g.dart';

@freezed
class InviteCreateState with _$InviteCreateState {
  const factory InviteCreateState.idle() = _Idle;
  const factory InviteCreateState.creating() = _Creating;
  const factory InviteCreateState.error(String message) = _Error;
  const factory InviteCreateState.success(InviteEntity invite) = _Success;
}

@Riverpod(keepAlive: true)
class InviteCreateViewModel extends _$InviteCreateViewModel {
  @override
  InviteCreateState build() => const InviteCreateState.idle();

  Future<void> create({DateTime? expiresAt, int length = 20}) async {
    if (state is _Creating) return;
    state = const InviteCreateState.creating();
    try {
      final auth = ref.read(authServiceProvider);
      final user = auth.getCurrentUser();
      final isAnon = auth.isCurrentUserAnonymous();
      if (user == null || isAnon) {
        state = const InviteCreateState.error('ログイン中のユーザーのみ招待を作成できます');
        return;
      }
      final usecase = ref.read(createInviteUsecaseProvider);
      final inv = await usecase(
        ownerUid: user.userUid,
        expiresAt: expiresAt,
        length: length,
      );
      state = InviteCreateState.success(inv);
    } catch (e) {
      state = InviteCreateState.error(e.toString());
    }
  }

  void reset() => state = const InviteCreateState.idle();
}
