---
layout: doc
---
# 拼长图 — 法律协议文档

本目录存放 拼长图 的全部用户协议与隐私政策文件（中英文合一）。App 通过 `LegalLinks` 常量引用这些文档的 GitHub Blob URL。

- 开发者：wangzz
- 联系邮箱：wzzvictory_tjsd@163.com
- 生效日期：2026-09-08
- 工程英文名（远端目录名）：`LongStitch`

## 文档清单

- `PRIVACY.md` — 隐私政策
- `TERMS.md` — 用户协议
- `SUBSCRIPTION.md` — 订阅条款

## 访问 URL（GitHub Blob，App 内引用与 ASC 提交的唯一规范）

```
https://github.com/wangzz/md-doc/blob/main/LongStitch/<DOCNAME>.md
```

`<DOCNAME>` 取自协议矩阵的远端文件名，使用 SCREAMING_SNAKE_CASE：

- `PRIVACY.md` — 隐私政策
- `TERMS.md` — 用户协议
- `SUBSCRIPTION.md` — 订阅条款（订阅商品 V1.1 起开售）

GitHub 会自动将 `.md` 文件渲染为带样式的 Markdown 页面，无需启用 GitHub Pages。

## 更新流程

协议更新不需要重新发版 App。直接修改本目录下的对应文件，提交并 push 到 main 分支，URL 内容即时更新。

更新后建议：

1. 修改对应文档的「生效日期 / Effective Date」字段为新日期
2. 对于实质性变更（收集新类型数据、新增第三方 SDK、订阅价格调整），必须提前 30 天通知用户
