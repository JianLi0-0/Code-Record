初始化仓库

```console
git init
git add ...
git commit -m "..."
git branch -M main
git remote add origin https://github.com/xxx_xxx/xxx.git
git push -u origin main
```

下载远程仓库并融合

```
git fetch origin main(默认远程仓库名)
git log -p master..origin/main 或者 git log -p FETCH_HEAD
git merge origin/main
```

分支管理

```
git branch testing 新建分支testing
git checkout testing 让HEAD指向分支testing
git checkout -b new_branch 新建并访问new_branch
git log --oneline --decorate --graph --all 查看项目分叉历史
git branch -d testing 删除分支testing
```



