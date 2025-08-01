/// Source code copied and modified from https://github.com/zhukeev/spoiler_widget of package https://pub.dev/packages/spoiler_widget
/// MIT License
///
/// Copyright (c) 2024 Zhukeev Argen
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/painting.dart' show Offset, Rect, TextRange;

/// Details of a string
@immutable
class StringDetails {
  /// List of words in the string
  final List<Word> words;

  /// Offset of canvas
  final Offset offset;

  const StringDetails({required this.words, required this.offset});
}

@immutable
class Word {
  final String word;
  final Rect rect;
  final TextRange range;

  const Word({required this.word, required this.rect, required this.range});

  Word copyWith({String? word, Rect? rect, TextRange? range}) {
    return Word(word: word ?? this.word, rect: rect ?? this.rect, range: range ?? this.range);
  }
}
