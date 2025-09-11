# Data Model: 月カレンダー閲覧（メインページ）

## Entities

### PhotoEntity (App 内部正規化モデル)
- id: string (FirestoreドキュメントID=ファイル名)
- type: enum('fujii-photos','user-photos')  # Firestore `type` をそのまま利用
- month: int  # Firestore `month` (1..12)
- monthKey: string  # zero-padded 'MM'（導出）
- capturedAt: timestamp (with timezone) # Firestore `capturedAt`
- url: string
- priority: int  # 導出 (fujii-photos=10, user-photos=0 初期)
- memo: string  # Firestore `memo`
- updatedAt: timestamp  # Firestore `updatedAt`

## Relationships
- users/{userId}/calendar/{MM}/(fujii-photos|user-photos)/{filename}
- 表示は同一 month の複数年を混在許容（year フィールドは seed では未保持のため過去年比較は capturedAt 年で判定）

## Validation Rules
- capturedAt (TZ) → month, monthKey を導出
- month 範囲 1..12 であることをアプリ側 assert（将来 Security Rule でも検証）
- EXIF/メタ不正=アップロード時に除外（本Issue範囲外: モデル上 valid フィールドは保持しない）
- fujii-photos が存在する場合はローテーションで最低1枚を表示内に含める
## Mapping (Firestore → App)
| Firestore                           | App                                 | Notes                               |
| ----------------------------------- | ----------------------------------- | ----------------------------------- |
| type ('fujii-photos','user-photos') | type ('fujii-photos','user-photos') | Firestore値をそのまま利用           |
| month (int)                         | month                               | 1..12                               |
| capturedAt                          | capturedAt                          | TZ保持                              |
| url                                 | url                                 | そのまま                            |
| memo                                | memo                                | 任意表示（現状UI未使用）            |
| updatedAt                           | updatedAt                           | キャッシュ新鮮度                    |
| (なし)                              | priority                            | 導出(fujii-photos=10,user-photos=0) |
| (なし)                              | monthKey                            | zero-pad(month)                     |
