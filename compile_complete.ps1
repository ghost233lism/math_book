#!/usr/bin/env pwsh

Write-Host "========================================" -ForegroundColor Green
Write-Host "数学建模教材完整编译脚本" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# 检查必要的工具
Write-Host "检查必要工具..." -ForegroundColor Yellow

# 检查XeLaTeX
if (-not (Get-Command xelatex -ErrorAction SilentlyContinue)) {
    Write-Host "错误：未找到 xelatex 命令！" -ForegroundColor Red
    Write-Host "请确保已安装 TeX Live 或 MiKTeX" -ForegroundColor Red
    Read-Host "按任意键退出"
    exit 1
}

# 检查Biber
if (-not (Get-Command biber -ErrorAction SilentlyContinue)) {
    Write-Host "错误：未找到 biber 命令！" -ForegroundColor Red
    Write-Host "请确保已安装 Biber 参考文献处理器" -ForegroundColor Red
    Read-Host "按任意键退出"
    exit 1
}

# 检查Python和Pygments
try {
    python -c "import pygments; print('Pygments 版本:', pygments.__version__)"
    Write-Host "✓ Python 和 Pygments 已安装" -ForegroundColor Green
} catch {
    Write-Host "警告：Python 或 Pygments 未安装，minted 代码高亮可能无法工作" -ForegroundColor Yellow
    Write-Host "请运行：pip install Pygments" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "开始编译..." -ForegroundColor Green

# 清理旧的辅助文件
Write-Host "清理旧文件..." -ForegroundColor Yellow
$filesToClean = @("*.aux", "*.bbl", "*.bcf", "*.blg", "*.fdb_latexmk", "*.fls", "*.idx", "*.ind", "*.lof", "*.log", "*.lot", "*.out", "*.run.xml", "*.synctex.gz", "*.toc", "*.xdv", "*.aex")
foreach ($pattern in $filesToClean) {
    if (Test-Path $pattern) {
        Remove-Item $pattern -Force
        Write-Host "已删除 $pattern" -ForegroundColor Gray
    }
}

# 清理minted缓存
if (Test-Path "_minted-main") {
    Remove-Item "_minted-main" -Recurse -Force
    Write-Host "已删除 minted 缓存" -ForegroundColor Gray
}

Write-Host ""

# 第一次编译
Write-Host "第一次编译（生成辅助文件）..." -ForegroundColor Yellow
$result1 = & xelatex -shell-escape -interaction=nonstopmode main.tex
if ($LASTEXITCODE -ne 0) {
    Write-Host "第一次编译失败！" -ForegroundColor Red
    Write-Host "请检查 main.log 文件查看详细错误信息" -ForegroundColor Red
    Read-Host "按任意键退出"
    exit 1
}

# 编译参考文献
Write-Host "编译参考文献..." -ForegroundColor Yellow
$result2 = & biber main 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "参考文献编译失败！" -ForegroundColor Red
    Write-Host "请检查 main.blg 文件查看详细错误信息" -ForegroundColor Red
    Write-Host "继续编译..." -ForegroundColor Yellow
}

# 第二次编译（处理参考文献）
Write-Host "第二次编译（处理参考文献）..." -ForegroundColor Yellow
$result3 = & xelatex -shell-escape -interaction=nonstopmode main.tex
if ($LASTEXITCODE -ne 0) {
    Write-Host "第二次编译失败！" -ForegroundColor Red
    Write-Host "请检查 main.log 文件查看详细错误信息" -ForegroundColor Red
    Read-Host "按任意键退出"
    exit 1
}

# 第三次编译（确保交叉引用正确）
Write-Host "第三次编译（确保交叉引用正确）..." -ForegroundColor Yellow
$result4 = & xelatex -shell-escape -interaction=nonstopmode main.tex
if ($LASTEXITCODE -ne 0) {
    Write-Host "第三次编译失败！" -ForegroundColor Red
    Write-Host "请检查 main.log 文件查看详细错误信息" -ForegroundColor Red
    Read-Host "按任意键退出"
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "编译完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# 检查编译结果
if (Test-Path "main.pdf") {
    $fileInfo = Get-Item "main.pdf"
    Write-Host "✓ PDF 文件已生成成功！" -ForegroundColor Green
    Write-Host "文件大小: $([math]::Round($fileInfo.Length / 1MB, 2)) MB" -ForegroundColor Cyan
    Write-Host "修改时间: $($fileInfo.LastWriteTime)" -ForegroundColor Cyan
    Write-Host "文件位置: $($fileInfo.FullName)" -ForegroundColor Cyan
    
    # 询问是否打开PDF
    $openPdf = Read-Host "是否打开 PDF 文件？(y/n)"
    if ($openPdf -eq 'y' -or $openPdf -eq 'Y') {
        Start-Process "main.pdf"
    }
} else {
    Write-Host "✗ PDF 文件未生成，编译可能失败" -ForegroundColor Red
    Write-Host "请检查 main.log 文件查看详细错误信息" -ForegroundColor Red
}

Write-Host ""
Write-Host "编译统计:" -ForegroundColor Blue
Write-Host "- 主文件: main.tex" -ForegroundColor Gray
Write-Host "- 编译器: XeLaTeX" -ForegroundColor Gray
Write-Host "- 参考文献: Biber" -ForegroundColor Gray
Write-Host "- 代码高亮: minted + Pygments" -ForegroundColor Gray
Write-Host "- 编译次数: 3次 + 1次参考文献" -ForegroundColor Gray

Read-Host "按任意键退出" 