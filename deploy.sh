# 临时目录名变量
TEMP_DIR=../tmp_gitbook_0718

# 判断临时目录是否存在，如果存在则删除目录
if [ -d $TEMP_DIR ]; then
    rm -rf $TEMP_DIR
fi

# 创建临时目录
mkdir $TEMP_DIR

# 通过 gitbook 命令进行编译
gitbook install
gitbook build

# 提交主分支代码
git add .
git commit -m "update"
git push origin main

# 将编译后的文件复制到临时目录
cp -r _book/* $TEMP_DIR

# 切换到 gh-pages 分支
git checkout gh-pages

# 清空该分支下的所有文件
git rm -rf .

# 将临时目录中的文件复制到该分支
cp -r $TEMP_DIR/* .

# 提交到本地仓库
git add .

# 提交到远程仓库
git commit -m "publish book"

# 推送到远程仓库
git push origin gh-pages

# 切换回主分支
git checkout main

# 删除临时目录
rm -rf $TEMP_DIR
