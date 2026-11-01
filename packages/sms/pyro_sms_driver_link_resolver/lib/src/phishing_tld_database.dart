/// Database of high risk TLDs and shortener domains
class PhishingTldDatabase {
  static const Set<String> highRiskTlds = {
    'xyz',
    'icu',
    'top',
    'online',
    'site',
    'vip',
    'work',
    'club',
    'cc',
    'tk',
    'ml',
    'ga',
    'cf',
    'gq',
  };

  static const Set<String> urlShorteners = {
    'bit.ly',
    't.co',
    'goo.gl',
    'tinyurl.com',
    'ow.ly',
    'is.gd',
    'buff.ly',
    'adf.ly',
    'rebrand.ly',
  };
}
