# deploy.ps1
hexo clean
hexo generate
Copy-Item -Path ".\public\*" -Destination "." -Recurse -Force
git add .
git commit -m "site update $(Get-Date -Format 'yyyyMMdd HH:mm')"
git push
Write-Host "✅ 部署完成！等待Github Pages生效"
