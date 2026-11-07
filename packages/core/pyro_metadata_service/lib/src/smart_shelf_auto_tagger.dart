/// 迁移自 TomoRead 的智能书架自动分类与打标引擎
class SmartShelfAutoTagger {
  static final Map<String, List<String>> _categoryKeywords = {
    '科幻': ['三体', '星际', '赛博朋克', '量子', '人工智能', '机器人', '银河'],
    '武侠玄幻': ['剑', '仙', '修真', '宗门', '江湖', '神魔', '玄幻'],
    '学术研究': ['论文', '研究', '医学', '分析', '算法', '架构', '数据'],
    '连载漫画': ['漫画', '动漫', '卷', '话', '画册', '插画'],
  };

  /// 根据图书标题与简介自动推断智能标签与分类
  static List<String> autoTagBook({required String title, String? description}) {
    final text = '$title ${description ?? ''}'.toLowerCase();
    final tags = <String>{};

    _categoryKeywords.forEach((category, keywords) {
      for (var kw in keywords) {
        if (text.contains(kw.toLowerCase())) {
          tags.add(category);
          break;
        }
      }
    });

    if (tags.isEmpty) {
      tags.add('未分类书架');
    }
    return tags.toList();
  }
}
