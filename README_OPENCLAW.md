# AI Berkshire — OpenCLAW 使用指南

[English](README_EN.md) | [Claude Code 使用指南](README.md) | [Codex 使用指南](AGENTS.md)

---

## 项目概述

AI Berkshire 是一套同时兼容 **Claude Code**、**Codex** 与 **OpenCLAW** 的价值投资研究 Skill 合集，将巴菲特、芒格、段永平、李录四位大师的方法论系统化，通过 AI Agent 实现专业级投资研究。

一个人 + OpenCLAW = 一个投研团队。

---

## OpenCLAW 适配说明

本项目已针对 OpenCLAW 进行适配，适配文件位于：

- `openclaw-skills/` — OpenCLAW Skill 包（自动从 `skills/` 生成）
- `openclaw-prompts/` — OpenCLAW 自定义提示（兼容性层）

### 快速安装

```bash
# 生成并安装 OpenCLAW Skills
python3 scripts/sync-openclaw-skills.py

# 生成 OpenCLAW 自定义提示
python3 scripts/sync-openclaw-prompts.py
```

### OpenCLAW Skill 使用方式

OpenCLAW 使用 Skill 方式与 Claude Code 类似，每个 Skill 位于 `openclaw-skills/{skill-name}/SKILL.md`。

调用示例（取决于 OpenCLAW 具体使用方式）：
```
/investment-team 分析腾讯
```

### OpenCLAW 自定义提示

如果 OpenCLAW 支持自定义提示，将 `openclaw-prompts/*.md` 中的内容复制到 OpenCLAW 的提示配置中即可。

---

## Skill 一览（18个）

### 深度研究类

| Skill | 用途 | 适合场景 |
|-------|------|---------|
| `/investment-research` | 四大师综合深度分析 | 对一家上市公司进行全方位投资研究 |
| `/investment-team` | 多Agent并行投研团队 | 4个Agent并行研究，最快速、最全面 |
| `/management-deep-dive` | 管理层纵深研究 | "买股票就是买人"——当管理层是核心变量时深挖 |
| `/private-company-research` | 未上市公司深度研究 | 研究蚂蚁、SpaceX等信息稀缺的未上市公司 |
| `/deep-company-series` | 8篇长文系列拆一家公司 | 公众号级深度系列，12万字从认知重置到决策闭环 |

### 财报分析类

| Skill | 用途 | 适合场景 |
|-------|------|---------|
| `/earnings-review` | 财报精读（一手资料） | 只读原始财报，不依赖二手研报 |
| `/earnings-team` | 财报精读团队 + 公众号发布 | 四大师并行解读财报 → 编辑润色 → 读者评审 |

### 行业筛选类

| Skill | 用途 | 适合场景 |
|-------|------|---------|
| `/industry-research` | 产业链全景扫描 | 研究一个行业的全部投资机会 |
| `/industry-funnel` | 行业漏斗筛选 | 全市场 → 粗筛 ≤10 家 → 终选 3 家深度分析 |
| `/quality-screen` | 去劣筛选（7条硬指标） | 快速排除非一流公司 |

### 投资决策类

| Skill | 用途 | 适合场景 |
|-------|------|---------|
| `/investment-checklist` | 巴菲特买入前Checklist | 10条红线 + 护城河评级 + 安全边际评估 |
| `/thesis-tracker` | 投资论文追踪 | 买入后的纪律系统，跟踪逻辑兑现情况 |
| `/portfolio-review` | 组合管理 | 从"研究公司"到"管理组合" |

### 专题研究类

| Skill | 用途 | 适合场景 |
|-------|------|---------|
| `/bottleneck-hunter` | 供应链瓶颈猎手 | AI驱动的全球产业链瓶颈套利 |
| `/news-pulse` | 公司新闻脉搏 | 股价异动时快速归因 |
| `/dyp-ask` | 段永平问答 | 以他的方式思考投资问题 |

---

## 核心工具

### 精确计算工具

```bash
# 市值校验
python3 tools/financial_rigor.py verify-market-cap \
  --price 510 --shares 9.11e9 --reported 4.65e12 --currency HKD

# 估值验算
python3 tools/financial_rigor.py verify-valuation \
  --price 510 --eps 18.5 --bvps 85.2

# 三情景估值
python3 tools/financial_rigor.py three-scenario \
  --price 500 --eps 15 --shares 9.2 \
  --growth 25 15 5 \
  --pe 35 25 15
```

### 报告审计工具

```bash
# 提取抽检清单
python3 tools/report_audit.py extract --report <报告文件路径>

# 输出准出/打回判决
python3 tools/report_audit.py verdict --results '<填好的JSON>' --report <报告>
```

---

## 研究质量规则

1. **开始研究前先运行 `date` 命令**确认今日日期，作为"最新"数据的基准
2. **财务数据必须来自两个独立来源**交叉验证
3. **使用精确计算工具**进行市值、估值、场景分析，不用心算
4. **明确标注置信度**：低置信结论、数据不足、来源缺口都要标注
5. **呈现正反两面**：每个核心判断都要附带反面论据
6. 本项目仅供学习研究，不构成投资建议

---

## 目录结构

```
ai-berkshire/
├── skills/                  # Claude Code 命令源文件（canonical source）
├── codex-skills/            # Codex Skill 包（从 skills/ 生成）
├── codex-prompts/           # Codex 自定义提示（兼容性层）
├── openclaw-skills/         # OpenCLAW Skill 包（从 skills/ 生成）
├── openclaw-prompts/        # OpenCLAW 自定义提示（兼容性层）
├── tools/                   # 共享金融工具
├── reports/                 # 投研报告输出
└── scripts/                 # 同步脚本
```

---

## 兼容性规则

- `skills/*.md` 是canonical workflow源文件
- 修改 `skills/` 后需运行同步脚本：
  ```bash
  python3 scripts/sync-codex-skills.py
  python3 scripts/sync-openclaw-skills.py
  python3 scripts/sync-codex-prompts.py
  python3 scripts/sync-openclaw-prompts.py
  ```
- 不要手动编辑 `codex-skills/` 或 `openclaw-skills/` 下的文件
- 保持工具路径兼容：`~/ai-berkshire/tools/...`
