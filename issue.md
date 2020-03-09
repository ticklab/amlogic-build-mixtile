# 问题说明

## rpm 打包问题

由于 python ncurses 问题，会导致使用 dnf 进行 rpm 包生成出现问题。

目前选择使用 ipk 软件包规避问题。修改办法为 修改 conf/local.conf 中的相关字段 ```PACKAGE_CLASSES ?= "package_ipk"```