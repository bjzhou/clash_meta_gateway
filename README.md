# clash_meta_gateway

使用Clash meta将你的Linux变身为网关服务器

使用前需先关闭宿主机53端口，Debian/Ubuntu系统可以参考以下方法：

```
echo "DNS=223.5.5.5" >> /etc/systemd/resolve.conf
echo "DNSStubListener=no" >> /etc/systemd/resolve.conf
systemctl restart systemd-resolved.service
```

### Docker使用方法：

```
docker run -d \
  --name=clash_meta_gateway \
  --privileged \
  --network=host \
  --restart=always \
  -e SUBS_URL="你的Clash订阅地址" \
  bjzhou1990/clash_meta_gateway:latest
```

### 不使用Docker：

仅限支持systemd的系统，后续考虑支持OpenWRT

安装脚本：
```
bash -c "$(curl -L https://github.com/bjzhou/clash_meta_gateway/raw/master/install.sh)" @ 你的订阅地址
```

私人Github镜像
```
bash -c "$(curl -L https://cdn-gh.hinnka.com/bjzhou/clash_meta_gateway/raw/master/install.sh)" @ 你的订阅地址
```

卸载：
```
systemctl disable clash.service
systemctl stop clash.service
rm -rf /etc/systemd/system/clash.service
rm -rf /opt/clash
```


* 管理面板: `宿主机IP:9090/ui`
* Clash后端接口：`宿主机IP:9090` (首次进入管理面板时需手动添加)
* 网关地址：`宿主机IP`
* DNS服务器地址：`宿主机IP`

为保证功能完整性，配置文件由`clash_meta_gateway`完全接管，服务器订阅通过Proxy Provider的方式提供，默认1小时更新依次，也可以在管理面板手动更新。
内置配置文件路径为`/data/config.yaml`，有需要可以自行修改

