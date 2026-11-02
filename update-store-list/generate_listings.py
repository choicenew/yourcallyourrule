# -*- coding: utf-8 -*-
"""
Google Play Store Listing 多语言生成与字数门禁校验工具
自动在 update-store-list/listings/<language_code>/ 下生成标准文本文件：
- title.txt (最大 30 字符)
- short_description.txt (最大 80 字符)
- full_description.txt (最大 4000 字符)
"""

import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
LISTINGS_DIR = os.path.join(HERE, "listings")

# 定义各语言元数据
L = {}

L["zh-CN"] = dict(
    title="隐私拦截：您的通话您做主",
    short="智能通话过滤。完全隐私：无账户、不上传数据、完全掌控。",
    full="""通过极致的隐私保护，夺回通话和短信的掌控权。厌倦了骚扰电话和垃圾信息？本应用是一款功能强大、高度可定制的通话和短信屏蔽器，专为隐私至上的用户设计。

🛡️ 100% 隐私 & 无需账户
- 零数据上传：无账户系统，无内置在线数据库，无隐藏追踪。
- 本地处理：所有过滤规则、通话记录和数据均完全在您的设备上管理。"""
)

L["zh-TW"] = dict(
    title="隱私攔截：您的通話您做主",
    short="智能通話過濾。完全隱私：無帳戶、不傳輸資料、完全掌控。",
    full="""透過极致的隱私保護，奪回通話和簡訊的掌控權。厭倦了騷擾電話和垃圾訊息？本應用程式是一款功能強大、高度可定制的通話和簡訊封鎖器，專為隱私至上的用戶設計。

🛡️ 100% 隱私 & 無需帳戶
- 零數據上傳：無帳戶系統，無內置在線數據庫，無隱藏追蹤。
- 本地處理：所有過濾規則、通話記錄和資料均完全在您的設備上管理。"""
)

L["zh-HK"] = dict(
    title="隱私攔截：您的通話您做主",
    short="智能通話過濾。完全隱私：無帳戶、不傳輸資料、完全掌控。",
    full="""透過极致的隱私保護，奪回通話和簡訊的掌控權。厭倦了騷擾電話和垃圾訊息？本應用程式是一款功能強大、高度可定制的通話和簡訊封鎖器，專為隱私至上的用戶設計。

🛡️ 100% 隱私 & 無需帳戶
- 零數據上傳：無帳戶系統，無內置在線數據庫，無隱藏追蹤。
- 本地處理：所有過濾規則、通話記錄和資料均完全在您的設備上管理。"""
)

L["ja-JP"] = dict(
    title="プライバシー電話フィルター",
    short="スマートな着信拒否。完全なプライバシー：アカウント不要、データ送信なし。",
    full="""究極のプライバシー保護で、通話とSMSのコントロールを取り戻しましょう。迷惑電話やスパムメッセージにうんざりしていませんか？このアプリは、プライバシーを最優先するユーザーのために設計された、強力で高度にカスタマイズ可能な着信およびSMSブロッカーです。

🛡️ 100%のプライバシーとアカウント不要
- データアップロードゼロ：アカウントシステム、オンラインデータベース、隠しトラッキングはありません。
- ローカル処理：すべてのフィルタリングルール、通話履歴、データはデバイス上で完全に管理されます。"""
)

L["ko-KR"] = dict(
    title="통화 프라이버시: 나만의 규칙",
    short="스마트 통화 필터. 완전한 개인정보 보호: 계정 없음, 데이터 업로드 없음.",
    full="""궁극의 개인정보 보호로 통화 및 SMS 제어권을 되찾으세요. 스팸 전화와 메시지에 지치셨나요? 이 앱은 개인정보 보호를 최우선으로 하는 사용자를 위해 설계된 강력하고 고도로 사용자 정의 가능한 통화 및 SMS 차단기입니다.

🛡️ 100% 개인정보 보호 및 계정 필요 없음
- 데이터 업로드 제로: 계정 시스템, 내장 온라인 데이터베이스, 숨겨진 추적 없음.
- 로컬 처리: 모든 필터링 규칙, 통화 기록 및 데이터는 기기에서 완전히 관리됩니다."""
)

L["es-ES"] = dict(
    title="Privacidad de Llamadas",
    short="Filtro de llamadas inteligente. Privacidad total: sin cuentas ni carga de datos.",
    full="""Recupere el control de sus llamadas y SMS con la máxima privacidad. ¿Cansado de llamadas no deseadas y mensajes de spam? Esta aplicación es un bloqueador de llamadas y SMS potente y highly personalizable, diseñado para usuarios que priorizan la privacidad.

🛡️ 100% Privacidad y Sin Cuenta
- Cero carga de datos: sin sistema de cuentas, sin base de datos en línea, sin seguimiento oculto.
- Procesamiento local: todas las reglas, registros y datos se gestionan en su dispositivo."""
)

L["fr-FR"] = dict(
    title="Confidentialité des Appels",
    short="Filtre d'appels intelligent. Confidentialité totale : sans compte ni données.",
    full="""Reprenez le contrôle de vos appels et SMS avec une confidentialité absolue. Fatigué des appels indésirables et du spam ? Cette application est un bloqueur d'appels et de SMS puissant et personnalisable, conçu pour les utilisateurs soucieux de leur vie privée.

🛡️ 100% Confidentialité & Sans Compte
- Zéro téléchargement de données : aucun système de compte, aucune base de données en ligne.
- Traitement local : toutes les règles et les journaux sont gérés sur votre appareil."""
)

L["de-DE"] = dict(
    title="Anruf-Privatsphäre",
    short="Smarter Anruffilter. 100% Datenschutz: Keine Konten, kein Datenupload.",
    full="""Holen Sie sich die Kontrolle über Ihre Anrufe und SMS mit ultimativem Datenschutz zurück. Sind Sie Spam-Anrufe und -Nachrichten leid? Diese App ist ein leistungsstarker, anpassbarer Anruf- und SMS-Blocker für datenschutzbewusste Nutzer.

🛡️ 100% Datenschutz & Kein Konto
- Null Daten-Upload: Kein Kontosystem, keine Online-Datenbank, kein verstecktes Tracking.
- Lokale Verarbeitung: Alle Filterregeln, Protokolle und Daten werden vollständig auf Ihrem Gerät verwaltet."""
)

L["pt-BR"] = dict(
    title="Privacidade de Chamadas",
    short="Filtro de chamadas inteligente. Privacidade total: sem contas ou uploads.",
    full="""Retome o controle de suas chamadas e SMS com o máximo de privacidade. Cansado de chamadas indesejadas e mensagens de spam? Este aplicativo é um bloqueador de chamadas e SMS poderoso e altamente personalizável, projetado para usuários que priorizam a privacidade.

🛡️ 100% de Privacidade e Sem Conta
- Zero upload de dados: sem sistema de contas, sem banco de dados online, sem rastreamento oculto.
- Processamento local: todas as regras, registros e dados são gerenciados em seu dispositivo."""
)

L["vi"] = dict(
    title="Quyền riêng tư cuộc gọi",
    short="Bộ lọc cuộc gọi thông minh. Bảo mật 100%: không tài khoản, không tải dữ liệu.",
    full="""Giành lại quyền kiểm soát các cuộc gọi và SMS của bạn với quyền riêng tư tối thượng. Mệt mỏi vì các cuộc gọi và tin nhắn rác? Ứng dụng này là một trình chặn cuộc gọi và SMS mạnh mẽ, được thiết kế cho những người dùng đặt quyền riêng tư lên hàng đầu.

🛡️ 100% Quyền riêng tư & Không cần tài khoản
- Không tải lên dữ liệu: không có hệ thống tài khoản, cơ sở dữ liệu trực tuyến, không theo dõi ẩn.
- Xử lý cục bộ: tất cả các quy tắc lọc, nhật ký và dữ liệu được quản lý hoàn toàn trên thiết bị của bạn."""
)

L["th"] = dict(
    title="ความเป็นส่วนตัวของการโทร",
    short="ตัวกรองการโทรอัจฉริยะ ความเป็นส่วนตัว 100%: ไม่มีบัญชี ไม่เก็บข้อมูล",
    full="""ยึดการควบคุมการโทรและ SMS ของคุณคืนมาด้วยความเป็นส่วนตัวสูงสุด เบื่อกับสายสแปมและข้อความขยะหรือไม่? แอปนี้คือเครื่องมือบล็อกการโทรและ SMS ที่ทรงพลังและปรับแต่งได้สูง ออกแบบมาสำหรับผู้ใช้ที่ให้ความสำคัญกับความเป็นส่วนตัว

🛡️ ความเป็นส่วนตัว 100% และไม่ต้องมีบัญชี
- ไม่มีการอัปโหลดข้อมูล: ไม่มีระบบบัญชี ไม่มีฐานข้อมูลออนไลน์ ไม่มีการติดตามแอบแฝง
- การประมวลผลในเครื่อง: กฎการกรอง บันทึกการโทร และข้อมูลทั้งหมดได้รับการจัดการบนอุปกรณ์ของคุณทั้งหมด"""
)

L["id"] = dict(
    title="Privasi Panggilan",
    short="Filter panggilan pintar. Privasi total: tanpa akun, tanpa unggah data.",
    full="""Ambil alih kembali kendali atas panggilan dan SMS Anda dengan privasi tingkat tinggi. Lelah dengan panggilan dan pesan spam? Aplikasi ini adalah pemblokir panggilan dan SMS yang kuat dan sangat dapat disesuaikan, dirancang untuk pengguna yang mengutamakan privasi.

🛡️ 100% Privasi & Tanpa Akun
- Nol unggah data: tanpa sistem akun, database online bawaan, tanpa pelacakan tersembunyi.
- Pemrosesan lokal: semua aturan pemfilteran, log panggilan, dan data dikelola sepenuhnya di perangkat Anda."""
)

L["ms"] = dict(
    title="Privasi Panggilan",
    short="Penapis panggilan pintar. Privasi penuh: tiada akaun, tiada muat naik data.",
    full="""Ambil semula kawalan panggilan dan SMS anda dengan privasi mutlak. Bosan dengan panggilan spam? Aplikasi ini adalah pemblokir panggilan dan SMS yang kuat untuk pengguna yang mengutamakan privasi.

🛡️ 100% Privasi & Tiada Akaun
- Sifar muat naik data: tiada sistem akaun, tiada pangkalan data dalam talian.
- Pemprosesan tempatan: semua peraturan dan log diurus sepenuhnya pada peranti anda."""
)

L["fil"] = dict(
    title="Privacy sa Tawag",
    short="Smart na filter ng tawag. Ganap na privacy: walang account, walang data upload.",
    full="""Bawiin ang kontrol sa iyong mga tawag at SMS nang may ganap na privacy. Pagod na sa mga spam na tawag? Ang app na ito ay isang malakas na blocker ng tawag at SMS para sa mga user na pinapahalagahan ang privacy.

🛡️ 100% Privacy at Walang Account
- Walang data upload: walang account system, walang online database.
- Local na pagproseso: lahat ng panuntunan at log ay pinapamahalaan sa iyong device."""
)

LIMITS = {"title": 30, "short": 80, "full": 4000}
FILES = {
    "title": "title.txt",
    "short": "short_description.txt",
    "full": "full_description.txt"
}

def main():
    errors = []
    print("📋 开始进行 Google Play Store Listing 文本门禁校验...")
    print("-" * 65)

    for lang, data in L.items():
        for field, limit in LIMITS.items():
            val = data[field].strip()
            length = len(val)
            if length > limit:
                errors.append(f"❌ [{lang}] {field} 超出限制: {length}/{limit} 字符 (超出 {length - limit} 字)")

    if errors:
        print("\n".join(errors))
        print("-" * 65)
        print("💥 校验未通过！请修正上述语言文本后再运行生成。")
        sys.exit(1)

    print("✅ 门禁校验通过！开始导出各语言 txt 规范目录...")
    for lang, data in L.items():
        lang_dir = os.path.join(LISTINGS_DIR, lang)
        os.makedirs(lang_dir, exist_ok=True)
        for field, filename in FILES.items():
            file_path = os.path.join(lang_dir, filename)
            with open(file_path, "w", encoding="utf-8", newline="\n") as f:
                f.write(data[field].strip() + "\n")

        t_len = len(data['title'].strip())
        s_len = len(data['short'].strip())
        f_len = len(data['full'].strip())
        print(f"  [OK] {lang:<6s} | 标题: {t_len:2d}/30 | 简短: {s_len:2d}/80 | 完整: {f_len:4d}/4000")

    print("-" * 65)
    print(f"🎉 成功生成 {len(L)} 个语言的 listings 目录文本！")

if __name__ == "__main__":
    main()
