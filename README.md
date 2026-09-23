# MoonSMB

MoonBit 的 SMB2/SMB3 协议消息编解码与互操作基础库。

> 项目处于初始开发阶段，目标是提供协议层能力，不是实现完整 SMB 文件服务器。

## 目标

MoonSMB 面向需要处理 Windows/Linux 文件共享协议的 MoonBit 开发者，提供 SMB2/SMB3 请求与响应的类型化模型、边界安全的 little-endian 编解码、复合消息、NT status 诊断、协商能力和目录查询数据结构。

## 计划范围

- SMB2 固定头与 command dispatch
- NEGOTIATE、SESSION_SETUP、TREE_CONNECT
- CREATE、READ、WRITE、CLOSE
- QUERY_DIRECTORY 与目录项解析
- NT status、flags、credits 和长度校验
- compound request/response
- mock transport、协议 fixtures 和三个可运行示例

## 明确不做

本项目不实现完整 SMB server、内核文件系统驱动、Kerberos/NTLM 认证服务端和加密传输层。认证与传输将通过可替换接口保留扩展边界。

## 来源与许可

项目依据 Microsoft [MS-SMB2] 公开协议文档和 Samba 互操作行为进行独立 MoonBit 重写，不复制上游实现代码。来源、范围与查重记录见 `NOTICE` 和 `docs/competition/duplicate-check.md`。

## 开发验证

```bash
moon check
moon test
moon info
moon fmt
```
