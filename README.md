# 安徽省大学生数学竞赛近三年试题与答案汇编（2023—2025）

本项目收录 **2023—2025 年（第十五至十七届）全国大学生数学竞赛初赛安徽赛区**的全部试题及参考答案，使用 XeLaTeX 排版，分别生成试题册与答案册两个 PDF。

全国大学生数学竞赛（Chinese Mathematics Competitions，CMC）由中国数学会主办。安徽赛区初赛由安徽省数学会组织，与全国各赛区在同一时间使用全国统一试题。竞赛分为数学 A 类、数学 B 类、非数学 A 类、非数学 B 类四个类别。

## 内容

| 年份 | 届次 | 试卷 |
| --- | --- | --- |
| 2023 | 第十五届 | 数学 A 类、数学 B 类、非数学 A 类、非数学 B 类 |
| 2024 | 第十六届 | 数学 A 类、数学 B 类、非数学 A 类、非数学 B 类 |
| 2025 | 第十七届 | 数学 A 类、数学 B 类、非数学 A 类、非数学 B 类 |

共 12 套试卷，每套 6 道大题、满分 100 分。试题册只收录题目；答案册收录题目与参考答案、详细解答。

## 目录结构

```
.
├── main.tex                  # 试题册主文件
├── preamble.tex              # 公共导言区：页面、颜色、章节样式、试题环境
├── cover.tex                 # 试题册封面
├── preface.tex               # 试题册编者的话
├── content/                  # 12 套试题
│   ├── 2023_math_A.tex
│   ├── 2023_math_B.tex
│   ├── 2023_nonmath_A.tex
│   ├── 2023_nonmath_B.tex
│   ├── 2024_math_A.tex
│   ├── 2024_math_B.tex
│   ├── 2024_nonmath_A.tex
│   ├── 2024_nonmath_B.tex
│   ├── 2025_math_A.tex
│   ├── 2025_math_B.tex
│   ├── 2025_nonmath_A.tex
│   └── 2025_nonmath_B.tex
├── main.pdf                  # 试题册 PDF
├── answers/
│   ├── main.tex              # 答案册主文件
│   ├── preamble.tex          # 答案册导言区
│   ├── cover.tex             # 答案册封面
│   ├── preface.tex           # 答案册说明
│   ├── content/              # 12 套参考答案与详细解答
│   └── main.pdf              # 答案册 PDF
└── README.md
```

## 编译

需要 TeX Live 2024（或更新版本），使用 XeLaTeX 编译两次。

试题册：

```bash
xelatex main.tex
xelatex main.tex
```

答案册：

```bash
cd answers
xelatex main.tex
xelatex main.tex
```

或使用 latexmk：

```bash
latexmk -xelatex main.tex
cd answers && latexmk -xelatex main.tex
```

## 资料来源

- 大学生数学竞赛网（中国数学会初赛试题）：<https://www.cmathc.org.cn/shiti/>
  - [第十五届初赛试题及参考答案（2023）](https://www.cmathc.org.cn/csst/321.html)
  - [第十六届初赛试题及参考答案（2024）](https://www.cmathc.org.cn/csst/323.html)
  - [第十七届初赛试题及参考答案（2025）](https://www.cmathc.org.cn/csst/359.html)
- 安徽省数学会·全国大学生数学竞赛：<https://ahmath.ustc.edu.cn/qgdxssxjs/list.htm>

安徽赛区初赛由安徽省数学会组织，与全国各赛区同时使用全国统一试题。

## 声明

试题与解答版权归中国数学会所有。本项目仅供学习交流使用，请勿用于商业用途。
