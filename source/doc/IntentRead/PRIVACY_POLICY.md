---
layout: doc
---
# 意读 IntentRead 隐私政策 / Privacy Policy

生效日期 / Effective Date: 2026-10-03

---

## 中文版

wangzz（以下简称"我们"）高度重视用户隐私。本政策说明您在我们使用「意读 IntentRead」（以下简称"本应用"）时，我们如何处理与您的聊天内容、判读结果及购买相关的信息。

在阅读本政策前，请特别了解以下三件事：

1. **我们不做服务器中转。本应用没有自己的服务端，判读请求由您的设备直接发送给判读服务提供方。**
2. **您截图导入的聊天图片不会上传。** 图片文字识别（OCR）全部在本机完成，识别完成后图片即被丢弃。
3. **对话文本会被发送给判读服务用于生成判断结果**，这一点我们在下面第 2 节详细说明。

### 1. 我们处理的信息

#### 1.1 判读输入（聊天文本）

- 您主动粘贴到输入框的对话文本；
- 或您从相册导入聊天截图、经本机 OCR 识别得到的文字（**图片文件本身不发送、不上传、不留存**）。

用途：调用判读服务，换取对方意图、情绪倾向、敷衍倾向与置信度等结构化结果。

数据流向：您的设备 → HTTPS 直连 → 判读服务（腾讯云 EdgeOne Makers 托管的 Jev 网关 `ai-gateway.edgeone.link`，模型 `@makers/jev`）。若您在「设置」中填入了自己的 Jev API Key（BYOK），则改为直连 Jev 官方 `api.typesafe.ai`，由您自己的账号与配额承担。

我们不以任何形式留存您提交的对话文本，也不将其用于模型训练或任何二次用途。

#### 1.2 判读结果与历史记录

- 判读结果默认**不保存**。
- 您可在设置中开启「历史记录」，开启后判读结果仅写入**本机数据库**，用于回看与态度趋势。历史记录可在设置中随时单条或全部删除，删除后不可恢复。
- 卸载本应用即可清除本机全部历史数据。

#### 1.3 账号与凭证

本应用**没有用户账号体系，无需注册登录**。

- 判读服务所需的密钥（内置平台 Key 或您自行填写的 BYOK Key）仅保存在您的设备本地；
- 订阅凭证与恢复购买所需信息由 Apple StoreKit 管理，凭证缓存在本机 Keychain；
- 应用偏好、历史开关、所选方案等设置保存在本机 UserDefaults。

#### 1.4 您不向我们提供的信息

由于本应用没有账号与服务端，我们无法也从未收集：

- 精确地理位置（本应用不申请定位权限）
- 通讯录、短信、通话记录、照片库索引
- 健康数据、生物识别数据
- 设备标识符（IDFA）与任何可用于跨应用追踪的标识
- 浏览器浏览历史

本应用**不集成任何广告 SDK**，不使用 App Tracking Transparency，不申请 IDFA。

### 2. 第三方服务

| 第三方 | 处理的信息 | 用途 | 隐私政策 |
|---|---|---|---|
| 腾讯云 EdgeOne Makers（Jev 判读服务网关） | 您提交的对话文本、判读请求参数 | 返回结构化判读结果 | https://www.tencent.com/legal/privacy-policy.html |
| TypeSafe AI（Jev 官方，仅当用户自填 BYOK Key 时） | 您提交的对话文本 | 返回结构化判读结果 | 由用户在设置中自行确认其服务条款 |
| Apple（StoreKit / App Store） | 订阅与购买凭证、付款信息 | 处理内购、恢复购买、订阅管理 | https://www.apple.com/legal/privacy/ |

除上述判读服务外，我们不与任何第三方共享您的个人信息，也从不出售个人信息。

### 3. 权限说明

本应用仅申请**照片图库读取**一项系统权限，用于您主动选择聊天截图。该权限仅在本次识别中使用，图片上传行为不存在。本应用不申请定位、相机、麦克风、通讯录、通知权限。

### 4. 信息安全

判读请求全程使用 HTTPS 加密传输。判读结果仅存于本机，不上传。您可随时在设置中清除全部本地数据。

### 5. 未成年人

本应用面向成年人使用，不面向 13 岁以下儿童，不收集儿童个人信息。若您认为未满 13 周岁的未成年人向我們提供了个人信息，请发邮件至 wzzvictory_tjsd@163.com，我们将在核实后删除。

### 6. 政策更新

本政策可能随功能调整而更新。更新后的内容将在本页面公布并更新「生效日期」。继续使用本应用即视为接受更新后的政策。

### 7. 联系我们

如有任何隐私相关问题，请联系：wzzvictory_tjsd@163.com

本政策适用中华人民共和国法律。

---

## English Version

wangzz ("we", "us", "our") values your privacy. This Privacy Policy explains how we handle your conversation content, judgment results, and purchase information when you use "IntentRead" (the "App").

Before reading further, please note three things:

1. **We run no server of our own.** Judgment requests go directly from your device to the judgment service provider.
2. **Screenshots you import are never uploaded.** Image recognition (OCR) happens entirely on your device; the image is discarded once recognition finishes.
3. **Conversation text is sent to the judgment service** in order to produce a result. This is described in detail in section 2 below.

### 1. Information We Process

#### 1.1 Judgment input (conversation text)

- Conversation text you paste into the input box;
- Or text obtained by on-device OCR from a chat screenshot you select from your photo library. **The image file itself is never transmitted, uploaded, or stored.**

Purpose: call the judgment service to obtain a structured result covering the other party's intent, emotional leaning, perfunctory tendency, and confidence level.

Data flow: your device → HTTPS direct connection → judgment service (Jev hosted on Tencent Cloud EdgeOne Makers at `ai-gateway.edgeone.link`, model `@makers/jev`). If you enter your own Jev API Key in Settings (BYOK), requests go directly to Jev's official endpoint `api.typesafe.ai` under your own account and quota.

We do not retain the conversation text you submit and never use it for model training or any secondary purpose.

#### 1.2 Judgment results and history

- Judgment results are **not saved** by default.
- You may enable "History" in Settings. Once enabled, results are written to a **local database on your device** for review and attitude trends. History entries can be deleted individually or in bulk from Settings; deletion is permanent.
- Uninstalling the App removes all local history data.

#### 1.3 Accounts and credentials

The App has **no user account system and no sign-up or sign-in**.

- Judgment service credentials (the built-in platform key or a BYOK key you enter) are stored only on your device;
- Subscription and restore-purchase data is handled by Apple StoreKit, with receipts cached in the local Keychain;
- Preferences, history toggle, and selected plan are stored in local UserDefaults.

#### 1.4 Information You Never Provide to Us

Because the App has no account system or server, we neither collect nor are able to collect:

- Precise location (the App requests no location permission)
- Contacts, SMS, call logs, photo library index
- Health or biometric data
- Device identifiers (IDFA) or any cross-app tracking identifier
- Browser browsing history

The App **integrates no advertising SDK**, does not use App Tracking Transparency, and never requests the IDFA.

### 2. Third-Party Services

| Third party | Information processed | Purpose | Privacy policy |
|---|---|---|---|
| Tencent Cloud EdgeOne Makers (Jev judgment gateway) | Conversation text you submit, judgment request parameters | Return the structured judgment result | https://www.tencent.com/legal/privacy-policy.html |
| TypeSafe AI (official Jev; only when you supply a BYOK key) | Conversation text you submit | Return the structured judgment result | Covered by the service terms the user accepts in Settings |
| Apple (StoreKit / App Store) | Subscription and purchase receipts, payment details | Process in-app purchases, restore purchases, manage subscriptions | https://www.apple.com/legal/privacy/ |

Apart from the judgment service above, we share no personal information with any third party and never sell personal information.

### 3. Permissions

The App requests exactly one system permission: **Photo Library (read-only)**, used only when you deliberately select a chat screenshot. No image transfer exists. The App requests no location, camera, microphone, contacts, or notification permissions.

### 4. Data Security

All judgment requests use encrypted HTTPS transport. Judgment results stay on your device and are never uploaded. You may clear all local data at any time from Settings.

### 5. Minors

The App is intended for adult users, is not directed at children under 13, and collects no information from children. If you believe a child under 13 has provided us with personal information, contact wzzvictory_tjsd@163.com and we will delete it after verification.

### 6. Policy Updates

This policy may be updated as the product evolves. Updated content will be published on this page with a revised "Effective Date". Continuing to use the App means you accept the updated policy.

### 7. Contact

For any privacy-related question, contact: wzzvictory_tjsd@163.com

This policy is governed by the laws of the People's Republic of China.
