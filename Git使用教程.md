远程开发：（以flatter_car_planning为例）
切换到本地flatter_car_planning分支

```
git checkout flatter_car_planning (不要直接在本地flatter_car_planning上修改)
```


新建分支

```
git checkout -b new_flatter_car_planning
```


在new_flatter_car_planning进行新功能开发，提交commits
更新远程仓库内容

```
git pull origin flatter_car_planning
```


在new_flatter_car_planning中融合更新的远程仓库内容

```
git merge flatter_car_planning
```


切换到flatter_car_planning并融合new_flatter_car_planning

```
git checkout flatter_car_planning
git merge new_flatter_car_planning
```


推送更新：

```
git push origin flatter_car_planning
```










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

删除远程分支

```
git remote
git remote remove origin
```



分支管理

```
git branch testing 新建分支testing
git checkout testing 让HEAD指向分支testing
git checkout -b new_branch 新建并访问new_branch
git log --oneline --decorate --graph --all 查看项目分叉历史
git branch -d testing 删除分支testing
```

版本管理

```
git log --pretty=oneline
git reset --hard HEAD^ # 回滚到上一个版本
git reset --hard 1078f # 回滚到指定版本
git reflog	# 要重返未来，查看命令历史，以便确定要回到未来的哪个版本
```



