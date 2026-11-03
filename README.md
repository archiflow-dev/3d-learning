# 3D 数学与图形学学习项目

和 AI 互动学习 3D 数学、计算机图形学和渲染；每节课产出一个交互网页，最后合并成一个公开的学习网站。

网站：https://archiflow-dev.github.io/3d-learning/ （推送到 main 后由 GitHub Actions 自动发布）

| 文件 | 内容 |
|---|---|
| [ROADMAP.md](ROADMAP.md) | 分阶段路线图（10 个阶段，约 75 课，对照 UC Davis 和 MIT 两套公开课） |
| [docs/lesson-template.md](docs/lesson-template.md) | 课程页的固定结构和每节课的流程 |
| [docs/site-and-stack.md](docs/site-and-stack.md) | 网站结构、进度追踪、技术栈、风险 |
| [templates/lesson-template.html](templates/lesson-template.html) | 课程页模板（中英双语，第 0.1 课的副本） |
| [lessons.json](lessons.json) | 课程清单（网站首页和进度的数据来源） |
| [index.html](index.html) | 网站首页：按阶段列出课程和进度，中英双语 |
| [lessons/](lessons/) | 每节课的交互页面 |
| [scripts/build-site.sh](scripts/build-site.sh) | 生成网站目录 `_site/`，给课程页补上 HTML 骨架 |

本地预览：运行 `bash scripts/build-site.sh`，然后在 `_site/` 里运行 `python -m http.server`，打开 http://localhost:8000 。直接双击 index.html 打开时，浏览器会拦截读取 lessons.json。
