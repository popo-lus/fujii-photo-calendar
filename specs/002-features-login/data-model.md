# Data Model: 親ユーザーログイン機能

## Entities
### AuthResult (Parent)
| Field       | Type      | Required | Notes                  |
| ----------- | --------- | -------- | ---------------------- |
| email       | string    | yes      | Unique (Firebase Auth) |
| displayName | string    | yes      | 表示用                 |
| lastLoginAt | Timestamp | no       | ログイン成功時更新     |

<!-- 独立した Session エンティティは保持せず、FirebaseAuth.currentUser の存在と資格情報失効イベントで状態管理 -->

<!-- LoginEvent エンティティは監査ログ不要方針のため削除 -->

## Validation Rules
- email: 正規表現軽量チェック + Firebase Auth エラー補完
- password: length >= 6, 非空

## State Transitions (Simplified)
```
Unauthenticated --signIn(valid)--> Authenticated
Unauthenticated --signIn(invalid)--> Unauthenticated
Authenticated --token refresh (implicit)--> Authenticated
Authenticated --signOut / credential invalidated --> Unauthenticated
```

## Derived / Computed
- lastLoginAt = now() after successful signIn
<!-- emailHash (failure) は監査ログ削除により不要 -->

## Open Items
- ログイン試行失敗閾値関連: スコープ外

(Phase 1 / data-model END)
