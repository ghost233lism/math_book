# 数学建模教材 LaTeX 模板

这是一个专为数学建模教材设计的 LaTeX 模板，支持现代化排版、代码高亮、多种高亮框以及中英文混排。

## 特性

- ✅ **分章节文件管理**：每个章节单独文件，便于管理和协作
- ✅ **现代化排版**：基于 `tcolorbox` 的美观高亮框和现代字体
- ✅ **代码高亮**：支持 `minted` 和 `listings` 两种代码高亮方式
- ✅ **多层级标题**：完整的 chapter/section/subsection 结构
- ✅ **自动目录生成**：自动生成目录、图表索引和参考文献
- ✅ **中英文支持**：优秀的中英文混排和字体配置
- ✅ **暗色/浅色主题**：可切换的配色方案
- ✅ **丰富的高亮框**：信息框、警告框、成功框、错误框等
- ✅ **数学环境**：定理、定义、例子等数学环境
- ✅ **参考文献管理**：基于 `biblatex` 的现代文献管理

## 文件结构

```
数学建模书/
├── main.tex                 # 主文件
├── mathmodeling.cls         # 文档类文件
├── config.tex              # 配置文件
├── pythonhighlight.sty     # Python 代码高亮包
├── bibliography.bib        # 参考文献
├── README.md              # 说明文档
└── chapters/              # 章节文件夹
    ├── chapter1.tex       # 第一章
    ├── chapter2.tex       # 第二章
    ├── chapter3.tex       # 第三章
    └── appendix.tex       # 附录
```

## 使用方法

### 1. 基本编译

在 Overleaf 中：
1. 上传所有文件到 Overleaf 项目
2. 设置编译器为 XeLaTeX
3. 设置参考文献处理器为 Biber
4. 编译文档

### 2. 本地编译

#### 使用编译脚本（推荐）

**完整编译脚本（推荐）：**
```powershell
.\compile_complete.ps1
```
此脚本包含：
- 工具检查（XeLaTeX、Biber、Python、Pygments）
- 自动清理旧文件
- 完整的编译流程
- 编译结果验证
- 详细的状态提示

**简单编译脚本：**
```powershell
.\compile.ps1
```

**Windows 批处理：**
```cmd
compile.bat
```

#### 手动编译

```bash
# 完整编译流程
xelatex -shell-escape -interaction=nonstopmode main.tex
biber main
xelatex -shell-escape -interaction=nonstopmode main.tex
xelatex -shell-escape -interaction=nonstopmode main.tex
```

**重要说明：** 
- ✅ **minted包已修复**：现在完全支持代码高亮
- ✅ **算法环境已修复**：使用`algpseudocode`包支持`\State`、`\While`等命令  
- ✅ **amssymb包冲突已解决**：与unicode-math包兼容
- 📋 **依赖要求**：
  - Python 和 Pygments：`pip install Pygments`
  - 编译时必须使用`-shell-escape`选项
  - 推荐使用XeLaTeX编译器

### 3. 自定义配置

在 `config.tex` 文件中可以修改：
- 书籍信息（标题、作者、机构等）
- 字体设置
- 颜色配置
- 页面设置

```latex
% 修改书籍信息
\booktitle{你的教材标题}
\booksubtitle{副标题}
\bookauthor{作者姓名}
\bookinstitution{机构名称}
\bookdate{出版日期}

% 启用暗色模式（在文档类选项中）
\documentclass[12pt,a4paper,oneside,darkmode]{mathmodeling}
```

## 高亮框使用

模板提供了多种高亮框：

```latex
\begin{infobox}[title=信息标题]
这是一个信息框。
\end{infobox}

\begin{warningbox}[title=警告标题]
这是一个警告框。
\end{warningbox}

\begin{errorbox}[title=错误标题]
这是一个错误框。
\end{errorbox}

\begin{successbox}[title=成功标题]
这是一个成功框。
\end{successbox}

\begin{definitionbox}[title=定义标题]
这是一个定义框。
\end{definitionbox}

\begin{theorembox}[title=定理标题]
这是一个定理框。
\end{theorembox}

\begin{examplebox}[title=例子标题]
这是一个例子框。
\end{examplebox}

\begin{codebox}[title=代码标题]
这是一个代码框。
\end{codebox}
```

## 代码高亮

模板同时支持 `minted` 和 `listings` 两种代码高亮方式，可以根据需要选择使用。

### 使用 minted（推荐）

minted 提供更好的语法高亮和更多语言支持：

```latex
\begin{minted}{python}
import numpy as np
import matplotlib.pyplot as plt

def hello_world():
    print("Hello, Mathematical Modeling!")
\end{minted}
```

在 `codebox` 环境中使用 minted：

```latex
\begin{codebox}[title=Python 代码示例]
\begin{minted}{python}
import numpy as np

def gradient_descent(f, grad_f, x0, alpha=0.01):
    x = x0
    for i in range(1000):
        grad = grad_f(x)
        x = x - alpha * grad
    return x
\end{minted}
\end{codebox}
```

### 使用 listings

如果不想使用 shell-escape，可以使用 listings：

```latex
\begin{lstlisting}[language=Python]
import numpy as np
import matplotlib.pyplot as plt

def hello_world():
    print("Hello, Mathematical Modeling!")
\end{lstlisting}
```

## 数学环境

```latex
\begin{definition}[定义名称]
这是一个定义。
\end{definition}

\begin{theorem}[定理名称]
这是一个定理。
\end{theorem}

\begin{proof}
这是定理的证明。
\end{proof}

\begin{example}[例子名称]
这是一个例子。
\end{example}
```

## 图表和交叉引用

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.8\textwidth]{image.png}
    \caption{图片标题}
    \label{fig:example}
\end{figure}

参考 \cref{fig:example} 显示了...
```

## 参考文献

在 `bibliography.bib` 中添加文献：

```bibtex
@book{author2024title,
    title={书籍标题},
    author={作者},
    year={2024},
    publisher={出版社}
}
```

在文档中引用：

```latex
根据 \cite{author2024title} 的研究...
```

## 字体配置

模板默认使用以下字体：
- 英文字体：Times New Roman（正文）、Arial（无衬线）、Consolas（等宽）
- 中文字体：SimSun（宋体）、SimHei（黑体）、KaiTi（楷体）、FangSong（仿宋）
- 数学字体：XITS Math

如果需要自定义字体，可以将字体文件放在 `fonts/` 目录下，并在 `config.tex` 中配置字体路径。

## 兼容性说明

- **编译器**：必须使用 XeLaTeX 或 LuaLaTeX
- **宏包依赖**：所有宏包都是常见的，Overleaf 和 TeX Live 都支持
- **操作系统**：支持 Windows、macOS、Linux
- **中文支持**：完全支持中文排版

## 暗色模式

要启用暗色模式，在 `config.tex` 中取消以下行的注释：

```latex
\documentclass[12pt,a4paper,oneside,darkmode]{mathmodeling}
```

## 常见问题

### 1. 编译错误

**问题**：`minted` 包报错
**解决**：确保使用 `-shell-escape` 选项编译，或者在配置中禁用 `minted` 包

### 2. 字体问题

**问题**：中文字体无法显示
**解决**：确保系统安装了相应的中文字体，或者修改字体配置

### 3. 图片路径

**问题**：图片无法显示
**解决**：检查 `\graphicspath` 设置，确保图片文件在正确的目录中

## 示例内容

模板包含了完整的示例内容：
- 第一章：数学建模概述
- 第二章：优化模型
- 第三章：概率统计模型
- 附录：常用公式与算法

这些示例展示了模板的各种功能和用法。

## 许可证

本模板采用 MIT 许可证，可以自由使用和修改。

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个模板。

## 更新日志

- **v1.0** (2024-01-01): 初始版本
  - 基本的文档结构
  - 高亮框和代码高亮功能
  - 中英文支持
  - 暗色/浅色主题 