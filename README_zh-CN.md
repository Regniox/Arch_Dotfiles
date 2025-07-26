# 我的 Arch Linux 配置

## Install Arch Linux

安装过程请参考 [Arch Linux Wiki]("https://wiki.archlinux.org/title/Installation_guide")，下面仅供安装参考。

### 系统引导

1. 安装 `pacman -S grub efibootmgr os-prober`
2. 按照下面操作

```Shell
mkdir -r /boot/grub
grub-mkconfig > /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```

### 创建用户

因为 Hyprland 要普通用户才可以启动，所以我要先创建一个普通用户并且设置密码。

```Shell
useradd -m [UserName]
passwd [UserName]
```

### 输入法

```Shell
sudo pacman -S fcitx5-im fcitx5-chinese-addons
```

编辑 `/etc/environment` 添加以下内容：

```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
```

> 其实不用添加了，因为在我的 Hyprland 配置里面已经添加过了，除非你不使用我的 Hyprland 的配置文件。

### 声音驱动
1. 安装驱动：`sudo pacman -S sof-firmware alsa-firmware alsa-ucm-conf`

2. 安装 PipeWire：`sudo pacman -S pipwire pipwire-audio pipwire-alsa pipwire-pulse jack2`

3. 安装 TUI 管理器：`sudo pacman -S wiremix`

### OBS-Studio

`sudo pacman -S obs-studio xdg-desktop-portal xdg-desktop-portal-hyprland`

### Dae 代理

1. 编辑 `/etc/pacman.conf` 添加 `Archlinuxcn`

```conf
[archlinuxcn]
Server = https//mirrors.ustc.edu.cn/archlinuxcn/$arch
```

2. `sudo pacman -S archlinuxcn-keyring`

3. `sudo pacman -S paru`

4. 安装 Dae
最新稳定版（针对 x86-64 v3/AVX2 优化）

```Shell
[yay/paru] -S dae-avx2-bin
```

最新稳定版（x86-64 或 aarch64 通用版）

```Shell
[yay/paru] -S dae
```

<details>
<summary>我的 Dae 配置</summary>
  
  编辑 /etc/dae/config.dae

  ```Shell
  global {
    tproxy_port: 10307
    tproxy_port_protect: true
    pprof_port: 0
    so_mark_from_dae: 0
    log_level: info
    disable_waiting_network: false
    enable_local_tcp_fast_redirect: false
    #lan_interface: docker0
    wan_interface: auto
    auto_config_kernel_parameter: true
    tcp_check_url: 'http://cp.cloudflare.com,1.1.1.1,2606:4700:4700::1111'
    tcp_check_http_method: HEAD
    udp_check_dns: 'dns.google:53,8.8.8.8,2001:4860:4860::8888'
    check_interval: 30s
    check_tolerance: 50ms
    dial_mode: domain
    allow_insecure: false
    sniffing_timeout: 100ms
    tls_implementation: tls
    utls_imitate: chrome_auto
    mptcp: false
    bandwidth_max_tx: '200 mbps'
    bandwidth_max_rx: '1 gbps'
  }

  subscription {
    '这里填你的订阅链接'
  }

  dns {
    upstream {
      alidns: 'udp://dns.alidns.com:53'
      googledns: 'tcp+udp://dns.google:53'
    }
    routing {
      request {
        qname(geosite:cn) -> alidns
        fallback: googledns
      }
    }
  }

  group {
    proxy {
      filter: name(keyword: '美国')
      policy: min_moving_avg
    }
  }

  routing {
    pname(NetworkManager) -> direct
    dip(224.0.0.0/3, 'ff00::/8') -> direct
    dip(geoip:private) -> direct
    l4proto(udp) && dport(443) -> block
    dip(geoip:cn) -> direct
    domain(geosite:cn) -> direct
    fallback: proxy
  }
  ```

</details>

## Application

如果想要完整的使用配置需安装这些。

|   程序                  |   名字         |
|:----------------------:|----------------|
| Window Manager         | Hyprland       |
| Terminal               | Kitty          |
| Shell                  | Fish           |
| Bar                    | waybar         |
| Application Launcher   | fuzzel         |
| Notification Daemon    | Mako           |
| Input method framework | Fcitx5         |
| Clipboard              | wl-clipboard   |
| Screenshot             | grim, slurp    |
| File Manager           | yazi           |
| Voice Control          | wiremix        |

> **注意：** 因为个人喜欢使用 TUI, ALL IN TERMINAL, 所以 `yazi`、`wiremix` 是会打开浮动的终端窗口，详细见 /hypr/configs/windowrule.conf.

## Keybinds

你可以在 `~/.config/hypr/configs/keybinds.conf` 里找到并修改。

| 基础按键      | 说明                    |
|---------------|-------------------------|
| Super + Enter | 终端                    |
| Super + Tab   | Fuzzel menu             |
| Super + E     | Yazi FileManger      |
| Super + C     |  关闭窗口               |
| Super + M     | 退出 Hyprland           |
| Super + X     | 与下一个窗口换位置      |
| Super + F     | 窗口浮动                |
| Super + P     | Pseudo                  |
| Super + W     | 上下分割窗口            |
| Super + H     | 聚焦左窗口              |
| Super + L     | 聚焦右窗口              |
| Super + K     | 聚焦上窗口              |
| Super + J     | 聚焦下窗口              |
| Super + Up    | 窗口高度 + 50           |
| Super + Down  | 窗口高度 - 50           |
| Super + Right | 窗口宽度 + 50           |
| Super + Left  | 窗口宽度 - 50           |
| Super + Q     | 打开特殊工作区          |
| Super + Shift + Q | 将窗口转到特殊工作区|

| 拓展功能按键    | 说明                   |
|-----------------|------------------------|
| Shift + ALT + S | 选择截图               |
| Super + S       | 全屏截图               |
| Super + F6      | 增加亮度               |
| Super + F5      | 降低亮度               |
