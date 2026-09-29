# MoonSMB

MoonSMB 是一个使用 MoonBit 实现的 SMB2/SMB3 协议消息编解码库，面向需要进行文件共享协议互操作、抓包分析、代理开发和协议测试的工具与服务。项目聚焦协议层：提供类型化消息模型、边界安全的 little-endian 编解码、复合消息处理、NT status 诊断和目录项解析，不绑定具体网络传输或认证实现。

## 项目目标

- 为 MoonBit 程序提供可复用的 SMB2/SMB3 wire-format 基础设施；
- 在解析截断包、错误偏移、未知命令和非法长度时返回结构化错误，而不是越界访问；
- 让协议 fixture、代理、客户端上层和互操作测试可以共享同一套数据模型。

当前实现覆盖 NEGOTIATE、SESSION_SETUP、TREE_CONNECT、CREATE、READ、WRITE、CLOSE、QUERY_DIRECTORY 等常用消息模型，以及 SMB2 header、compound packet、能力位、状态码和目录记录辅助函数。

## 安装

需要 MoonBit 工具链（`moonc >= 0.10.14`，建议使用最新稳定版）。在 MoonBit 工程中添加：

```bash
moon add CYang-dep/moonsmb@0.1.0
```

## 最小使用

下面的代码构造一个 SMB2 NEGOTIATE 请求体，加入 header 后编码为线上的消息：

```moonbit
let body = @smb.negotiate_body([0x0202U, 0x0210U, 0x0302U, 0x0311U], 1U, @smb.CAP_LARGE_MTU)
let payload = @smb.encode_negotiate(body)
let packet = @smb.encode_frame(@smb.frame(
  @smb.header(@smb.COMMAND_NEGOTIATE, 1U, 0U, 1U, 0U, 1UL, 0U, 0UL, 0U, payload.length().reinterpret_as_uint()),
  payload,
))
```

解析时可以使用 `parse_frame`、`decode_compound` 和 `diagnostic_for`；边界错误都通过 `Result[_, ProtocolError]` 返回。

## 可运行示例

仓库包含三个可执行最小样例，可从项目根目录复现：

```bash
moon run examples/negotiate
moon run examples/file-read
moon run examples/diagnostic
```

- `examples/negotiate`：构造并解析 NEGOTIATE 帧，检查 SMB2 签名；
- `examples/file-read`：处理 READ 响应，展示状态码、返回字节数和完成状态；
- `examples/diagnostic`：输入截断帧，输出稳定的错误码、偏移和诊断信息。

## 开发与验收

```bash
moon check --deny-warn
moon build --target native --deny-warn
moon test --deny-warn
moon info
moon fmt --check
```

GitHub Actions 会在 push 和 pull request 中执行检查、native 构建、测试、接口生成、三个示例运行和格式检查。

## 范围边界

MoonSMB 不实现完整 SMB server、内核文件系统驱动、Kerberos/NTLM 认证服务端、socket 传输层或加密会话。认证和传输通过上层可替换接口保留扩展边界。

## 来源与许可证

项目依据 Microsoft [MS-SMB2] 公开协议文档和 Samba 互操作行为进行独立 MoonBit 重写，不复制上游实现代码。协议参考和项目范围见 [NOTICE](NOTICE)。项目采用 MIT License。
