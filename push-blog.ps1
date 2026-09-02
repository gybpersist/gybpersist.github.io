<# deploy.ps1 #>
$ErrorActionPreference = "Stop"
try {
    Write-Host "1/5 清理旧文件: hexo clean"
    hexo clean
    if ($LASTEXITCODE -ne 0) { throw "hexo clean 执行失败" }

    Write-Host "2/5 编译静态页面: hexo generate"
    hexo generate
    if ($LASTEXITCODE -ne 0) { throw "hexo generate 编译失败" }

    Write-Host "3/5 复制public静态文件到根目录"
    Copy-Item -Path ".\public\*" -Destination "." -Recurse -Force
    if ($LASTEXITCODE -ne 0) { throw "Copy-Item 文件复制失败" }

    Write-Host "4/5 git 暂存变更"
    git add .
    if ($LASTEXITCODE -ne 0) { throw "git add 失败" }

    Write-Host "5/5 git 提交并推送"
    git commit -m "site update $(Get-Date -Format 'yyyyMMdd HH:mm')"
    git push
    if ($LASTEXITCODE -ne 0) { throw "git push 推送失败" }

    Write-Host "`n✅ 全部执行完毕！等待Github Pages生效"
}
catch {
    Write-Host "`n❌ 出错：$($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
