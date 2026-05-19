# Legal

此目录存放法律协议暂存稿（`staging/`）和 md-doc 仓库的本地缓存（`.cache/`）。

## staging/

渲染后的协议 Markdown，publish 前暂存于此。由 `publish_legal_docs.sh` 脚本同步到 `git@github.com:wangzz/md-doc.git` 仓库。

## .cache/

`publish_legal_docs.sh` 克隆的 md-doc 副本，**不进 git 仓库**（已在 `.gitignore` 中排除）。
