# gentoo-myrepo

```
cat > /etc/portage/repos.conf/gentoo-myrepo.conf << EOF
[gentoo-myrepo]
location = /var/db/repos/gentoo-myrepo
sync-type = git
sync-uri = https://github.com/imam-i/gentoo-myrepo.git
EOF
```
