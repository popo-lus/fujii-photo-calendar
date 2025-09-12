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
- ログイン画面から「新規登録」→ 名前・メール・パスワードで作成
- 成功後、ホーム（自身のアルバム）へ

3) 匿名閲覧（ゲスト）
- ログイン画面の「招待コードで閲覧」からコード入力（例: ABC123）
- 匿名サインイン（Firebase Auth）
- invites ルールに合致すれば、共有アルバムが閲覧可能

## 確認ポイント
- 登録: 重複メールは上書き不可、エラーメッセージが日本語で表示
- 匿名: 無効コードは拒否、有効コードは閲覧可能
- 権限: 匿名は編集不可、登録ユーザーのみ編集可
