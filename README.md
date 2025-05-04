## ddns-go-installer

这是一个适用于 **Asus Merlin 固件** 的 ddns-go 自动安装脚本，支持自动识别 U 盘挂载路径并部署指定版本的 ddns-go，设置守护脚本和路由器的开机自启动。

### 特性

- 自动识别挂载的U盘路径
- 下载并安装 ddns-go v6.9.1
- 自动创建守护脚本，确保服务持续运行
- 自动配置/jffs/scripts/post-mount实现重启后自启动

### 使用方式

在 Asus Merlin 路由器的 SSH 中运行以下命令即可自动安装：

```sh
wget -O - https://raw.githubusercontent.com/Mao2334/ddns-go-installer/master/install.sh | sh
```

### 环境要求

- 路由器已开启 SSH 并插入可写的 U 盘
- U 盘建议格式为 ext3/ext4
- 路由器架构为 ARM64
