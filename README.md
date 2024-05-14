- 此项目为[frps-panel](https://github.com/yhl452493373/frps-panel)的Docker版本

##  docker-compose用法(与[frps](https://github.com/stilleshan/frps)一同使用)
- 在启动容器前，需要预先创建`frps.toml`、`frps-panel.toml`、`frps-tokens.toml`并指定对应的映射关系，否则容器无法启动

`frps-panel.toml`示例
```toml
# frps-panel.toml
[common]
# frps panel config info
plugin_addr = "127.0.0.1"
plugin_port = 7200
#admin_user = "admin"
#admin_pwd = "admin"
# specified login state keep time
admin_keep_time = 0

# enable tls
tls_mode = false
# tls_cert_file = "cert.crt"
# tls_key_file = "cert.key"

# frp dashboard info
dashboard_addr = "127.0.0.1"
dashboard_port = 7500
dashboard_user = "admin"
dashboard_pwd = "admin"
```
```yml
version: "3.8"
services:
  frps:
      image: stilleshan/frps
      network_mode: host
      volumes:
        - /home/frp/frps.toml:/frp/frps.toml
  frps-panel:
      image: miku114514/frps-panel-docker
      network_mode: host
      volumes:
        - /home/frp/frps-panel.toml:/frps-panel/frps-panel.toml
        - /home/frp/frps-tokens.toml/frps-panel/frps-tokens.toml
```


