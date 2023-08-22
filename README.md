# clash_meta_gateway

使用Clash meta将你的Linux变身为网关服务器

使用前需先关闭宿主机53端口，Debian/Ubuntu系统可以参考以下方法：

```
echo "DNS=223.5.5.5" >> /etc/systemd/resolve.conf
echo "DNSStubListener=no" >> /etc/systemd/resolve.conf
systemctl restart systemd-resolved.service
```

### 使用方法：

```
docker run -d \
  --name clash_meta_gateway \
  --privileged \
  --network=host \
  -e SUBS_URL="你的Clash订阅地址" \
  bjzhou1990/clash_meta_gateway:latest
```

* 管理面板: `宿主机IP:9090/ui`
* Clash后端接口：`宿主机IP:9090` (首次进入管理面板时需手动添加)
* 网关地址：`宿主机IP`
* DNS服务器地址：`宿主机IP`

内置配置文件路径为`/data/config.yaml`， 有需要可以自行修改

### 已知问题:

* docker启动后再关闭会导致宿主机无法上网，重启可解决
