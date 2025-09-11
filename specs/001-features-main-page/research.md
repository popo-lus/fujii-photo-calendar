# Research: 月カレンダー閲覧（メインページ）

## Decisions
- Flutter + Firebase/Firestore を採用
- ルーティング: auto_route、DI/状態管理: flutter_riverpod
- データモデルは Firestore の実体に近い App Entity を freezed/json_serializable で定義
- 画像取得は cached_network_image を利用、オフラインはキャッシュ優先
- 撮影TZで月判定、EXIF不正は登録時弾くため表示時のフォールバック不要
- グリッド最大枚数はデバイスサイズから算出、超過時はランダム選択
- Admin写真は必ず最低1枚露出（ローテーション選出で保証）
- 取得責務の分割: fujii/user を Service・Repository で分離し、UseCase で統合

## Rationale
- Flutter はターゲット端末（タブレット/スマホ）へ横断デプロイが容易
- Firebase/Firestore は BaaS として実装速度が速く、スモールスタートに適合
- auto_route と Riverpod は保守性高く、画面遷移とDIをシンプルに保てる
- freezed/json_serializable により型安全とシリアライズ整合性を担保
- cached_network_image のキャッシュによりオフライン要件と初期描画の速さを確保
- 分割理由: 権限制御（Admin 専用更新/閲覧ルール）やキャッシュ/再試行ポリシーを系列ごとに独立調整可能にし、将来的な機能拡張（例: fujii 側の審査フラグ、ユーザー側のアップロード制限）を局所変更で実現するため

## Alternatives Considered
- Supabase/PostgreSQL: 迅速だがBaaS統合（Push/Storage/Rules）でFirebase優位
- GetX/Bloc: 学習/運用コストとチーム嗜好からRiverpodを優先
- 独自HTTP+自前API: 初期要件はFirestoreのドキュメントで十分

## Open Questions (resolved)
- スライドショー仕様 → specの成功基準にて数値確定（5s±0.5s, 300ms fade）
- ロール別表示 → ビュー差分は本Issueでは高レベル要件に留め、詳細は別Issueで深掘り
