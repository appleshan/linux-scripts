#!/bin/bash
rclone_config="~/Dropbox/projects/dotfiles/bin/net/rclone"
cd ${rclone_config}

# 备份 apple-data 文件到 dropbox
proxychains4 \
    rclone sync \
    ~/Dropbox/apple-data/ dropbox:apple-data

# 备份 projects 文件到 dropbox
proxychains4 \
    rclone sync \
    ~/Dropbox/projects/ dropbox:projects

# 备份 org-gtd 文件到 dropbox
proxychains4 \
    rclone sync \
    ~/Dropbox/org-gtd/ dropbox:org-gtd

# 备份 org-notes 文件到 dropbox
proxychains4 \
    rclone sync \
    --exclude-from exclude-file.txt \
    ~/Dropbox/org-notes/ dropbox:org-notes

# 备份 hacker-notes 文件到 dropbox
proxychains4 \
    rclone sync \
    --exclude-from exclude-file.txt \
    ~/Dropbox/hacker-notes/ dropbox:hacker-notes

# 备份 keys 文件到 dropbox
proxychains4 \
    rclone sync \
    ~/Dropbox/keys/ dropbox:keys

# 软件许可证
# 备份 软件许可证 文件到 dropbox
proxychains4 \
    rclone sync \
    ~/Dropbox/软件许可证/ dropbox:软件许可证

