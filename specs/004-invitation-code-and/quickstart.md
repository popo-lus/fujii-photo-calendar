# クイックスタート: 招待 & アップロード機能

このガイドは、Firebase Emulator を用いてローカルで本機能を動かし、検証する手順を示します。

## 前提条件
- Flutter SDK がインストール済み
- Firebase CLI がインストール済み
- シードスクリプトを含むインフラ用リポジトリが利用可能

## 手順
1) Firebase Emulators を起動（インフラリポジトリ側）
2) 認証・招待・ストレージのシード投入
3) Flutter アプリを起動
4) 深リンクとアップロードの検証

## 詳細

### 1) エミュレータ起動
- インフラリポジトリで: `firebase emulators:start`

### 2) シード投入
- インフラリポジトリで:
  - `node app/scripts/seed-auth.js`
  - `node app/scripts/seed-invites.js`
  - `node app/scripts/seed-storage.js`

### 3) アプリ起動
- 本リポジトリで: `flutter run`

### 4) シナリオ検証
- 深リンク: 端末で `fujii://invite/ABC123` を開く → カレンダーが閲覧専用で表示される
- アップロード: アプリ内で写真を選択 → 当月に反映される
 
