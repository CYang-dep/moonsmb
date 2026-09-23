# MoonSMB duplication check

- 检查日期：2026-09-23
- 候选：MoonSMB，SMB2/SMB3 文件共享协议消息编解码和互操作基础库。
- 状态：通过初步查重，已获参赛者确认，进入实现阶段。

## 检索范围

执行了本地 MoonBit 包检索：

- `moon search smb --limit 100`
- `moon search cifs --limit 100`
- `moon search file sharing --limit 100`
- `moon search protocol --limit 100`

并检查了 GitHub/MoonBit 生态中与网络协议、文件系统、PCAP、HTTP、DNS、SMBus 相关的项目边界。

## 结果

`moon search smb` 唯一相关结果是 `sbqrre/moonbit-mcu-hal/src/i2c` 中的 SMBus 寄存器总线辅助 API。SMBus 是 I2C 外设访问协议，不处理 Windows/Linux 文件共享、SMB2 header、session/tree/file identifier 或 compound request，因此不构成功能重合。

`moon search cifs` 未发现模块。当前 registry 中的 MoonFuse 是 FUSE 用户态文件系统协议，工作流是 Linux kernel FUSE request/reply/session lifecycle；MoonSMB 的工作流是网络文件共享协议 frame codec 与互操作验证，核心数据、传输协议和使用者不同，不构成功能重复。

现有 HTTP、DNS、PCAP、OpenTelemetry 项目属于不同协议和不同消息模型，未发现 SMB2/SMB3 消息库。

## 差异化边界

MoonSMB 的核心不是通用二进制解析器，也不是文件系统实现，而是可被客户端、测试工具、备份工具和协议分析器复用的 SMB2/SMB3 typed message layer。首版不实现完整 server、Kerberos/NTLM、内核驱动和加密传输，避免与操作系统组件或完整 Samba 项目重叠。

## 上游与实现方式

- 上游规范：Microsoft MS-SMB2 公开协议文档。
- 参考互操作：Samba 公开行为和协议测试资料。
- 实现方式：独立 MoonBit 重写；不复制 Microsoft 或 Samba 源码。
- 许可处理：项目代码采用 MIT；上游规范和参考资料在 NOTICE 中单独说明。

## 决策

通过初步查重，允许开始实现。后续若 MoonCakes 出现直接 SMB2/SMB3 实现，必须重新评估项目边界并优先考虑协作或扩展已有项目。
