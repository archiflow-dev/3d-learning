# 网站结构与技术栈建议

## 原则：git 仓库是唯一来源，artifact 只是发布渠道之一

每节课的 HTML 文件放在这个文件夹（之后建成 git 仓库）。发布 Claude artifact 是从这里的文件发布；网站也从这里的文件生成。**不要把 artifact 当作存档**，否则内容分散在几十个链接里，后面合并会很痛苦。

## 目录结构

```
3d-learning/
├── index.html              # 网站首页：路线图 + 进度 + 课程列表（读取 lessons.json）
├── lessons.json            # 所有课的清单：课号、标题、阶段、状态、前置课、文件、artifact 链接
├── ROADMAP.md              # 路线图（本草案）
├── lessons/
│   ├── 0.1-canvas-pixels.html
│   ├── 1.1-vectors.html
│   └── ...
├── code/                   # 你自己写的渲染器代码（随课程增长）
│   ├── math/               # Vec3、Mat4、Quat……
│   ├── rasterizer/
│   └── raytracer/
├── templates/
│   └── lesson-template.html
└── docs/
```

## 网站页面

| 页面 | 内容 |
|---|---|
| 首页 `index.html` | 一句话介绍、阶段进度条、按阶段分组的课程卡片（已完成/进行中/未开始） |
| 课程页 `lessons/*.html` | 按模板，带上一课/下一课 |
| 概念索引（以后加） | 从 `lessons.json` 的 `concepts` 字段生成"点积 → 1.2, 4.1, 6.2"这样的反向索引 |

## 进度追踪：两层

1. **你的公开学习进度**：写在 `lessons.json` 的 `status` 和 `completedAt` 字段里，提交到 git。所有访客看到的是同一份进度，这才是"展示学习过程"。
2. **访客自己的进度**：页面里的"标记完成"按钮存在浏览器 `localStorage`，只对那个访客自己有效。不需要后端。

## 技术栈建议

| 层 | 选择 | 理由 |
|---|---|---|
| 页面 | 纯静态 HTML + 原生 ES Modules | 不需要构建，单文件同时兼容 artifact 和 GitHub Pages |
| 3D | three.js（固定版本，通过 jsdelivr 的 import map 加载） | 生态最大，文档好 |
| 底层课 | Canvas 2D + 原生 WebGL2 | 阶段 3、5 必须自己实现原理 |
| 公式 | KaTeX（jsdelivr） | 比 MathJax 快 |
| 托管 | GitHub Pages | 免费，push 即发布 |
| 首页 | 一个小脚本读 `lessons.json` 渲染 | 暂时不需要框架 |

**什么时候升级到静态站点生成器（Astro / VitePress）**：课超过 30 节、开始出现大量重复代码、或者想要搜索功能时。现在上框架是过早优化。

## 已知限制和风险（需要你知道）

- **Claude artifact 的外部资源限制**：发布的 artifact 只能从少数 CDN（jsdelivr、cdnjs、unpkg 等）加载脚本，外部 iframe 视频嵌入很可能被拦截（我没有逐一验证 YouTube/B 站 iframe 在 artifact 里是否可用）。所以模板里视频默认用**链接 + 时间点**，GitHub Pages 版本才考虑 iframe 嵌入。
- **视频版权**：YouTube、B 站官方提供的嵌入播放器一般可以用（以上传者允许嵌入为前提），但**不要下载再上传、不要截取片段转载**。最稳的做法是链接 + "看第 X 集 12:30–18:00"。
- **内容准确性**：你是学习者，页面又是 AI 参与生成的，公开发布会有错误。每页标明是学习笔记，附权威参考资料，发现错误时在页面上写勘误。
- **artifact 链接数量**：几十个 artifact 链接不好管理，`lessons.json` 里记录每课的 artifact 链接。
