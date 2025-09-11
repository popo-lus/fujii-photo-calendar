// (T006) Auth 入力バリデーションユーティリティ

class AuthValidators {
  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? validateEmail(String? input) {
    final v = (input ?? '').trim();
    if (v.isEmpty) return 'メールを入力してください';
    if (!_emailRegex.hasMatch(v)) return 'メール形式が不正です';
    return null; // OK
  }

  static String? validatePassword(String? input) {
    final v = input ?? '';
    if (v.isEmpty) return 'パスワードを入力してください';
    if (v.length < 6) return '6文字以上で入力してください';
    return null;
  }
}
