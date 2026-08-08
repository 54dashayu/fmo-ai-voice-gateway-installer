# FMO AI Voice Gateway 公开安装入口

这是FMO AI Voice Gateway的公开、免登录安装仓库。它只用于分发安装引导脚本、经过校验的Release安装包和使用说明。

## 🚀 无需登录，一键下载安装

在受支持的Linux服务器执行：

```bash
curl -fsSL https://raw.githubusercontent.com/54dashayu/fmo-ai-voice-gateway-installer/main/install.sh -o /tmp/fmo-ai-install.sh
sh /tmp/fmo-ai-install.sh
```

不需要GitHub账号，不需要执行 `gh auth login`，也不需要手工填写版本号。

脚本会自动完成：

1. 查询最新公开Release。
2. 下载Linux安装包和SHA-256校验文件。
3. 校验安装包完整性；校验失败立即停止。
4. 解压并运行中文安装向导。
5. 安装依赖、AI网关、状态页面和systemd服务。

## 安全默认值

- 不覆盖现有EMQX、SAS/CA、Nginx、MySQL或其他业务服务。
- 不在此仓库保存百炼API Key、MQTT密码、NAS Token、证书或生产配置。
- 安装后AI、ASR、TTS、自动回复、定时报时和真实PTT全部保持关闭。
- 必须先完成只读检查和模拟验证，经过服务器管理员授权后才能测试真实PTT。

## 支持范围

| Linux发行版 | 架构 |
|---|---|
| Ubuntu 22.04 / 24.04 | x86_64、ARM64 |
| Debian 12 | x86_64、ARM64 |
| Rocky Linux / AlmaLinux 9 | x86_64、ARM64 |

## 手工下载安装

也可以从本仓库的 [Releases](https://github.com/54dashayu/fmo-ai-voice-gateway-installer/releases) 页面下载压缩包和对应的 `.sha256` 文件，校验后执行包内的 `install.sh`。

## 说明

FMO协议、目标服务器接入授权以及无线电操作责任由部署者确认。AI必须使用独立、明确的身份标识，不得冒充在线的真实持证呼号。
