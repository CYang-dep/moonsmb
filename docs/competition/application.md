# MoonSMB 项目申报书

## 基本信息

- 项目名称：MoonSMB
- 参赛者：成欣阳
- 联系方式：2193772956@qq.com
- GitHub 仓库链接：https://github.com/CYang-dep/moonsmb
- 项目方向：系统基础设施 / SMB2、SMB3 网络文件共享协议
- 是否为移植项目：是，基于 Microsoft MS-SMB2 公开协议规范进行 MoonBit 独立实现

## 项目简介

MoonSMB 面向需要处理 SMB2/SMB3 文件共享协议的 MoonBit 开发者，提供类型化消息模型、边界安全的二进制编解码、命令校验、复合消息处理和稳定诊断。SMB 是 Windows 文件共享、NAS、企业文件服务、备份与跨系统协作的重要协议；目前 MoonBit 包生态尚未提供 SMB2/SMB3 协议层，开发者若要接入只能自行处理消息头、命令结构、状态码和复合帧，或者依赖进程外的系统工具，难以在 MoonBit 程序中进行跨平台协议测试和集成。

项目参考 Microsoft 发布的 MS-SMB2 公开协议规范，并通过 Samba 等成熟实现进行互操作行为验证；不复制上游源代码。MoonSMB 的目标是可复用协议组件，而非重新实现 Samba 或单一文件共享产品。其受众包含文件客户端、备份同步工具、协议分析器、互操作测试套件和网络服务开发者，与 MoonFuse 的 Linux 内核 FUSE 请求/响应生命周期不同，也不与 HTTP、DNS、PCAP 库共享核心协议模型。

### 预期使用场景

1. **共享目录浏览器**：客户端解析 NEGOTIATE、SESSION_SETUP、TREE_CONNECT、CREATE 与 QUERY_DIRECTORY 的响应，列出远程共享中的目录项，并输出协议层错误诊断。
2. **备份与文件同步工具**：按 READ/WRITE/CLOSE 消息模型读取远端文件、分块传输并验证返回长度和 NT status；传输和认证通过独立适配器注入。
3. **SMB 抓包检查器**：从 TCP 载荷中提供的 SMB2 帧解析 command、message id、credits、session/tree id 和 compound 边界，生成稳定的文本或 JSON 检查结果，用于排查兼容性问题。

## 核心功能范围

- SMB2 固定消息头、协议标识、命令号、message id、session/tree/file id、flags 与 credits 的类型化建模。
- 对 NEGOTIATE、SESSION_SETUP、TREE_CONNECT、CREATE、READ、WRITE、CLOSE、QUERY_DIRECTORY 等常用命令提供请求/响应结构和编解码。
- NT status 分类、结构长度校验、偏移范围校验、无效 flags 检查和确定性错误诊断。
- Compound message 的 next-command 链接、对齐和边界验证。
- 可替换传输与认证接口；协议模型可脱离真实网络使用 fixture 测试。
- 三个可运行示例：协商请求构造、文件读取响应解析、compound 报文诊断。
- **明确不做**：完整 SMB 文件服务器、Windows 内核驱动、Kerberos/NTLM 认证服务端、加密算法实现和未限定范围的 SMB1/CIFS 兼容层。

### 技术路径与关键理解

1. 以 MS-SMB2 固定头与命令结构为基准，明确 SMB2.0.2 至 SMB3.x 目标子集及未实现字段。
2. 采用受检 little-endian reader/writer；所有长度、相对偏移、计数和 compound 对齐均先验证再访问。
3. 通过 command-specific codec 将 raw command code 映射为 typed request/response，未知命令仍保留可诊断原始值。
4. 将 SMB status 与 MoonBit 错误分层，避免把协议错误、截断帧和传输失败混为一类。
5. 建立来自公开协议说明和 Samba/Windows 可互操作样本的 golden fixtures；使用截断、越界、错位、未知 command、错误 status 等负向用例验证解析健壮性。
6. 以可注入 transport/authenticator 隔离网络和身份协商，确保核心 codec 可在 wasm-gc、wasm、js 与 native 上复用；真实 SMB 网络传输按目标支持情况另行声明。

## 对标方案与量化指标

| 对标对象 | 定位 | MoonSMB 的关系与差异 |
|---|---|---|
| Samba | 成熟的 SMB/CIFS 客户端与服务器套件 | MoonSMB 不替代 Samba；聚焦可嵌入 MoonBit 项目的协议消息层，不实现完整服务端、身份体系和系统集成 |
| libsmb2 | C 语言 SMB2/3 用户态客户端库 | 作为成熟客户端互操作参考；MoonSMB 使用 MoonBit 类型模型和跨目标 codec，首版范围更窄且显式不含完整认证/加密 |
| 系统 smbclient | 可直接操作共享的命令行工具 | 可解决人工操作，但不能为 MoonBit 程序提供可组合的 typed API、离线 fixture 和协议级验证 |

量化验收目标：

- **协议覆盖**：首版实现至少 8 类常用命令的请求/响应结构，覆盖协商、会话、共享连接、打开、读写、关闭和目录查询。
- **边界健壮性**：对小于固定头长度、越界 offset/length、无效 compound 链接、非预期结构大小均返回稳定错误，不 panic、不越界。
- **复合帧正确性**：正确验证 `NextCommand` 的 8 字节对齐、递增和消息边界；无效链路被拒绝。
- **状态诊断**：至少覆盖常用成功、继续、重试、权限、路径、文件句柄和资源类 NT status，并保留未知状态码。
- **验证规模**：至少 150 个聚焦测试断言，覆盖有效样本、截断/越界输入、命令字段往返、状态映射和 compound 边界；目标争取 250 个以上。
- **跨目标**：对 wasm-gc、wasm、js、native 执行检查；在可用环境运行测试，并在 CI 中复现。
- **工程历史与规模**：不少于 2000 行有效 MoonBit 实现与测试代码；至少 20 个独立、有效、可审阅的项目提交。行数不计生成文件、构建产物和纯文档，提交数不以拆分或空提交凑数。

以上数字是项目验收目标而非已完成结果。最终申报前以实际代码统计、测试报告、CI 和提交审计为准；没有实现的命令不会表述为已支持。

## 项目价值与生态意义

SMB 连接桌面操作系统、NAS、企业共享盘、备份与跨系统文件服务，潜在使用者覆盖客户端开发、基础设施、运维、安全测试和数据迁移等多个领域。MoonSMB 为 MoonBit 提供从“能处理普通网络请求”迈向“能在语言内建模并验证主流文件共享协议”的基础组件，降低协议接入与测试门槛，并可被 GUI/CLI 文件工具、同步服务、归档/备份工具和网络分析项目复用。

该项目与完整 Samba 的定位不同：不追求替代成熟系统级产品，而是把可复用的 SMB2/3 消息模型和 codec 提供给 MoonBit 工程。清晰的支持矩阵、可注入传输、协议 fixtures 和负向边界测试有助于后续社区共同补齐命令覆盖，而不是形成一个封闭的单用途应用。

## 移植或参考说明

- 规范来源：Microsoft Open Specifications 的 **[MS-SMB2] Server Message Block Protocol Versions 2 and 3**，公开协议文档。
- 互操作参考：Samba 与 libsmb2 的公开行为、协议测试资料；不会复制其实现源代码。
- 移植范围：SMB2/3 消息结构、常用命令子集、状态码、compound framing 和协议诊断。
- 修改与适配：使用 MoonBit 类型、Result 错误模型、跨目标包组织和可注入接口表达协议能力。
- 暂不支持：完整 SMB server、完整身份验证与加密、SMB1、DFS/打印命名管道及未列入首版支持矩阵的扩展命令。
- 许可证：MoonSMB 自有代码采用 MIT；协议规范仅作为行为依据，不把规范文本或 Samba/libsmb2 代码复制进项目。最终实现和分发仍需逐项核对许可证与协议合规要求。
