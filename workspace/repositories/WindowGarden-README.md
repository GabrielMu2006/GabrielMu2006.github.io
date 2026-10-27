# Window Garden · 窗口花园

一个 macOS 桌面陪伴应用：**桌面上的一个 WidgetKit 小组件**，一座随你的使用状态慢慢生长的手绘小花园。
产品规格见 [SPEC.md](SPEC.md)，插画生成记录与换装指南见 [ART_PROMPTS.md](ART_PROMPTS.md)。

![组件形态预览](docs/preview.png)

## 架构

- **菜单栏引擎**（WindowGarden.app，无 Dock 图标）：常驻后台，测量你的活跃时长、推进植物生长、记录离开/回归，并把变化推送给组件。它是花园唯一的计时器。
- **桌面组件**（WindowGardenWidget，WidgetKit 扩展）：真正的 macOS 系统组件，在组件库里叫「窗口花园」，小/中两个尺寸，由你添加到桌面。它住在桌面层，永远在所有窗口之下，不遮挡任何应用。组件按系统调度的快照刷新（相位边界 + 生长/离开事件），没有逐帧动画、没有常驻渲染。

## 构建与运行

```sh
./scripts/make_app.sh --install   # 构建 + 安装到 /Applications + 注册进系统组件库
open /Applications/WindowGarden.app   # 启动引擎（菜单栏出现叶子图标）
```

> 组件库只收录标准位置（/Applications）的应用——放在项目 build/ 目录里时组件搜索不到。修改代码后重新 `make_app.sh --install` 再启动即可。

然后把组件添加到桌面：**点菜单栏的时间/日期 → 编辑组件 → 搜索「窗口花园」→ 选择尺寸添加**（或桌面空白处右键 → 编辑组件）。要求 macOS 14+。

引擎需要在后台运行，花园才会生长（引擎退出时花园静止，不枯萎、不倒退）。想要开机常驻，在菜单栏菜单里打开「开机自动启动」。

## 使用

- **生长**：持续使用电脑时植物缓慢生长（每累计约 8 活跃小时推进最幼的一株一个阶段，共 4 阶段）；植物永不枯萎。
- **昼夜**：跟随本地时间（清晨 05:30 / 白天 08:00 / 黄昏 17:30 / 夜晚 19:30），夜晚有星星、萤火虫与月见草柔光。
- **访客**：你离开约 5 分钟后，组件里会出现小动物；回来后它们散去。
- **小尺寸**自动展示最成熟的 3 株（夜晚会换上会发光的月见草）；**中尺寸**展示全部 6 株。
- **菜单栏**：`刷新组件`、`打开插画文件夹`、`开机自动启动`、`关于`、`退出`（退出＝花园暂停生长）。

## 自定义插画

花园的所有图样都是普通的 PNG 文件，**替换即生效**——这是产品的正式接口，无需改代码、无需重新构建。

**三步换装：**

1. 菜单栏叶子图标 → **打开插画文件夹**（即 `~/Library/Group Containers/group.com.windowgarden.app/art/`）
2. 用同名 PNG 覆盖想换的图
3. 等几秒自动生效；急的话点菜单栏「刷新组件」立即请求刷新

**命名与规格：**

| 类别 | 文件名模式 | 数量 | 规格建议 |
| --- | --- | --- | --- |
| 植物 | `plant_<物种>_<1..4>.png` | 6 物种 × 4 阶段 | 透明底，根部贴齐画布底边，竖构图（如 384×1024） |
| 访客动物 | `animal_<cat/bird/hedgehog>.png` | 3 | 透明底，脚部贴底，**面朝左**（程序按行走方向自动翻转） |
| 环境元素 | `ambient_<sun/moon/cloud/star/firefly/grass/stone>.png` | 7 | 透明底，居中或贴底 |
| 地面土带 | `bg_ground.png` | 可选 | 横条构图，顶部草缘；缺省用程序绘制的纯色地面 |
| 菜单栏图标 | `menubar_leaf.png` | 可选 | 深色单色剪影（作模板图渲染）；缺省用系统叶子符号 |

物种代码：`daisy` 雏菊 / `lavender` 薰衣草 / `tulip` 郁金香 / `lilyvalley` 铃兰 / `foxglove` 毛地黄 / `moonflower` 月见草（夜晚发光）。完整清单见 [Sources/WindowGarden/Art/manifest.json](Sources/WindowGarden/Art/manifest.json) 或 [ART_PROMPTS.md](ART_PROMPTS.md)。

**机制说明：**

- 应用内置的同名插画只是**首次启动的默认素材**，复制到本地目录后不会再覆盖你的自定义文件
- 渲染时按高度缩放、按底边对齐；昼夜氛围由程序叠加色调，无需为每个时段单独出图
- 重置：删除 `~/Library/Group Containers/group.com.windowgarden.app/state.json`（花园进度）或整个 `group.com.windowgarden.app` 目录（含插画）
- 可选质检：`swift scripts/check_art.swift` 批量检查透明底、贴底对齐与白底残留
- 想用 AI 生成整套素材：[ART_PROMPTS.md](ART_PROMPTS.md) 内含全部生成提示词

## 开发

```sh
swift run GardenPreview                          # 离屏渲染各尺寸×各时段的组件形态预览图
.build/release/WindowGarden --no-autolaunch      # 不注册登录项
.build/release/WindowGarden --growth-x 86400     # 加速生长（每秒注入 24h 活跃时长）
.build/release/WindowGarden --debug              # 每 5 秒输出心跳日志（stderr）
WG_STATE_DIR=/tmp/wg_test make_app.sh …          # 隔离状态目录
```

改完代码重新体验：`./scripts/make_app.sh --install`（swift 脚本调试可直接 `swift build`，但发布组件必须走 xcodebuild）。

### 关键实测结论（macOS 26）

- 全局空闲查询（`CGEventSource.secondsSinceLastEventType`）不需要任何系统权限
- 组件扩展**必须沙盒化**才会被系统组件门禁收录（未沙盒的扩展被静默忽略）
- 组件库只收录 **/Applications** 标准位置的应用
- **SwiftPM（`swift build`）直接产出的组件扩展会被系统静默拒绝**——必须经 Xcode/xcodebuild 构建（本仓库因此采用 `.xcodeproj` + 引用本地 SwiftPM 包的混合结构）
- 沙盒组件**读不到** `~/Library/Application Support`：Foundation 在沙盒内会把该目录重定向到组件自己的容器，temporary-exception 对 ad-hoc/开发签名也不生效——引擎与组件的共享数据必须走 **App Group 容器**（`~/Library/Group Containers/group.com.windowgarden.app/`）

## 卸载

1. 菜单栏 → 关闭「开机自动启动」（或系统设置 → 登录项中移除 WindowGarden）
2. 长按桌面上的花园组件 → 移除
3. 菜单栏 → 退出，删除 `/Applications/WindowGarden.app`
4. 删除 `~/Library/Group Containers/group.com.windowgarden.app/`（旧版本是 `~/Library/Application Support/WindowGarden/`）

## 许可证

[MIT](LICENSE)。随仓库分发的内置插画由 GPT 生成，与代码同许可分发。
