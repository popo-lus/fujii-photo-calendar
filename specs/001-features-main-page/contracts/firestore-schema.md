# Contract: Firestore Collections for Month Calendar

## Path Structure (per user)
```
users/{userId}
  calendar/{MM}
    fujii-photos/{filename}
    user-photos/{filename}
```

## Raw Document Schema (Seed) per photo
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
  - users/{uid}/calendar/{MM}/fujii-photos/* 全件取得
  - users/{uid}/calendar/{MM}/user-photos/* 全件取得
- 過剰時: クライアントでランダムサンプリング + priority(=admin加点) ソート

## Constraints (High Level)
- Security Rules（別Issue）で: 自ユーザー以外 read 禁止 / ロールで書込制御
- month フィールド整合性 (1..12)
- Admin写真存在時の露出保証はクライアントロジック（priority + 最低1件確保）
