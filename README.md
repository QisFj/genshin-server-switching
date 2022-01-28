# genshin-server-switching

切换 PC 端官服到B服，自动按照这个视频描述的操作执行：

https://www.bilibili.com/video/BV1PQ4y127X3

2022年1月5日（2.4版本）测试有效。

脚本是一次性的（不幂等），目标场景是在网吧玩B服。

对于不允许执行脚本的情况，在 Powershell 中执行：

```powershell
Set-ExecutionPolicy Unrestricted
```