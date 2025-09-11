# Data Model: 月カレンダー閲覧（メインページ）

## Entities

### CalendarMonthDocument (Firestoreの月ドキュメント)
- path: `users/{userId}/calendar/{MM}`
- month: int (1..12)
- updatedAt: timestamp (serverTimestamp)
- userPhotos: PhotoItem[]
- fujiiPhotos: PhotoItem[]

### PhotoItem (Firestoreの配列要素)
- id: string (ファイル名)
- type: enum('fujii-photos','user-photos')
- month: int (1..12)
- capturedAt: timestamp
- url: string
- memo: string
- updatedAt: timestamp

### PhotoEntity (App 内部正規化モデル)
- id: string (配列要素の `id` = ファイル名)
- type: enum('fujii-photos','user-photos')  # Firestore `type` をそのまま利用
- month: int  # Firestore `month` (1..12)
- monthKey: string  # zero-padded 'MM'（導出）
- capturedAt: timestamp (with timezone) # Firestore `capturedAt`
- url: string
- priority: int  # 導出 (fujii-photos=10, user-photos=0 初期)
- memo: string  # Firestore `memo`
- updatedAt: timestamp  # Firestore `updatedAt`

## Relationships
- users/{userId}/calendar/{MM} ドキュメント直下に `userPhotos[]` と `fujiiPhotos[]` の配列要素として保存
- アプリでは両配列を読み込み、単一の `List<PhotoEntity>` に正規化して扱う
- 表示は同一 month の複数年を混在許容（year フィールドは seed では未保持のため過去年比較は capturedAt 年で判定）

## Validation Rules
- capturedAt (TZ) → month, monthKey を導出
- month 範囲 1..12 であることをアプリ側 assert（将来 Security Rule でも検証）
- CalendarMonthDocument のID（'MM'）と `month` フィールド、各 PhotoItem の `month` が一致していることを検証
- EXIF/メタ不正=アップロード時に除外（本Issue範囲外: モデル上 valid フィールドは保持しない）
- fujii-photos が存在する場合はローテーションで最低1枚を表示内に含める
## Mapping (Firestore → App)
| Firestore (users/{uid}/calendar/{MM}) | App                                  | Notes                               |
| ------------------------------------- | ------------------------------------ | ----------------------------------- |
| userPhotos: PhotoItem[]               | List<PhotoEntity>（正規化して結合）  | type='user-photos' を保持           |
| fujiiPhotos: PhotoItem[]              | List<PhotoEntity>（正規化して結合）  | type='fujii-photos' を保持          |
| month (int)                           | month                                | 1..12                               |
| capturedAt (各要素)                   | capturedAt                           | TZ保持                              |
| url (各要素)                          | url                                  | そのまま                            |
| memo (各要素)                         | memo                                 | 任意表示（現状UI未使用）            |
| updatedAt (各要素)                    | updatedAt                            | キャッシュ新鮮度                    |
| (なし)                                | priority                             | 導出(fujii-photos=10,user-photos=0) |
| (なし)                                | monthKey                             | zero-pad(month)                     |
