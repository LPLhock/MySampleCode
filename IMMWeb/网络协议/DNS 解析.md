# DNS 解析

## 简介

有服务 域名到 IP 的映射, DNS 解析请求采用 UDP 数据包, 且明文传输

## DNS 解析查询方式

* 递归查询
![AFbcIH.jpg](https://s2.ax1x.com/2019/03/13/AFbcIH.jpg)

* 迭代查询

![AFb4QP.md.jpg](https://s2.ax1x.com/2019/03/13/AFb4QP.md.jpg)
速度相对更快

## DNS 解析中存在什么问题

* DNS 劫持:  当 客户端与 DNS 服务器发送请求, 由于其采用 UDP 并且是明文传输, 可能遇到中间人攻击, 遇到个 钓鱼 DNS 服务器, 其返回给我们一个钓鱼 IP.  其与 HTTP 是完全没有关系, 是在 HTTP 链接建立之前 。
  DNS 解析请求使用 UDP 数据报, 一般使用 53 端口号 
* DNS 解析转发:  ![AFqrpn.jpg](https://s2.ax1x.com/2019/03/13/AFqrpn.jpg) 造成跨网访问, 可能我们用的移动运营商, 但是其转发到了电信, 最终可能到达权威  DNS, 那么权威 DNS 会返回默认的 电信对应 IP, 但是我们使用的是移动网络, 在去访问电信 IP , 可能就会导致网速过慢的情况。


## 如何解决 DNS 劫持

* HTTPDNS. 其实就是 IP 直连的方式. 119.29.29.29 连接到一个专门做 HTTPDNS 的服务器, 后面携带网站域名。 同时也会携带客户端 IP 地址。 其会返回一直 对应网站的 IP 地址, 规避了 DNS 劫持。![AFLwDK.jpg](https://s2.ax1x.com/2019/03/13/AFLwDK.jpg)
* 长连接方案: ![AFL3EF.jpg](https://s2.ax1x.com/2019/03/13/AFL3EF.jpg)

使用 HTTP 协议像 DNS 服务器的 80 端口进行请求.

