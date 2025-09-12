# Quickstart: 登録＆匿名閲覧（Flutter + Firebase）

## 前提
- Flutter 環境セットアップ済み
- Firebase Emulator Suite 稼働
- invites 設計は `specs/003-features-registration/contracts/invites.md` に準拠

## 手順
1) エミュレータ起動＆シード
- 別リポジトリ `fujii-photo-calendar-infra/app` の README 手順に従い、以下を実行
  - `npm run seed:auth`
  - `npm run seed:storage`
  - `npm run seed:invites`

2) アプリ側（開発起動）
- Flutter アプリを起動
- 画面: LoginPage → 「新規登録」ボタン → RegisterPage で 名前/メール/パスワード を入力し作成
- 成功後の遷移: MonthCalendarRoute（自分のアルバム）

3) 匿名閲覧（ゲスト）
- 画面: LoginPage → 「招待コードで閲覧」ボタン → InviteCodePage で 招待コード を入力（例: ABC123）
- サインイン: Firebase Auth 匿名サインイン → invites/{code} を get で検証
- 成功後の遷移: MonthCalendarRoute（共有アルバム／閲覧モード表示、編集不可）

## 失敗時のメッセージ例
- 新規登録:
  - 重複メール: 「このメールアドレスは既に使用されています」
  - パスワード弱い: 「パスワードが短すぎます（8文字以上）」
- 招待コード閲覧:
  - 無効コード: 「無効な招待コードです」
  - 期限切れ: 「招待の有効期限が切れています」
  - 無効化（disabled）: 「この招待は無効です」

## 確認ポイント
- 登録: 重複メールは上書き不可、エラーメッセージが日本語で表示
- 匿名: 無効コードは拒否、有効コードは閲覧可能（遷移は MonthCalendarRoute）
- 権限: 匿名は編集不可（鍵アイコン表示）、登録ユーザーのみ編集可
