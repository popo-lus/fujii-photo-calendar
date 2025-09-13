# Quickstart: Validate Month Calendar Page

## Preconditions
- Flutter env ready (fvm configured)
- Firebase project configured; Firestore Emulator available

## Steps
1) 起動 → 月カレンダーが1s以内に描画（p95基準の目視代替）
2) 背景に最初の写真が2s以内（オンライン）/1s以内（オフライン=キャッシュ）で表示
3) 右スワイプで前月、左スワイプで翌月（アニメ開始≤50ms、所要250–350ms）
4) スライドショー: 5.0s±0.5sで切替、クロスフェード300ms、黒フラッシュなし
5) Admin写真がある月で10s以内に少なくとも1枚露出
6) 撮影実績が無い月でプレースホルダーが2s以内に表示
7) （被撮影者アカウントで）ページ上の「写真を追加」から端末写真を1枚選択してアップロード→ 完了後、当該月の背景グリッドに即時反映されることを確認（失敗時は理由表示と再試行が可能）。閲覧者（招待コード経由）では当ボタンが表示されないことを確認。

## Notes
- 実測はロギング/メトリクスで検証、ここでは目視で暫定確認
