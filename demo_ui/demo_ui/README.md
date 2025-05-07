# Your Call Your Rule 演示UI

这是一个基于HTML和Tailwind CSS的演示UI，用于展示Your Call Your Rule应用的主要功能和界面设计。

## 页面说明

本演示包含以下页面：

1. **首页 (index.html)**
   - 主要功能卡片展示
   - 通话过滤主开关
   - 正则表达式测试工具
   - 拦截统计信息

2. **黑名单管理 (blacklist.html)**
   - 黑名单列表展示
   - 添加/编辑/删除黑名单
   - 导入导出功能

3. **正则表达式测试 (regex_test.html)**
   - 正则表达式匹配测试
   - 常用正则表达式示例
   - 正则表达式语法参考

4. **云同步设置 (cloud_sync.html)**
   - 云服务提供商选择
   - 同步选项设置
   - 备份与恢复
   - 设备管理

5. **来电显示设置 (caller_id.html)**
   - 来电显示样式预览
   - 主题颜色和样式设置
   - 内容显示选项
   - 高级设置

## 使用方法

1. 在浏览器中打开 `index.html` 开始浏览
2. 通过底部导航栏或页面中的链接在不同页面间导航
3. 交互元素（如开关、按钮等）已添加基本的交互效果

## 技术说明

- 使用 Tailwind CSS 构建响应式界面
- 使用 Font Awesome 图标库
- 纯HTML和JavaScript实现，无需后端支持
- 适配移动设备和桌面浏览器

## 预览方法

可以使用以下命令启动一个简单的HTTP服务器来预览UI：

```bash
python -m http.server 8000
```

然后在浏览器中访问 `http://localhost:8000` 即可查看演示UI。