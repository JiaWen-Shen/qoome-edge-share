---
title: Qoome Edge Console — 文件總覽
status: Phase 1 探勘
updated: 2026-06-08
---

# Qoome Edge Console — 文件總覽

> 這份是 Karen 在 Phase 1 入職階段整理的 Edge Console 架構文件。歡迎 Iven 隨時補充修正。

## 文件結構

| 檔案 | 內容 |
|---|---|
| [架構圖（主檔）](index.html) | 一張統一架構圖 + 可展開細節 + Phase 1 TODO（待解決問題清單） |
| [術語表](glossary.html) | Edge / Persona / Soul / Skill / Personal-wiki 等核心名詞 |
| 本檔（moc.md） | 總覽入口 |

## Phase 1 核心理解

- **Edge** = 每位 expert 一個專屬 AI agent，吸收 expert know-how 後對外 scale 服務 end user（train 1:1，serve 1:N）
- **Phase 1 戰場** = `qoome-content-factory`（Next.js 14，部署 Zeabur），從「內容生成控台」升級為「Edge Console」
- **不上 Hermes Agentic Agent**（Phase 2 才接），Phase 1 先做保底版（Supabase JWT + Gateway 呼 Skill）
- 設計視角 = 第一人稱「我是醫師 / 知識工作者」，不是純工程視角

## Phase 1 三大功能（詳見架構圖 §3）

1. **Persona / Soul 提取 UI**（整合 nuwa 女媧 skill）— 缺工作流
2. **LINE OA / FB 帳號設定介面** — schema 已有，UX 待包醫師視角
3. **Personal-wiki**（每 Edge 一份，餵 persona/soul）— 全新建

## 起手第一步

1. 開 dev server，登 dr-lin 走一遍 6 個 tabs，截圖現狀
2. 讀 `PersonasPage.js` + `SettingsPage.js`（最接近 persona/soul 提取的雛形）
3. 拉一份「醫師 onboarding flow」紙上 mockup 再動 code

## 待對齊（→ Iven）

詳見[架構圖內 §3 Phase 1 TODO](index.html)，5 條 todo 含「待解決問題」清單。
