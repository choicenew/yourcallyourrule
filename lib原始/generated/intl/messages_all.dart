// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:implementation_imports, file_names, unnecessary_new
// ignore_for_file:unnecessary_brace_in_string_interps, directives_ordering
// ignore_for_file:argument_type_not_assignable, invalid_assignment
// ignore_for_file:prefer_single_quotes, prefer_generic_function_type_aliases
// ignore_for_file:comment_references

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_ar.dart' as messages_ar;
import 'messages_da_DK.dart' as messages_da_dk;
import 'messages_de.dart' as messages_de;
import 'messages_el_GR.dart' as messages_el_gr;
import 'messages_en.dart' as messages_en;
import 'messages_en_GB.dart' as messages_en_gb;
import 'messages_en_US.dart' as messages_en_us;
import 'messages_es.dart' as messages_es;
import 'messages_fr.dart' as messages_fr;
import 'messages_he_IL.dart' as messages_he_il;
import 'messages_id_ID.dart' as messages_id_id;
import 'messages_it.dart' as messages_it;
import 'messages_ja_JP.dart' as messages_ja_jp;
import 'messages_ko_KR.dart' as messages_ko_kr;
import 'messages_ms_MY.dart' as messages_ms_my;
import 'messages_my_MM.dart' as messages_my_mm;
import 'messages_nl_NL.dart' as messages_nl_nl;
import 'messages_pl_PL.dart' as messages_pl_pl;
import 'messages_pt.dart' as messages_pt;
import 'messages_ru.dart' as messages_ru;
import 'messages_ru_RU.dart' as messages_ru_ru;
import 'messages_sv_SE.dart' as messages_sv_se;
import 'messages_th_TH.dart' as messages_th_th;
import 'messages_tr_TR.dart' as messages_tr_tr;
import 'messages_uk_UA.dart' as messages_uk_ua;
import 'messages_vi_VN.dart' as messages_vi_vn;
import 'messages_zh.dart' as messages_zh;
import 'messages_zh_CN.dart' as messages_zh_cn;
import 'messages_zh_HK.dart' as messages_zh_hk;
import 'messages_zh_MO.dart' as messages_zh_mo;
import 'messages_zh_TW.dart' as messages_zh_tw;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'ar': () => new SynchronousFuture(null),
  'da_DK': () => new SynchronousFuture(null),
  'de': () => new SynchronousFuture(null),
  'el_GR': () => new SynchronousFuture(null),
  'en': () => new SynchronousFuture(null),
  'en_GB': () => new SynchronousFuture(null),
  'en_US': () => new SynchronousFuture(null),
  'es': () => new SynchronousFuture(null),
  'fr': () => new SynchronousFuture(null),
  'he_IL': () => new SynchronousFuture(null),
  'id_ID': () => new SynchronousFuture(null),
  'it': () => new SynchronousFuture(null),
  'ja_JP': () => new SynchronousFuture(null),
  'ko_KR': () => new SynchronousFuture(null),
  'ms_MY': () => new SynchronousFuture(null),
  'my_MM': () => new SynchronousFuture(null),
  'nl_NL': () => new SynchronousFuture(null),
  'pl_PL': () => new SynchronousFuture(null),
  'pt': () => new SynchronousFuture(null),
  'ru': () => new SynchronousFuture(null),
  'ru_RU': () => new SynchronousFuture(null),
  'sv_SE': () => new SynchronousFuture(null),
  'th_TH': () => new SynchronousFuture(null),
  'tr_TR': () => new SynchronousFuture(null),
  'uk_UA': () => new SynchronousFuture(null),
  'vi_VN': () => new SynchronousFuture(null),
  'zh': () => new SynchronousFuture(null),
  'zh_CN': () => new SynchronousFuture(null),
  'zh_HK': () => new SynchronousFuture(null),
  'zh_MO': () => new SynchronousFuture(null),
  'zh_TW': () => new SynchronousFuture(null),
};

MessageLookupByLibrary? _findExact(String localeName) {
  switch (localeName) {
    case 'ar':
      return messages_ar.messages;
    case 'da_DK':
      return messages_da_dk.messages;
    case 'de':
      return messages_de.messages;
    case 'el_GR':
      return messages_el_gr.messages;
    case 'en':
      return messages_en.messages;
    case 'en_GB':
      return messages_en_gb.messages;
    case 'en_US':
      return messages_en_us.messages;
    case 'es':
      return messages_es.messages;
    case 'fr':
      return messages_fr.messages;
    case 'he_IL':
      return messages_he_il.messages;
    case 'id_ID':
      return messages_id_id.messages;
    case 'it':
      return messages_it.messages;
    case 'ja_JP':
      return messages_ja_jp.messages;
    case 'ko_KR':
      return messages_ko_kr.messages;
    case 'ms_MY':
      return messages_ms_my.messages;
    case 'my_MM':
      return messages_my_mm.messages;
    case 'nl_NL':
      return messages_nl_nl.messages;
    case 'pl_PL':
      return messages_pl_pl.messages;
    case 'pt':
      return messages_pt.messages;
    case 'ru':
      return messages_ru.messages;
    case 'ru_RU':
      return messages_ru_ru.messages;
    case 'sv_SE':
      return messages_sv_se.messages;
    case 'th_TH':
      return messages_th_th.messages;
    case 'tr_TR':
      return messages_tr_tr.messages;
    case 'uk_UA':
      return messages_uk_ua.messages;
    case 'vi_VN':
      return messages_vi_vn.messages;
    case 'zh':
      return messages_zh.messages;
    case 'zh_CN':
      return messages_zh_cn.messages;
    case 'zh_HK':
      return messages_zh_hk.messages;
    case 'zh_MO':
      return messages_zh_mo.messages;
    case 'zh_TW':
      return messages_zh_tw.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) {
  var availableLocale = Intl.verifiedLocale(
      localeName, (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return new SynchronousFuture(false);
  }
  var lib = _deferredLibraries[availableLocale];
  lib == null ? new SynchronousFuture(false) : lib();
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new SynchronousFuture(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(String locale) {
  var actualLocale =
      Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
