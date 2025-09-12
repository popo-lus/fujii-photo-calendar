# Contract: UserRepository / UserService

本契約はクライアント（Flutter/Dart）側のドメイン層の取得・更新インターフェースを示します。実装は Firebase Auth と Firestore を統合します。

## Entity
```ts
// pseudo
class User {
  final String uid;
  final String email;
  final String displayName;
  final String status; // 'active' | 'disabled' | 'pending'
}
```

## Repository
```ts
abstract class UserRepository {
  // 現在のユーザー（サインインしていない場合は null）を購読
  Stream<User?> watchCurrent();

  // 1回だけ現在のユーザーを取得
  Future<User?> getCurrentOnce();

  // 表示名の更新（Auth と Firestore を一貫更新）
  Future<void> updateDisplayName(String displayName);
}
```

実装要点
- Auth の `authStateChanges()` と Firestore の `users/{uid}` を combineLatest して User を構築
- Firestore ドキュメントが未作成の場合は登録時に作成（contracts/auth.md 準拠）
- `updateDisplayName` は
  - `firebase_auth.currentUser.updateDisplayName(...)`
  - Firestore `users/{uid}.displayName` も更新

## Service（任意の薄いファサード）
```ts
abstract class UserService {
  Stream<User?> watchCurrent();
  Future<void> updateDisplayName(String displayName);
}
```

- 画面は基本的に Service を介して利用
- 例外・エラーハンドリング（オフライン/権限）を UI に伝播できる形に整える

## 非機能
- キャッシュ: リスナーは ViewModel で保持。永続ストア（SharedPreferences 等）には保存しない。
- ログアウト時クリア: Firebase Auth のサインアウトイベントに追従して自動クリア。
