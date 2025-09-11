# Quickstart: 親ユーザーログイン機能

## 前提
- Firebase Emulator Suite 起動済 (auth)
- `seed-auth.js` 実行済でテストユーザー存在
- FlutterFire 初期化済 (`Firebase.initializeApp()`)

## 手順 (手動確認)
1. アプリ起動 → ログイン画面表示
2. `client1@example.com` / `password` 入力 → ログイン → カレンダー初期画面表示
3. アプリ再起動 → そのままカレンダー表示 (再ログイン不要)
4. ログアウトボタン → ログイン画面に戻る
5. 不正資格情報 `client1@example.com` / `wrong` → エラーメッセージ (一般化) 表示
6. （監査ログ記録は本スコープ外のため確認不要）

## 自動テスト観点
- 成功: signIn 後 currentUser != null
- 失敗: エラーコード正規化メッセージ一致
- セッション維持: 再起動シミュレーション後 currentUser 存在
<!-- 監査ログ確認不要 -->

(Phase 1 / quickstart END)
