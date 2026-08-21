---
layout: doc
---
# 健康数据说明（HealthKit Usage Disclosure）

**生效日期：** 2026-08-21
**适用产品：** 血压记录（BPHealth），iOS 应用
**Bundle ID：** com.wangzz.bphealth
**联系邮箱：** wzzvictory_tjsd@163.com

> 本说明依据 Apple HealthKit 与隐私规范（App Store Review Guidelines §5.1.1、HealthKit Human Interface Guidelines）以及《中华人民共和国个人信息保护法》要求编写，说明本应用如何访问与使用 Apple「健康」中的数据。请结合《隐私政策》一并阅读。

---

## 1. 我们访问的健康数据类型

在您**主动授权**后，本应用可访问您 Apple「健康」中的以下数据类型：

| 数据类别 | HealthKit 类型 | 读取 | 写入 |
|---|---|---|---|
| 血压（收缩压） | `HKQuantityTypeIdentifierBloodPressureSystolic` | ✓ | ✓ |
| 血压（舒张压） | `HKQuantityTypeIdentifierBloodPressureDiastolic` | ✓ | ✓ |
| 心率 | `HKQuantityTypeIdentifierHeartRate` | ✓ | ✓ |

本应用**不**请求访问上述类型以外的任何其他健康数据（如步数、睡眠、血氧、心电图、医疗记录等）。

## 2. 使用目的

### 2.1 读取（NSHealthShareUsageDescription）

- 在「趋势」页中合并展示您"健康"中已有的血压/心率记录与本应用本地记录，便于统一查看长期走势；
- 在记录详情页对照历史数据。

### 2.2 写入（NSHealthUpdateUsageDescription）

- 将您在本应用中确认的血压与心率读数（含测量时间）写入"健康"，便于您在"健康"App 中统一查看，或在其他第三方健康应用之间共享；
- 写入时间使用您指定的**测量时间**（非当前时间），避免趋势错位。

> 我们承诺：HealthKit 数据的读取与写入**完全在本机由 iOS 系统调度**，不经过任何外部服务器，不与任何第三方共享。

## 3. 数据不离开本机

3.1 本应用**不会**将任何 HealthKit 数据上传到服务器、发送给第三方，也不会用于广告或跨应用广告追踪。

3.2 本应用**不集成**任何广告 SDK、统计分析 SDK 或用户追踪 SDK，对应的 `NSPrivacyTracking` 在 Privacy Manifest (`PrivacyInfo.xcprivacy`) 中已设为 `false`。

3.3 HealthKit 数据的存储与处理完全由 iOS 系统级加密机制保护；本应用仅在您授权范围内访问与写入，无权跨越 iOS 沙盒获取其他应用数据。

## 4. 权限管理

4.1 您可在 iOS"设置 → 隐私与安全性 → 健康"中查看本应用对健康数据的访问权限，并可随时**全部撤销**或仅关闭其中某一项（读 / 写）。

4.2 撤销读取权限后：本应用趋势页将不再合并展示"健康"中的历史数据，仅展示本应用本地记录。

4.3 撤销写入权限后：本应用识别/补录的读数将**仅保存于本机**，不会写入"健康"。

4.4 您随时可在本应用"设置 → 反馈"中就 HealthKit 数据访问向我们咨询。

## 5. 合规承诺

依据 Apple HealthKit 使用规范，我们承诺：

- **不**将 HealthKit 数据用于广告或营销目的；
- **不**将 HealthKit 数据用于任何第三方分析、画像或追踪；
- **不**将 HealthKit 数据出售或共享给任何第三方；
- **不**在未取得您明确授权前访问任何 HealthKit 数据；
- **不**将 HealthKit 数据用于医疗诊断或治疗建议（本应用仅为个人记录辅助工具，详见《用户协议》第 4 节医疗免责声明）。

## 6. 与 Privacy Manifest 的一致性

本应用的 Privacy Manifest 文件 `PrivacyInfo.xcprivacy` 已声明：

- `NSPrivacyTracking`：`false`（不进行跨应用追踪）；
- `NSPrivacyTrackingDomains`：空（无追踪域名）；
- `NSPrivacyAccessedAPITypes`：空（未使用需要声明的 Required Reason API）。

> 您可在本应用包内找到完整的 `PrivacyInfo.xcprivacy`，亦可参考《隐私政策》第 7 节"第三方 SDK"了解本应用对框架依赖的隐私边界。

## 7. 联系我们

如对本应用如何使用 HealthKit 数据有任何疑问，可通过以下方式联系我们：

- **邮箱：** wzzvictory_tjsd@163.com
- **应用内入口：** 设置 → 反馈建议

---

> 本说明英文版本（如有）仅供参考，若有歧义，以本中文版本为准。
