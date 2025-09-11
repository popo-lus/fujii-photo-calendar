# Contract: Auth Service

## AuthService Interface (Logical)
| Method           | Params                        | Returns             | Errors                                 | Notes                            |
| ---------------- | ----------------------------- | ------------------- | -------------------------------------- | -------------------------------- |
| signIn           | email:String, password:String | Future<AuthResult>  | auth/invalid-credential, network-error |                                  |
| signOut          | -                             | Future<void>        | network-error                          | セッション失効                   |
| getCurrentUser   | -                             | AuthResult?         | -                                      | FirebaseAuth.currentUser wrapper |
| observeAuthState | -                             | Stream<AuthResult?> | -                                      | authStateChanges() delegate      |

<!-- 監査ログ保存はスコープ外のため AuditLogRepository および login_events コレクション定義を削除 -->

## Error Normalization
| Firebase Code                                        | UI Message (JP tentative)                        |
| ---------------------------------------------------- | ------------------------------------------------ |
| user-not-found / wrong-password / invalid-credential | メールアドレスまたはパスワードが正しくありません |
| network-request-failed                               | ネットワーク接続を確認してください               |
| too-many-requests                                    | しばらく待って再度お試しください                 |
| unknown                                              | 予期しないエラーが発生しました                   |

(Phase 1 / contracts END)
