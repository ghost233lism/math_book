% 数学建模教材文档类
% 文件名：mathmodeling.cls
% 版本：1.0
% 作者：[您的姓名]

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mathmodeling}[2024/01/01 Mathematical Modeling Textbook Class]

% 基于 book 类
\LoadClass[12pt,a4paper,oneside]{book}

% 必需的宏包
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{ifthen}

% 选项处理
\DeclareBoolOption[false]{darkmode}
\DeclareBoolOption[true]{chinese}
\DeclareStringOption[simsun]{chinesefont}

\ProcessKeyvalOptions*

% 中文支持
\RequirePackage[UTF8,scheme=plain,heading=true]{ctex}

% 字体设置
\RequirePackage{fontspec}
% 先加载mathtools避免与unicode-math冲突
\RequirePackage{mathtools}
\RequirePackage{unicode-math}

% 设置英文字体
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Consolas}

% 设置中文字体
% 使用ctex的默认字体配置，更加兼容
% 如果需要自定义字体，可以取消注释以下行
% \setCJKmainfont{SimSun}[BoldFont=SimHei, ItalicFont=KaiTi]
% \setCJKsansfont{SimHei}
% \setCJKmonofont{FangSong}

% 对于Windows系统，如果要使用系统字体，可以尝试以下设置：
% \setCJKmainfont{SimSun}
% \setCJKsansfont{SimHei}
% \setCJKmonofont{FangSong}

% 数学字体
\setmathfont{XITS Math}

% 注意：不加载amssymb包，避免与unicode-math冲突
% unicode-math已经提供了大部分数学符号

% 页面设置
\RequirePackage[
  a4paper,
  left=2.5cm,
  right=2.5cm,
  top=2.5cm,
  bottom=2.5cm,
  headheight=15pt,
  headsep=10pt,
  footskip=15pt
]{geometry}

% 颜色定义
\RequirePackage{xcolor}

% 浅色主题颜色
\definecolor{primarycolor}{RGB}{0,102,204}
\definecolor{secondarycolor}{RGB}{102,102,102}
\definecolor{accentcolor}{RGB}{255,102,0}
\definecolor{backgroundcolor}{RGB}{255,255,255}
\definecolor{textcolor}{RGB}{0,0,0}
\definecolor{codebackground}{RGB}{245,245,245}
\definecolor{warningcolor}{RGB}{255,193,7}
\definecolor{errorcolor}{RGB}{220,53,69}
\definecolor{successcolor}{RGB}{40,167,69}
\definecolor{infocolor}{RGB}{23,162,184}

% 暗色主题颜色（条件定义）
\ifmathmodeling@darkmode
  \definecolor{primarycolor}{RGB}{100,149,237}
  \definecolor{secondarycolor}{RGB}{169,169,169}
  \definecolor{accentcolor}{RGB}{255,165,0}
  \definecolor{backgroundcolor}{RGB}{43,43,43}
  \definecolor{textcolor}{RGB}{255,255,255}
  \definecolor{codebackground}{RGB}{60,60,60}
  \definecolor{warningcolor}{RGB}{255,193,7}
  \definecolor{errorcolor}{RGB}{220,53,69}
  \definecolor{successcolor}{RGB}{40,167,69}
  \definecolor{infocolor}{RGB}{23,162,184}
  
  % 设置页面背景色
  \pagecolor{backgroundcolor}
  \color{textcolor}
\fi

% 现代化宏包
\RequirePackage{amsmath,amsfonts}
\RequirePackage{physics}
\RequirePackage{siunitx}
% 修复amssymb包冲突 - 在unicode-math之后加载
% \RequirePackage{amssymb}  % 注释掉，避免与unicode-math冲突
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{float}
\RequirePackage{placeins}
\RequirePackage{wrapfig}

% 超链接和交叉引用
\RequirePackage{hyperref}
\RequirePackage{cleveref}
\RequirePackage{bookmark}

% 代码高亮
% 同时支持listings和minted
\RequirePackage{listings}
\RequirePackage{minted}

% 算法包
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}

% 设置 listings 样式
\lstset{
  basicstyle=\ttfamily\footnotesize,
  backgroundcolor=\color{codebackground},
  frame=single,
  rulecolor=\color{primarycolor},
  numbers=left,
  numberstyle=\tiny\color{secondarycolor},
  stepnumber=1,
  numbersep=5pt,
  showspaces=false,
  showstringspaces=false,
  showtabs=false,
  tabsize=4,
  captionpos=b,
  breaklines=true,
  breakatwhitespace=false,
  escapeinside={\%*}{*)}
}

% 设置 minted 样式
\setminted{
  style=default,
  frame=none,
  bgcolor=codebackground,
  fontsize=\footnotesize,
  linenos=true,
  numbersep=5pt,
  xleftmargin=0pt,
  breaklines=true,
  breakanywhere=true,
  tabsize=4,
  samepage=false,
  mathescape=false,
  autogobble=true,
  python3=true
}

% 定义支持跨页的代码环境
\newenvironment{longcode}[1][python]{%
  \VerbatimEnvironment
  \begin{minted}[
    breaklines=true,
    breakanywhere=true,
    samepage=false,
    fontsize=\footnotesize,
    linenos=true,
    numbersep=5pt,
    bgcolor=codebackground,
    frame=none,
    autogobble=true
  ]{#1}%
}{%
  \end{minted}%
}

% 定义带标题的跨页代码环境
\newenvironment{longcodebox}[2][python]{%
  \begin{tcolorbox}[
    breakable,
    enhanced,
    colback=codebackground,
    colframe=primarycolor,
    colbacktitle=primarycolor,
    coltitle=white,
    title=#2,
    fonttitle=\bfseries,
    arc=3mm,
    outer arc=3mm,
    boxrule=0.5pt,
    left=8pt,
    right=8pt,
    top=8pt,
    bottom=8pt,
    attach boxed title to top left={yshift=-2mm,xshift=8mm},
    boxed title style={
      arc=2mm,
      outer arc=2mm,
      boxrule=0pt,
      left=4pt,
      right=4pt,
      top=2pt,
      bottom=2pt
    }
  ]
  \begin{minted}[
    breaklines=true,
    breakanywhere=true,
    samepage=false,
    fontsize=\footnotesize,
    linenos=true,
    numbersep=5pt,
    bgcolor=codebackground,
    frame=none,
    autogobble=true
  ]{#1}%
}{%
  \end{minted}
  \end{tcolorbox}%
}

% 参考文献管理
\RequirePackage[
  backend=biber,
  style=gb7714-2015,
  citestyle=gb7714-2015,
  sorting=none,
  maxbibnames=99,
  maxcitenames=2,
  giveninits=true,
  doi=false,
  isbn=false,
  url=false,
  eprint=false
]{biblatex}

% 添加参考文献文件
\addbibresource{bibliography.bib}

% 索引
\RequirePackage{makeidx}
\makeindex

% 页眉页脚
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\leftmark}
\fancyhead[R]{\rightmark}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% 章节标题样式
\RequirePackage{titlesec}

% 章标题样式
\titleformat{\chapter}[display]
  {\normalfont\huge\bfseries\color{primarycolor}}
  {\chaptertitlename\ \thechapter}{20pt}{\Huge}

% 节标题样式
\titleformat{\section}
  {\normalfont\Large\bfseries\color{primarycolor}}
  {\thesection}{1em}{}

% 小节标题样式
\titleformat{\subsection}
  {\normalfont\large\bfseries\color{primarycolor}}
  {\thesubsection}{1em}{}

% 小小节标题样式
\titleformat{\subsubsection}
  {\normalfont\normalsize\bfseries\color{primarycolor}}
  {\thesubsubsection}{1em}{}

% 目录样式
\RequirePackage{tocloft}
\renewcommand{\cftchapfont}{\bfseries\color{primarycolor}}
\renewcommand{\cftsecfont}{\color{primarycolor}}
\renewcommand{\cftsubsecfont}{\color{secondarycolor}}

% 浮动体标题
\RequirePackage{caption}
\DeclareCaptionStyle{mystyle}{
  font=small,
  labelfont={bf,color=primarycolor},
  textfont=normal,
  justification=centering,
  singlelinecheck=false
}
\captionsetup{style=mystyle}

% 定义高亮框环境
\RequirePackage{tcolorbox}
\tcbuselibrary{most}

% 定义框样式
\tcbset{
  base/.style={
    enhanced,
    breakable,
    arc=3mm,
    outer arc=3mm,
    boxrule=0.5pt,
    left=8pt,
    right=8pt,
    top=8pt,
    bottom=8pt,
    fonttitle=\bfseries,
    coltitle=white,
    attach boxed title to top left={yshift=-2mm,xshift=8mm},
    boxed title style={
      arc=2mm,
      outer arc=2mm,
      boxrule=0pt,
      left=4pt,
      right=4pt,
      top=2pt,
      bottom=2pt
    },
    % 跨页设置
    break at=-\baselineskip/0pt,
    pad at break*=2mm,
    before upper*={\parindent0pt}
  }
}

% 定义各种高亮框
\newtcolorbox{infobox}[1][]{
  base,
  colback=infocolor!10,
  colframe=infocolor,
  colbacktitle=infocolor,
  title=信息,
  #1
}

\newtcolorbox{warningbox}[1][]{
  base,
  colback=warningcolor!10,
  colframe=warningcolor,
  colbacktitle=warningcolor,
  title=警告,
  #1
}

\newtcolorbox{errorbox}[1][]{
  base,
  colback=errorcolor!10,
  colframe=errorcolor,
  colbacktitle=errorcolor,
  title=错误,
  #1
}

\newtcolorbox{successbox}[1][]{
  base,
  colback=successcolor!10,
  colframe=successcolor,
  colbacktitle=successcolor,
  title=成功,
  #1
}

\newtcolorbox{definitionbox}[1][]{
  base,
  colback=primarycolor!10,
  colframe=primarycolor,
  colbacktitle=primarycolor,
  title=定义,
  #1
}

\newtcolorbox{theorembox}[1][]{
  base,
  colback=accentcolor!10,
  colframe=accentcolor,
  colbacktitle=accentcolor,
  title=定理,
  #1
}

\newtcolorbox{examplebox}[1][]{
  base,
  colback=secondarycolor!10,
  colframe=secondarycolor,
  colbacktitle=secondarycolor,
  title=例子,
  #1
}

\newtcolorbox{codebox}[1][]{
  base,
  colback=codebackground,
  colframe=primarycolor,
  colbacktitle=primarycolor,
  title=代码,
  #1
}

% 自定义命令
\newcommand{\highlight}[1]{\colorbox{yellow!30}{#1}}
\newcommand{\important}[1]{\textcolor{errorcolor}{\textbf{#1}}}
\newcommand{\note}[1]{\textcolor{infocolor}{\textit{#1}}}

% 封面设置
\newcommand{\booktitle}[1]{\gdef\@booktitle{#1}}
\newcommand{\booksubtitle}[1]{\gdef\@booksubtitle{#1}}
\newcommand{\bookauthor}[1]{\gdef\@bookauthor{#1}}
\newcommand{\bookinstitution}[1]{\gdef\@bookinstitution{#1}}
\newcommand{\bookdate}[1]{\gdef\@bookdate{#1}}

% 默认值
\booktitle{数学建模教材}
\booksubtitle{理论与应用}
\bookauthor{作者姓名}
\bookinstitution{机构名称}
\bookdate{\today}

% 重新定义 \maketitle
\renewcommand{\maketitle}{
  \begin{titlepage}
    \centering
    \vspace*{2cm}
    
    % 标题
    {\Huge\bfseries\color{primarycolor}\@booktitle\par}
    \vspace{1cm}
    {\Large\color{secondarycolor}\@booksubtitle\par}
    \vspace{2cm}
    
    % 作者
    {\Large\@bookauthor\par}
    \vspace{1cm}
    {\large\@bookinstitution\par}
    
    \vfill
    
    % 日期
    {\large\@bookdate\par}
    \vspace{1cm}
    
  \end{titlepage}
  \cleardoublepage
}

% 数学定理环境
\RequirePackage{amsthm}
\RequirePackage{thmtools}

% 定理样式
\declaretheoremstyle[
  spaceabove=6pt,
  spacebelow=6pt,
  headfont=\bfseries\color{primarycolor},
  notefont=\mdseries,
  notebraces={(}{)},
  bodyfont=\normalfont,
  postheadspace=1em,
  numberwithin=section
]{mytheoremstyle}

\declaretheoremstyle[
  spaceabove=6pt,
  spacebelow=6pt,
  headfont=\bfseries\color{accentcolor},
  notefont=\mdseries,
  notebraces={(}{)},
  bodyfont=\normalfont,
  postheadspace=1em,
  numberwithin=section
]{mydefinitionstyle}

\declaretheoremstyle[
  spaceabove=6pt,
  spacebelow=6pt,
  headfont=\bfseries\color{successcolor},
  notefont=\mdseries,
  notebraces={(}{)},
  bodyfont=\normalfont,
  postheadspace=1em,
  numberwithin=section
]{myexamplestyle}

% 定义定理环境
\declaretheorem[style=mytheoremstyle,name=定理]{theorem}
\declaretheorem[style=mydefinitionstyle,name=定义]{definition}
\declaretheorem[style=myexamplestyle,name=例子]{example}
\declaretheorem[style=mytheoremstyle,name=引理]{lemma}
\declaretheorem[style=mytheoremstyle,name=推论]{corollary}
\declaretheorem[style=mydefinitionstyle,name=性质]{property}

% 证明环境
\renewenvironment{proof}[1][\proofname]{
  \par\pushQED{\qed}
  \normalfont\topsep6\p@\@plus6\p@\relax
  \trivlist\item[\hskip\labelsep\bfseries\color{primarycolor}#1\@addpunct{.}]\ignorespaces
}{
  \popQED\endtrivlist\@endpefalse
}

% 行距设置
\RequirePackage{setspace}
\onehalfspacing

% 段落设置
\setlength{\parindent}{2em}
\setlength{\parskip}{0.5ex plus 0.2ex minus 0.2ex}

% 列表设置
\RequirePackage{enumitem}
\setlist{nosep}
\setlist[itemize]{leftmargin=2em}
\setlist[enumerate]{leftmargin=2em}
\setlist[description]{leftmargin=2em}

% 脚注设置
\RequirePackage[bottom]{footmisc}
\setlength{\footnotesep}{0.5cm}

% 超链接设置
\hypersetup{
  colorlinks=true,
  linkcolor=primarycolor,
  filecolor=primarycolor,
  urlcolor=primarycolor,
  citecolor=primarycolor,
  bookmarks=true,
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=1,
  breaklinks=true,
  pdfborder={0 0 0},
  pdfpagemode=UseOutlines,
  plainpages=false,
  pdfpagelabels=true
}

% cleveref 设置将在 config.tex 中进行

% 其他设置
\RequirePackage{microtype}
\RequirePackage{xspace}

% 结束文档类定义
\endinput 