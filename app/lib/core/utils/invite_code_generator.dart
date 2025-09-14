// 招待コード生成ユーティリティ

const String _defaultAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

String generateInviteCode({
  int length = 8,
  String alphabet = _defaultAlphabet,
}) {
  assert(length > 0);
  final buf = StringBuffer();
  final rand = DateTime.now().microsecondsSinceEpoch;
  var seed = rand ^ 0x5DEECE66D;
  for (var i = 0; i < length; i++) {
    // 線形合同法ベースの軽量擬似乱数（暗号用途ではない）
    seed = (seed * 25214903917 + 11) & 0xFFFFFFFFFFFF;
    final idx = (seed % alphabet.length).toInt();
    buf.write(alphabet[idx]);
  }
  return buf.toString();
}
