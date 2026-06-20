---
title: Qoome Edge Console — 文件總覽
status: Phase 1 探勘
updated: 2026-06-08 / **catch-up 2026-06-19**
---

# Qoome Edge Console — 文件總覽

> 這份是 Karen 在 Phase 1 入職階段整理的 Edge Console 架構文件。歡迎 Iven 隨時補充修正。
>
> **📌 2026-06-19 catch-up**：Iven 6/10 Teams briefing + 6/19 commits (LINE OA T1-T6 + campaign T5 JWT verify) 已回灌進 [index.html](index.html) 跟本檔。理解層修正用 ~~刪節線~~ + **新版** 對照；詳細修正清單見 [catch-up-2026-06-19.md](catch-up-2026-06-19.md)。

## 文件結構

| 檔案 | 內容 |
|---|---|
| [架構圖（主檔）](index.html) | 一張統一架構圖 + 可展開細節 + Phase 1 TODO（待解決問題清單 + ✅ Iven 答覆 block） |
| [術語表](glossary.html) | Edge / Persona / Soul / Skill / Personal-wiki 等核心名詞 |
| [catch-up-2026-06-19](catch-up-2026-06-19.md) | 12 條理解誤解 audit + TODO 對齊 + Iven chat / commits 摘要 |
| [Persona Stack 分析報告（2026-06-20）](style-analysis-2026-06-20.html) | **新增**：顯性 vs 隱性風格框架 / my18.cc 診斷 / nuwa v4 對照 / Creative generator 借鏡 / 兩階段提案 |
| 本檔（moc.md） | 總覽入口 |

## Phase 1 核心理解

- **Edge** = 每位 expert 一個專屬 AI agent，吸收 expert know-how 後對外 scale 服務 end user（train 1:1，serve 1:N）
- **Phase 1 戰場** = `qoome-content-factory`（Next.js 14，部署 Zeabur），從「內容生成控台」升級為「Edge Console」
- **不上 Hermes Agentic Agent**（Phase 2 才接），Phase 1 先做保底版（Supabase JWT + Gateway 呼 Skill）
- 設計視角 = 第一人稱「我是醫師 / 知識工作者」，不是純工程視角
- **🆕 (6/19)** Knowledge 4 分類：Librarian-Global（可訂閱平台教科書）/ Librarian-Private（自上傳）/ Methodology（nuwa 取代 ETL）/ Personal-wiki（GitHub repo per Edge，Karen 主導）
- **🆕 (6/19)** Tenant identity 全程靠 JWT 攜帶；body 不可信（T4/T5：body.tenant_id 不符 JWT tenant → 403）
- **🆕 (6/19)** LINE Channel Credential 加密邊界：真值放 Gateway DB，Console 只 UI；GET auto-redact，PATCH 用 sentinel 還原 (T6)

## Phase 1 三大功能（詳見架構圖 §3）

1. **Persona / Soul 提取 UI** ~~（整合 nuwa 女媧 skill）— 缺工作流~~ **→ 🟡 全延後到 nuwa 工具 ready (Iven 6/10)**
2. **LINE OA / FB 帳號設定介面** — schema 已有，UX 待包醫師視角 **+ 🆕 (6/19) 加密邊界由 T6 sentinel pattern 定**
3. **Personal-wiki**（每 Edge 一份，餵 persona/soul）— 全新建 **+ ✅ (6/10) Karen full ownership 已確認；形式 = GitHub repo per Edge；存哪 = Edge 各自 repo**

## 起手第一步

1. 開 dev server，登 dr-lin 走一遍 6 個 tabs，截圖現狀
2. 讀 `PersonasPage.js` + `SettingsPage.js`（最接近 persona/soul 提取的雛形）
3. 拉一份「醫師 onboarding flow」紙上 mockup 再動 code
4. **🆕 (6/19)** 讀 Iven 6/19 7 個 commits（gateway lineResolver / edgeAuthClient / lineWebhook 整合 / intake JWT verify / T6 redact-sentinel）— 確認 contract 對自己領域無 surprise

## 待對齊（→ Iven）

~~詳見[架構圖內 §3 Phase 1 TODO](index.html)，5 條 todo 含「待解決問題」清單。~~

**已對齊**（catch-up 6/19）：BLOCKER ✅ / ② LINE/FB 4 問 ✅ / ④ 範圍/跨 repo 4 問 ✅ / ③ Personal-wiki ownership+形式+存哪 ✅。

**新待對齊**（詳見 [index.html §3 結尾「🆕 新待對齊」](index.html)）：
1. 餵 nuwa 注入方式（OQ3 半答）
2. Personal-wiki tab 位置
3. 醫師 onboarding 自助開戶？
4. Persona v4 OQ 1/2/4（可跟 nuwa 整批延後）
5. 等 Iven push ADR-LINE v0.2 + SM-001 spec
