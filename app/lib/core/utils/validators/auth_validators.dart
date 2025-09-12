// (T006) Auth 入力バリデーションユーティリティ

class AuthValidators {
  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? validateEmail(String? input) {
    final v = (input ?? '').trim();
    if (v.isEmpty) return 'メールを入力してください';
    if (!_emailRegex.hasMatch(v)) return 'メール形式が不正です';
    return null; // OK
  }

  // displayName: 非空
  static String? validateDisplayName(String? input) {
    final v = (input ?? '').trim();
    if (v.isEmpty) return '名前を入力してください';
    return null;
  }

  // password: 最小8文字 + 簡易強度（英字と数字を含む）
  static String? validatePassword(String? input) {
    final v = input ?? '';
    if (v.isEmpty) return 'パスワードを入力してください';
    if (v.length < 8) return '8文字以上で入力してください';
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(v);
    final hasDigit = RegExp(r'\d').hasMatch(v);
    if (!(hasLetter && hasDigit)) return '英字と数字を含めてください';
    return null;
  }
}
