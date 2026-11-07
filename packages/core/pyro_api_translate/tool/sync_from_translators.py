#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
从 UlionTse/translators 自动提取各翻译器语言映射并合并写入 supported_languages.json (母语自称 Autonym 版)
"""
import os
import sys
import json
import subprocess

# 全量 ISO 代码、中文别名与传统显示名 -> 标准母语自称 (Autonym) 权威映射字典
ISO_AND_NAME_TO_AUTONYM = {
    # 特殊标识
    "auto": "自动 (Auto)",
    "all": "自动 (Auto)",
    "自动": "自动 (Auto)",

    # 中文系列及方言/古汉语
    "zh": "简体中文",
    "zh-cn": "简体中文",
    "zh-CN": "简体中文",
    "zh-chs": "简体中文",
    "zh-CHS": "简体中文",
    "zh-hans": "简体中文",
    "zh-Hans": "简体中文",
    "中文": "简体中文",
    "简体中文": "简体中文",

    "zh-tw": "繁體中文",
    "zh-TW": "繁體中文",
    "zh-hant": "繁體中文",
    "zh-Hant": "繁體中文",
    "中文(台湾)": "繁體中文",
    "繁体中文": "繁體中文",
    "繁體中文": "繁體中文",

    "zh-hk": "繁體中文 (香港)",
    "zh-HK": "繁體中文 (香港)",
    "中文(香港)": "繁體中文 (香港)",
    "繁体中文(香港)": "繁體中文 (香港)",

    "yue": "粵語",
    "中文(粤语)": "粵語",
    "粤语": "粵語",
    "粵語": "粵語",

    "wyw": "文言文",
    "lzh": "文言文",
    "中文(文言文)": "文言文",
    "文言文": "文言文",

    # 国内少数民族语言
    "bo": "བོད་སྐད",
    "藏语": "བོད་སྐད",
    "za": "Vahcuengh",
    "壮语": "Vahcuengh",
    "hmn": "Hmoob",
    "苗语": "Hmoob",
    "ii": "ꆈꌠꉙ",
    "彝语": "ꆈꌠꉙ",
    "mn": "Монгол",
    "蒙古语": "Монгол",
    "mn-Cyrl": "Монгол (Кирилл)",
    "蒙古语(西里尔文)": "Монгол (Кирилл)",
    "mn-Mong": "ᠮᠣᠩᠭᠣᠯ",
    "蒙古语(传统蒙古字母)": "ᠮᠣᠩᠭᠣᠯ",

    # 主要通用语言
    "en": "English",
    "eng": "English",
    "英语": "English",
    "en-us": "English (US)",
    "en-US": "English (US)",
    "英语(美国)": "English (US)",
    "en-uk": "English (UK)",
    "en-UK": "English (UK)",
    "en-gb": "English (UK)",
    "en-GB": "English (UK)",
    "英语(英国)": "English (UK)",
    "en-au": "English (Australia)",
    "en-AU": "English (Australia)",
    "英语(澳大利亚)": "English (Australia)",

    "ja": "日本語",
    "jp": "日本語",
    "jpn": "日本語",
    "日语": "日本語",

    "ko": "한국어",
    "kor": "한국어",
    "韩语": "한국어",

    "fr": "Français",
    "fra": "Français",
    "法语": "Français",
    "fr-ca": "Français (Canada)",
    "fr-CA": "Français (Canada)",
    "加拿大法语": "Français (Canada)",
    "fr-fr": "Français (France)",
    "fr-FR": "Français (France)",

    "de": "Deutsch",
    "deu": "Deutsch",
    "ger": "Deutsch",
    "德语": "Deutsch",

    "es": "Español",
    "spa": "Español",
    "西班牙语": "Español",
    "es-es": "Español (España)",
    "es-ES": "Español (España)",
    "es-mx": "Español (México)",
    "es-MX": "Español (México)",
    "西班牙语(墨西哥)": "Español (México)",
    "es-us": "Español (Estados Unidos)",
    "es-US": "Español (Estados Unidos)",
    "西班牙语(美国)": "Español (Estados Unidos)",
    "es-419": "Español (Latinoamérica)",
    "西班牙语(拉丁美洲)": "Español (Latinoamérica)",

    "ru": "Русский",
    "rus": "Русский",
    "俄语": "Русский",

    "it": "Italiano",
    "ita": "Italiano",
    "意大利语": "Italiano",

    "pt": "Português",
    "por": "Português",
    "葡萄牙语": "Português",
    "pt-br": "Português (Brasil)",
    "pt-BR": "Português (Brasil)",
    "葡萄牙语(巴西)": "Português (Brasil)",
    "pt-pt": "Português (Portugal)",
    "pt-PT": "Português (Portugal)",
    "葡萄牙语(葡萄牙)": "Português (Portugal)",

    "th": "ไทย",
    "tha": "ไทย",
    "泰语": "ไทย",

    "vi": "Tiếng Việt",
    "vie": "Tiếng Việt",
    "越南语": "Tiếng Việt",

    "id": "Bahasa Indonesia",
    "ind": "Bahasa Indonesia",
    "印尼语": "Bahasa Indonesia",
    "印度尼西亚语": "Bahasa Indonesia",

    "ar": "العربية",
    "ara": "العربية",
    "阿拉伯语": "العربية",
    "ar-ae": "العربية (الإمارات)",
    "ar-AE": "العربية (الإمارات)",
    "阿拉伯语(阿联酋)": "العربية (الإمارات)",
    "ar-eg": "العربية (مصر)",
    "ar-EG": "العربية (مصر)",
    "阿拉伯语(埃及)": "العربية (مصر)",
    "ar-sa": "العربية (السعودية)",
    "ar-SA": "العربية (السعودية)",
    "阿拉伯语(沙特阿拉伯)": "العربية (السعودية)",

    "hi": "हिन्दी",
    "hin": "हिन्दी",
    "印地语": "हिन्दी",

    "tr": "Türkçe",
    "tur": "Türkçe",
    "土耳其语": "Türkçe",

    "pl": "Polski",
    "pol": "Polski",
    "波兰语": "Polski",

    "nl": "Nederlands",
    "nld": "Nederlands",
    "荷兰语": "Nederlands",

    "sv": "Svenska",
    "swe": "Svenska",
    "瑞典语": "Svenska",

    "el": "Ελληνικά",
    "ell": "Ελληνικά",
    "希腊语": "Ελληνικά",
    "现代希腊语": "Ελληνικά",

    "he": "עברית",
    "heb": "עברית",
    "iw": "עברית",
    "希伯来语": "עברית",

    "cs": "Čeština",
    "ces": "Čeština",
    "cze": "Čeština",
    "捷克语": "Čeština",

    "da": "Dansk",
    "dan": "Dansk",
    "丹麦语": "Dansk",

    "fi": "Suomi",
    "fin": "Suomi",
    "芬兰语": "Suomi",

    "hu": "Magyar",
    "hun": "Magyar",
    "匈牙利语": "Magyar",

    "no": "Norsk",
    "nor": "Norsk",
    "nob": "Norsk",
    "nno": "Norsk",
    "挪威语": "Norsk",

    "ro": "Română",
    "ron": "Română",
    "rum": "Română",
    "罗马尼亚语": "Română",

    "sk": "Slovenčina",
    "slk": "Slovenčina",
    "slo": "Slovenčina",
    "斯洛伐克语": "Slovenčina",

    "uk": "Українська",
    "ukr": "Українська",
    "乌克兰语": "Українська",

    "bg": "Български",
    "bul": "Български",
    "保加利亚语": "Български",

    "ca": "Català",
    "cat": "Català",
    "加泰罗尼亚语": "Català",

    "hr": "Hrvatski",
    "hrv": "Hrvatski",
    "hbs": "Hrvatski",
    "克罗地亚语": "Hrvatski",

    "lt": "Lietuvių",
    "lit": "Lietuvių",
    "立陶宛语": "Lietuvių",

    "lv": "Latviešu",
    "lav": "Latviešu",
    "拉脱维亚语": "Latviešu",

    "sr": "Српски",
    "srp": "Српски",
    "塞尔维亚语": "Српски",

    "sl": "Slovenščina",
    "slv": "Slovenščina",
    "斯洛文尼亚语": "Slovenščina",

    "et": "Eesti",
    "est": "Eesti",
    "爱沙尼亚语": "Eesti",

    "fa": "فارسی",
    "fas": "فارسی",
    "per": "فارسی",
    "波斯语": "فارسی",

    "az": "Azərbaycanca",
    "aze": "Azərbaycanca",
    "阿塞拜疆语": "Azərbaycanca",

    "hy": "Հայերեն",
    "hye": "Հայերեն",
    "arm": "Հայերեն",
    "亚美尼亚语": "Հայերեն",

    "ka": "ქართული",
    "kat": "ქართული",
    "geo": "ქართული",
    "格鲁吉亚语": "ქართული",

    "kk": "Қазақ тілі",
    "kaz": "Қазақ тілі",
    "哈萨克语": "Қазақ тілі",

    "ky": "Кыргызча",
    "kir": "Кыргызча",
    "吉尔吉斯语": "Кыргызча",
    "吉尔吉斯斯坦语": "Кыргызча",

    "uz": "Oʻzbekcha",
    "uzb": "Oʻzbekcha",
    "乌兹别克语": "Oʻzbekcha",

    "ur": "اردو",
    "urd": "اردو",
    "乌尔都语": "اردو",

    "bn": "বাংলা",
    "ben": "বাংলা",
    "孟加拉语": "বাংলা",

    "ta": "தமிழ்",
    "tam": "தமிழ்",
    "泰米尔语": "தமிழ்",

    "te": "తెలుగు",
    "tel": "తెలుగు",
    "泰卢固语": "తెలుగు",

    "mr": "मराठी",
    "mar": "मराठी",
    "马拉地语": "मराठी",

    "gu": "ગુજરાતી",
    "guj": "ગુજરાતી",
    "古吉拉特语": "ગુજરાતી",

    "kn": "ಕನ್ನಡ",
    "kan": "ಕನ್ನಡ",
    "卡纳达语": "ಕನ್ನಡ",

    "ml": "മലയാളം",
    "mal": "മലയാളം",
    "马拉雅拉姆语": "മലയാളം",

    "my": "မြန်မာဘာသာ",
    "mya": "မြန်မာဘာသာ",
    "bur": "မြန်မာဘာသာ",
    "缅甸语": "မြန်မာဘာသာ",

    "km": "ភាសាខ្មែរ",
    "khm": "ភាសាខ្មែរ",
    "hkm": "ភាសាខ្មែរ",
    "高棉语": "ភាសាខ្មែរ",

    "lo": "ພາສາລາວ",
    "lao": "ພາສາລາວ",
    "老挝语": "ພາສາລາວ",

    "am": "አማርኛ",
    "amh": "አማርኛ",
    "阿姆哈拉语": "አማርኛ",

    "sw": "Kiswahili",
    "swa": "Kiswahili",
    "斯瓦希里语": "Kiswahili",

    "fil": "Filipino",
    "tl": "Filipino",
    "tgl": "Filipino",
    "菲律宾语": "Filipino",

    "ms": "Bahasa Melayu",
    "msa": "Bahasa Melayu",
    "may": "Bahasa Melayu",
    "马来语": "Bahasa Melayu",

    "af": "Afrikaans",
    "afr": "Afrikaans",
    "南非语": "Afrikaans",

    "is": "Íslenska",
    "isl": "Íslenska",
    "ice": "Íslenska",
    "冰岛语": "Íslenska",

    "ga": "Gaeilge",
    "gle": "Gaeilge",
    "爱尔兰语": "Gaeilge",

    "sq": "Shqip",
    "sqi": "Shqip",
    "alb": "Shqip",
    "阿尔巴尼亚语": "Shqip",

    "eu": "Euskara",
    "eus": "Euskara",
    "baq": "Euskara",
    "巴斯克语": "Euskara",

    "gl": "Galego",
    "glg": "Galego",
    "加利西亚语": "Galego",

    "bs": "Bosanski",
    "bos": "Bosanski",
    "波斯尼亚语": "Bosanski",

    "mk": "Македонски",
    "mkd": "Македонски",
    "mac": "Македонски",
    "马其顿语": "Македонски",

    "mt": "Malti",
    "mlt": "Malti",
    "马耳他语": "Malti",

    "cy": "Cymraeg",
    "cym": "Cymraeg",
    "wel": "Cymraeg",
    "威尔士语": "Cymraeg",

    "yi": "ייִדיש",
    "yid": "ייִדיש",
    "意第绪语": "ייִדיש",

    "yo": "Yorùbá",
    "yor": "Yorùbá",
    "约鲁巴语": "Yorùbá",

    "ig": "Ásụ̀sụ́ Ìgbò",
    "ibo": "Ásụ̀sụ́ Ìgbò",
    "伊博语": "Ásụ̀sụ́ Ìgbò",

    "ha": "Harshen Hausa",
    "hau": "Harshen Hausa",
    "豪萨语": "Harshen Hausa",

    "so": "Soomaali",
    "som": "Soomaali",
    "索马里语": "Soomaali",

    "st": "Sesotho",
    "sot": "Sesotho",
    "塞索托语": "Sesotho",

    "su": "Basa Sunda",
    "sun": "Basa Sunda",
    "巽他语": "Basa Sunda",

    "jv": "Basa Jawa",
    "jav": "Basa Jawa",
    "jw": "Basa Jawa",
    "爪哇语": "Basa Jawa",

    "ceb": "Cebuano",
    "宿务语": "Cebuano",

    "ny": "Chichewa",
    "nya": "Chichewa",
    "齐切瓦语": "Chichewa",

    "mg": "Malagasy",
    "mlg": "Malagasy",
    "马尔加什语": "Malagasy",

    "ht": "Kreyòl ayisyen",
    "hat": "Kreyòl ayisyen",
    "海地克里奥尔语": "Kreyòl ayisyen",

    "haw": "ʻŌlelo Hawaiʻi",
    "hawai": "ʻŌlelo Hawaiʻi",
    "夏威夷语": "ʻŌlelo Hawaiʻi",

    "mi": "Te Reo Māori",
    "mri": "Te Reo Māori",
    "mao": "Te Reo Māori",
    "毛利语": "Te Reo Māori",

    "sm": "Gagana Samoa",
    "smo": "Gagana Samoa",
    "萨摩亚语": "Gagana Samoa",

    "tg": "Тоҷикӣ",
    "tgk": "Тоҷикӣ",
    "塔吉克语": "Тоҷикӣ",

    "tk": "Türkmen dili",
    "tuk": "Türkmen dili",
    "土库曼语": "Türkmen dili",

    "tt": "Татарча",
    "tat": "Татарча",
    "鞑靼语": "Татарча",

    "ug": "ئۇيغۇرچە",
    "uig": "ئۇيغۇرچە",
    "维吾尔语": "ئۇيغۇرچە",

    "ps": "پښتو",
    "pus": "پښتو",
    "普什图语": "پښتو",

    "sd": "سنڌي",
    "snd": "سنڌي",
    "信德语": "سنڌي",

    "ne": "नेपाली",
    "nep": "नेपाली",
    "尼泊尔语": "नेपाली",

    "si": "සිංහල",
    "sin": "සිංහල",
    "僧伽罗语": "සිංහල",

    "pa": "ਪੰਜਾਬੀ",
    "pan": "ਪੰਜਾਬੀ",
    "旁遮普语": "ਪੰਜਾਬੀ",

    "fy": "Frysk",
    "fry": "Frysk",
    "弗里斯兰语": "Frysk",
    "西弗里斯兰语": "Frysk",

    "co": "Corsu",
    "cos": "Corsu",
    "科西嘉语": "Corsu",

    "gd": "Gàidhlig",
    "gla": "Gàidhlig",
    "苏格兰盖尔语": "Gàidhlig",

    "lb": "Lëtzebuergesch",
    "ltz": "Lëtzebuergesch",
    "卢森堡语": "Lëtzebuergesch",

    "la": "Latina",
    "lat": "Latina",
    "拉丁语": "Latina",

    "eo": "Esperanto",
    "epo": "Esperanto",
    "世界语": "Esperanto",

    "ku": "Kurdî",
    "kur": "Kurdî",
    "库尔德语": "Kurdî",

    "ckb": "کوردی",
    "库尔德语(中)": "کوردی",
    "库尔德语(索拉尼)": "کوردی",

    "ti": "ትግርኛ",
    "tir": "ትግርኛ",
    "提格利尼亚语": "ትግርኛ",

    "ay": "Aymar aru",
    "aym": "Aymar aru",
    "艾马拉语": "Aymar aru",

    "qu": "Runa Simi",
    "que": "Runa Simi",
    "克丘亚语": "Runa Simi",

    "sn": "chiShona",
    "sna": "chiShona",
    "肖纳语": "chiShona",

    "zu": "isiZulu",
    "zul": "isiZulu",
    "祖鲁语": "isiZulu",
}

def resolve_autonym(key_or_code):
    """根据键名或 ISO 代码解析出标准母语自称 (Autonym)"""
    if not key_or_code:
        return key_or_code
    s = str(key_or_code).strip()
    if s in ISO_AND_NAME_TO_AUTONYM:
        return ISO_AND_NAME_TO_AUTONYM[s]
    lower_s = s.lower()
    if lower_s in ISO_AND_NAME_TO_AUTONYM:
        return ISO_AND_NAME_TO_AUTONYM[lower_s]
    return s

def ensure_translators():
    try:
        import translators as ts
        return ts
    except ImportError:
        print("未检测到 translators，正在从 GitHub 自动安装 UlionTse/translators...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "git+https://github.com/UlionTse/translators.git"])
        import translators as ts
        return ts

def main():
    ts = ensure_translators()

    SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
    ASSETS_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, "..", "assets"))
    TARGET_JSON_PATH = os.path.join(ASSETS_DIR, "supported_languages.json")

    # 1. 优先加载现有的 supported_languages.json 保持格式兼容
    existing_data = []
    if os.path.exists(TARGET_JSON_PATH):
        try:
            with open(TARGET_JSON_PATH, "r", encoding="utf-8") as f:
                existing_data = json.load(f)
        except Exception as e:
            print(f"读取现有 supported_languages.json 警告: {e}")

    value_map = {}
    for item in existing_data:
        if isinstance(item, dict) and "Value" in item:
            val = resolve_autonym(item["Value"])
            item["Value"] = val
            value_map[val] = item

    # 2. 遍历 UlionTse/translators 导出的所有翻译服务商
    pool = getattr(ts, "translators_pool", [])
    print(f"开始从 translators ({len(pool)} 个翻译源) 提取语言字典...")

    for provider in pool:
        try:
            lang_dict = ts.get_languages(translator=provider)
            if not lang_dict:
                continue

            for lang_code in lang_dict.keys():
                val_name = resolve_autonym(lang_code)
                if val_name not in value_map:
                    value_map[val_name] = {"Value": val_name}
                value_map[val_name][provider] = lang_code
            print(f"✓ [{provider}] 成功拉取")
        except Exception as e:
            print(f"✕ [{provider}] 拉取跳过: {e}")

    # 3. 排序与输出格式化
    output_list = list(value_map.values())
    def sort_key(item):
        val = item.get("Value", "")
        if val == "自动 (Auto)": return (0, val)
        if val == "简体中文": return (1, val)
        return (2, val)

    output_list.sort(key=sort_key)

    os.makedirs(ASSETS_DIR, exist_ok=True)
    with open(TARGET_JSON_PATH, "w", encoding="utf-8") as f:
        json.dump(output_list, f, ensure_ascii=False, indent=4)

    print(f"成功更新 supported_languages.json: {TARGET_JSON_PATH}")

if __name__ == "__main__":
    main()
