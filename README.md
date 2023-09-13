# clash_meta_gateway

Clash Meta for OpenWRT

支持官方原版OpenWRT直接安装

由于TUN模式下部分游戏客户端访问异常，且偶尔会出现游戏高ping, 原因未知，新版本由TUN + fakeip模式修改为使用防火墙TPROXY转发，支持新版nftables和旧版iptables(iptables版本未测试)


安装脚本：
```
sh -c "$(curl -L  https://ghproxy.com/https://github.com/bjzhou/clash_meta_gateway/raw/openwrt/install.sh)" @ 你的订阅地址
```

卸载：
```
/etc/init.d/clash stop
rm -rf /etc/init.d/clash
rm -rf /opt/clash
```


* 管理面板: `宿主机IP:9090/ui`
* Clash后端接口：`宿主机IP:9090` (首次进入管理面板时需手动添加)

启动后会创建一个名为clash的网络接口并指定防火墙区域为lan，如果没有指定成功，请手动指定防火墙区域为lan

为保证功能完整性，配置文件由`clash_meta_gateway`完全接管，服务器订阅通过Proxy Provider的方式提供，默认1小时更新依次，也可以在管理面板手动更新。
内置配置文件路径为`/opt/clash/config.yaml`，有需要可以自行修改

