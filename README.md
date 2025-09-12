# fujii-photo-calendar

Flutter + Firebase の写真カレンダーアプリです。メール登録による通常利用と、招待コードによる匿名閲覧（読み取り専用）をサポートします。

## 機能概要
- 新規登録（Email/Password）: プロファイル（displayName）と users/{uid} ドキュメントを作成
- ログイン（Email/Password）
- 招待コードによる匿名閲覧: invites/{code} 検証 → guestSessions/{viewerUid} を作成し、共有アルバムを閲覧（編集不可）
- 月カレンダー表示、スライドショー

## 開発手順（Quickstart）
詳しくは Quickstart を参照してください。

- specs/003-features-registration/quickstart.md

