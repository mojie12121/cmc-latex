#requires -Version 7.0
<#
.SYNOPSIS
  检查 30 套试题与答案的结构一致性。
.DESCRIPTION
  逐套检查题号数量、分值总和、答案条目数和解答环境数量。
  任何一项不一致时以非零状态退出，便于本地和 CI 使用。
#>
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$questionDir = Join-Path $root 'content'
$answerDir = Join-Path $root 'answers\content'

$questionFiles = @(Get-ChildItem -LiteralPath $questionDir -Filter '*.tex' -File | Sort-Object Name)
$answerFiles = @(Get-ChildItem -LiteralPath $answerDir -Filter '*.tex' -File | Sort-Object Name)

if ($questionFiles.Count -ne 30) {
    throw "试题文件数量为 $($questionFiles.Count)，应为 30。"
}
if ($answerFiles.Count -ne 30) {
    throw "答案文件数量为 $($answerFiles.Count)，应为 30。"
}

$rows = foreach ($q in $questionFiles) {
    $answerPath = Join-Path $answerDir $q.Name
    if (-not (Test-Path -LiteralPath $answerPath)) {
        throw "缺少答案文件：$($q.Name)"
    }

    $qText = Get-Content -LiteralPath $q.FullName -Raw
    $aText = Get-Content -LiteralPath $answerPath -Raw

    $itemCount = ([regex]::Matches($qText, '\\item\[')).Count
    $questionPoints = 0
    foreach ($m in [regex]::Matches($qText, '本题(?:满分)?\s*(\d+)\s*分')) {
        $questionPoints += [int]$m.Groups[1].Value
    }

    $answerCount = ([regex]::Matches($aText, '\\answerproblem')).Count
    $answerPoints = 0
    foreach ($m in [regex]::Matches($aText, '\\answerproblem\{[^}]*\}\{(\d+)\}')) {
        $answerPoints += [int]$m.Groups[1].Value
    }
    $solutionCount = ([regex]::Matches($aText, '\\begin\{solution\}')).Count

    $ok = ($itemCount -eq $answerCount) -and
          ($itemCount -eq $solutionCount) -and
          ($questionPoints -eq 100) -and
          ($answerPoints -eq 100)

    [pscustomobject]@{
        File      = $q.Name
        Problems  = $itemCount
        QPoints   = $questionPoints
        Answers   = $answerCount
        APoints   = $answerPoints
        Solutions = $solutionCount
        OK        = $ok
    }
}

$rows | Format-Table -AutoSize

$bad = @($rows | Where-Object { -not $_.OK })
if ($bad.Count -gt 0) {
    Write-Host "`n$($bad.Count) 套试卷未通过检查。" -ForegroundColor Red
    exit 1
}

Write-Host "`n全部 30 套试卷通过结构检查。" -ForegroundColor Green
