const _sourceKey = 'source';
const _caseSensitiveKey = 'caseSensitive';
const _multiLineKey = 'multiLine';
const _unicodeKey = 'unicode';
const _dotAllKey = 'dotAll';

class Regex {
  static RegExp fromMap(Map<dynamic, dynamic> map) {
    return RegExp(
      map[_sourceKey],
      caseSensitive: map[_caseSensitiveKey] ?? true,
      dotAll: map[_dotAllKey] ?? false,
      multiLine: map[_multiLineKey] ?? false,
      unicode: map[_unicodeKey] ?? false,
    );
  }
}
