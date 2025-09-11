# Contract: Firestore Collections for Month Calendar

## Path Structure (per user)
```
users/{userId}
  calendar/{MM}
    (doc fields)
      month: number
      updatedAt: timestamp
      userPhotos: PhotoItem[]
      fujiiPhotos: PhotoItem[]
```

## Raw Document Schema (Seed)
### Month Document
```
{
  month: number,           // 1..12
  updatedAt: timestamp,    // serverTimestamp
  userPhotos: PhotoItem[],
  fujiiPhotos: PhotoItem[]
}
```

### PhotoItem (array element)
```
{
  id: string,          // filename
  url: string,         // storage download URL with token
  capturedAt: timestamp,
  month: number,       // 1..12
  type: 'fujii-photos' | 'user-photos',
  updatedAt: timestamp,
  memo: string
}
```

## App Normalized (Derived Fields)
| Field    | Source    | Logic                         |
| -------- | --------- | ----------------------------- |
| type     | type      | Firestore 値をそのまま使用    |
| monthKey | month     | zero-pad                      |
| priority | (derived) | type=='fujii-photos' ? 10 : 0 |

## Queries
- 月表示ロード:
  - users/{uid}/calendar/{MM} ドキュメントを単一取得/購読（`userPhotos[]` と `fujiiPhotos[]` を結合）
- 過剰時: クライアントでランダムサンプリング + priority(=admin加点) ソート

## Constraints (High Level)
- Security Rules（別Issue）で: 自ユーザー以外 read 禁止 / ロールで書込制御
- month フィールド整合性 (1..12)
- Admin写真存在時の露出保証はクライアントロジック（priority + 最低1件確保）
