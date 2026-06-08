---
title: Qoome Glossary
updated: 2026-06-08
---

# Qoome Glossary

> Karen Phase 1 入職階段整理的核心名詞速查。歡迎 Iven 補充修正。

## 核心概念

### Edge
**每位 expert 一個專屬 AI agent**，吸收 expert know-how 後對外 scale 服務 end user。三層語義：
- 業務 = 一位 expert（醫師 / 知識工作者）的 AI 分身
- 技術 = 一個 `client_id`（多租戶資料隔離單位）
- 部署 = 一份部署在 Zeabur 的 `qoome-content-factory` 實例（每 expert 一份）

`currentEdge` 物件含 `id`、`name`、`persona_id`、`settings`（channels / knowledge / branding / SEO / auto_publish）。

三條信條：
1. Edge = expert 思維的鏡像（Persona/Soul 越用越像本人）
2. Edge = 主動護理師（不只被動回應）
3. Edge = 腦/策略 ↔ Gateway = 手/執行
4. Headless 為主（chat），Console 為輔

### Persona
Expert「人設」資料。`personas` 表，欄位含 basic（name/role/title/specialty）、tags（forbidden_phrases/catchphrases/...）、`personality_prompt`、6 個 JSONB（core_philosophy / voice_architecture / content_boundaries / chatbot_config / cognitive_schema / metadata）。

一個 Edge 可有多個 persona（schema 支援），但 active 一次一個（`currentEdge.persona_id`）。

### Soul
（待確認與 Persona 的資料模型差異 — 詳見 [架構圖 §3 TODO ①](index.html)）

### Personal-wiki
**每個 Edge 一份的私人筆記庫**，作為 nuwa（女媧）skill 提取 persona/soul 的重要來源。Phase 1 要做，但形式 / 存哪 / 怎麼餵 nuwa 都待釐清（詳見 [架構圖 §3 TODO ③](index.html)）。

---

## 系統 / 角色

### Gateway
`qoome-gateway`（Cloudflare Worker 服務網格，ADR-003 v2）。所有 Edge Console 對後端的呼叫都走它，帶 Supabase JWT Bearer。Endpoint 分兩 namespace：
- `/api/v1/edge/*` — CRUD（personas/topics/articles/...）
- `/api/v1/studio/*` — 工作流（articles/generate、topics/suggest、social/publish...）

### Skill
**⚠️ 名詞衝突點**：
- Hermes Skill = markdown 教學文件
- R-Mode 信條 Skill = 後端服務（實作不外洩）
- **Qoome 語境下 Skill = MCP server**，分「給 Edge 看的使用指南」與「對 Edge 黑盒的實作」

三大 Skill：
1. **Content Factory** — 文章生成 / 主題建議（`/studio` 已串）✅
2. **Librarian** — 知識庫 ETL + 訂閱（`/edge/librarian` 已串）✅
3. **Intake** — Persona/Soul 提取（Gateway 尚未 expose）❌

### nuwa（女媧）
Persona/Soul 提取 skill。Phase 1 重點功能依賴它，Karen 端只要呼 Gateway API。

### R-Mode
Hybrid 模式：Edge = what（策略）+ Gateway = how（執行）。

### Hermes
Agentic Agent 版本，Phase 1 **不上**。Phase 2 主場 `qoome-edge-agent` 才接 Hermes。

---

## Repo 對照

| Repo | 用途 | Tech |
|---|---|---|
| **qoome-content-factory** | Phase 1 主戰場 → 升級成 Edge Console | Next.js 14 + Supabase |
| qoome-edge-agent | Phase 2 主場（Agentic Agent）| TBD |
| qoome-gateway | 服務網格 | Cloudflare Worker |
| qoome-campaign | Campaign 系統 | — |
| qoome-workspace | SOP / sprints | docs |
| spec-mcp | 規格 MCP | — |

---

## Deploy 雷區

- **`qoome-content-factory` push = deploy**（Zeabur auto-deploy 到 prod）
- 所有 push 由 **Iven 親自跑**（policy gate），Karen 開 PR 給他 review

## Schema 雷區

- `display_id` 不是 `slug`（H21/H22 累積教訓）
- `chapter_index` 不是 `chapter_number`
- 命名前必先 SQL 驗

---

## 待補

- Soul 跟 Persona 的資料模型差別
- Hermes 一般版 vs Agentic 版的計費 / 功能差異
- `currentEdge.config` 完整 schema
- Late.io 是什麼（FB 走它而非直連 OAuth）

相關：[文件總覽](moc.html) · [架構圖](index.html)
