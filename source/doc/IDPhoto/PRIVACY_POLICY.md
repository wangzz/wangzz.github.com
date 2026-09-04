---
layout: doc
---
# AI证件照 隐私政策 / Privacy Policy

生效日期 / Effective Date: 2026-09-04

---

## 中文版

wangzz（以下简称"我们"）高度重视用户隐私保护。本政策说明我们在您使用 AI证件照（以下简称"本应用"）时如何收集、使用、存储、共享您的个人信息，以及您对这些信息的控制方式。请您在使用本应用前仔细阅读本政策。

### 1. 我们收集的信息

#### 1.1 您主动提供的信息

- 上传的人脸照片：仅在您主动选择照片、点击「生成证件照」时由系统获取，用于调用 AI 证件照生成接口
- 反馈内容：您通过应用内反馈功能提交的问题、意见、截图
- 设置偏好：默认规格、背景色、画质等选项

#### 1.2 自动收集的信息

- 设备型号与 iOS 系统版本（仅用于崩溃诊断与功能适配，不上传您的人脸照片）
- 订阅凭证：仅本地 Keychain 存储，用于恢复购买
- 应用使用统计：规格使用频次、错误率（仅本地记录，不含个人身份信息）

#### 1.3 我们不会收集的信息

本应用不会收集以下信息：
- 您的精确地理位置
- 您的通讯录
- 您的健康数据
- 您的 Apple ID 或其他账号密码
- 任何不必要的后台行为数据

### 2. 我们如何使用这些信息

- 向您提供本应用的核心功能（证件照规格生成、背景替换、智能裁剪、高清导出）
- 维护和改进产品服务质量
- 响应您的咨询与反馈
- 遵守适用的法律法规

我们不会将您的个人信息用于上述目的之外的用途，也不会向第三方出售您的个人信息。

### 3. 第三方服务

本应用集成了以下第三方服务，这些服务可能会收集必要的信息用于其声明的用途：

- **腾讯云市场「怜花数科」证件照生成接口**（证件照生成）：为实现证件照制作、背景替换、人物裁剪等核心功能所必需。您上传的人脸照片以 base64 编码方式直接通过 HTTPS POST 发送至厂商接口，**不经过我们的服务器中转**。AI 生成完成后，原始照片与生成结果由厂商在其服务端按其隐私政策处理，**不持久化存储、不用于模型训练**，数据保留期不超过 24 小时。厂商联系方式：service@lianhdt.com，QQ 15990137650，电话 18969922052。厂商备案信息见应用内「关于我们」页面。
- **Apple StoreKit**（内购与订阅）：用于处理订阅凭证与恢复购买。隐私协议：https://www.apple.com/legal/privacy/

我们已与上述第三方建立数据处理协议（DPA），要求其按照不低于本政策的标准处理您的信息。

### 3.1 人脸数据与第三方 AI 服务（重要）

#### 3.1.1 人脸数据速览

| 项目 | 说明 |
|---|---|
| 收集哪些人脸数据 | 仅您主动拍摄或选择的那**一张人像照片**。我们**不生成、不提取、不存储**任何人脸特征模板（faceprint）、面部几何数据或生物识别标识 |
| 何时收集 | 仅在您点击「生成证件照」时，由您主动触发 |
| 用途 | 仅用于生成证件照：背景替换、智能裁剪、规格适配 |
| 是否与第三方共享 | 是。仅腾讯云市场「怜花数科」AI 证件照接口（vendor ID 42071），无其他接收方 |
| 存储地点 | 发送过程仅经过厂商服务端（中国境内）。**不经过我们的服务器**，不写入任何对象存储；生成结果保存在您本机的相册 |
| 保留期限 | 厂商侧 ≤ 24 小时自动删除；设备侧由您自主管理 |
| 删除方式 | 厂商 24 小时内自动删除；您可随时在相册或「设置 → 数据导出」删除本地结果；也可发邮件至 wzzvictory_tjsd@163.com 要求删除并获取确认 |
| 是否用于身份识别 / 广告 / 模型训练 | **否**。人脸数据不作身份识别、用户画像、广告投放或模型训练用途 |

#### 3.1.2 详细处理流程

当您主动选择或拍摄一张人像并点击「生成证件照」时，该人像照片会：

- 以 base64 编码方式，通过 HTTPS POST 直接发送至腾讯云市场「怜花数科」AI 证件照接口（vendor ID 42071）；
- 不经过我们的服务器中转，不写入任何对象存储；
- 仅用于证件照生成（背景替换、智能裁剪、规格适配）。

厂商在生成完成后 24 小时内自动删除您的原始照片与生成结果，不作持久化存储，不用于模型训练。
我们不会向除该厂商外的任何第三方分享您的人像照片，也不会出售您的人脸数据。

#### 3.1.3 我们不会创建人脸特征模板

相机页的实时人脸检测（脸位、角度、光线引导）在您的设备上使用 Apple Vision 框架本地完成，检测结果仅存在于内存中，不存储、不上传。本应用不具备人脸识别、身份比对能力，不建立人脸数据库，也不使用 Face ID 或其他生物识别认证。

#### 3.1.4 您的同意与控制

在发送前，App 会通过明确的弹窗向您告知上述数据流向（发送内容、接收方、用途、留存期限）并取得您的同意；**未取得同意时，App 不会向厂商发送任何照片，生成功能不可用**。您可在「设置 → 人像数据告知」中随时查看或撤回该授权，撤回后再次生成时会重新征求您的同意。

#### 3.1.5 第三方保护水平

腾讯云市场「怜花数科」通过腾讯云市场平台提供服务，其数据处理受平台服务协议与本应用与该厂商的数据处理约定约束，要求其按照不低于本政策的标准保护您的信息，且不得将您的人脸数据用于生成证件照以外的任何用途。

### 4. 信息存储与安全

- **本地优先**：应用内浏览与编辑在本地完成，AI 生成结果默认保存到您的设备相册
- **直接调用厂商**：仅在您主动点击「生成」时，原始照片以 base64 编码直接发送至厂商 API 端点，**不经我方服务器、不写入任何对象存储**。厂商按其服务条款在 24 小时内自动删除，不进入持久存储
- **存储地点**：您的数据主要存储在您的设备本地
- **存储期限**：厂商侧文件 24 小时内自动删除；本地相册由您自主管理
- **安全措施**：我们采用 HTTPS 加密传输；AppKey 与 AppSecret 注入到 Info.plist（不硬编码到 Swift 源码）；不向厂商传输任何设备标识或用户身份信息

### 5. 您的权利

您有权：

- 访问和查看您的个人信息（在本地设备上）
- 删除您的生成结果与本地缓存（设置 → 数据导出）
- 要求删除厂商侧留存的原始照片（邮件至 wzzvictory_tjsd@163.com，我们会在 7 个工作日内反馈处理结果）
- 撤回您先前授予的相册权限（iOS 设置 → 隐私与安全性 → AI证件照）
- 通过 wzzvictory_tjsd@163.com 联系开发者行使您的数据主体权利

### 6. 未成年人保护

本应用的目标用户不包含未满 14 周岁的未成年人。如果您是未满 14 周岁的未成年人，请在监护人同意并陪同下使用本应用。我们不会在未获得监护人同意的情况下主动收集未成年人的个人信息。

### 7. AI 生成内容标识

根据《互联网信息服务深度合成管理规定》《生成式人工智能服务管理暂行办法》，本应用所有 AI 生成内容均会：

- 添加显式 **"AI 生成 · AI证件照"** 水印
- 嵌入 **C2PA** 元数据标识
- 不得通过技术手段去除或修改上述标识

请注意：AI 生成的证件照仅供参考。涉及官方证件照用途（护照、签证、驾照等）时，请以官方机构审核结果为准。

### 8. 政策更新

我们可能会不定期更新本政策。更新后的政策将在本页面发布，并修改生效日期。重大变更我们会通过应用内通知或其他方式提示您。

### 9. 联系我们

如您对本政策有任何疑问、意见或投诉，请通过以下方式联系我们：

- 开发者：wangzz
- 邮箱：wzzvictory_tjsd@163.com

本政策的解释与争议解决适用 中国 法律。

---

## English Version

wangzz ("we", "us", "our") values your privacy. This Privacy Policy describes how we collect, use, store, and share your personal information when you use AI证件照 (the "App"), and the choices you have regarding that information. Please read this policy carefully before using the App.

### 1. Information We Collect

#### 1.1 Information You Provide

- Uploaded face photo: only retrieved when you actively select a photo and tap "Generate" — used to call the AI ID photo generation API
- Feedback content: questions, comments, and screenshots you submit through in-app feedback
- Settings preferences: default spec, background color, image quality, etc.

#### 1.2 Information Collected Automatically

- Device model and iOS version (only for crash diagnostics and feature compatibility; not used to upload your face photo)
- Subscription credentials: stored only in local Keychain for purchase restoration
- App usage statistics: spec usage frequency, error rates (recorded locally only, no personal identity information)

#### 1.3 Information We Do Not Collect

We do not collect:
- Your precise location
- Your contacts
- Your health data
- Your Apple ID or other account credentials
- Any unnecessary background behavioral data

### 2. How We Use Information

- To provide the App's core functions (ID photo spec generation, background replacement, smart cropping, HD export)
- To maintain and improve product quality
- To respond to your inquiries and feedback
- To comply with applicable laws and regulations

We do not use your personal information for purposes beyond those stated above, nor do we sell your personal information to third parties.

### 3. Third-Party Services

The App integrates the following third-party services. These services may collect information necessary to fulfill their stated purposes:

- **Tencent Cloud Marketplace "Lianhua Tech" ID Photo API** (ID photo generation): required to deliver the core functions of ID photo generation, background replacement, and smart cropping. Your uploaded face photo is sent directly to the vendor's API endpoint as a base64-encoded HTTPS POST body; **it is not routed through our server**. After AI generation completes, the original photo and the generated result are handled by the vendor under their own privacy policy, **not persistently stored, not used for model training**, and are deleted within 24 hours. Vendor contact: service@lianhdt.com, QQ 15990137650, phone 18969922052. Vendor compliance records are listed in the in-app "About" page.
- **Apple StoreKit** (in-app purchase and subscription): used to handle subscription credentials and purchase restoration. Privacy: https://www.apple.com/legal/privacy/

We have signed data processing agreements (DPAs) with these parties requiring them to handle your information at a standard no less strict than this policy.

### 3.1 Face Data & Third-Party AI Services (Important)

#### 3.1.1 Face Data at a Glance

| Item | Detail |
|---|---|
| What face data we collect | Only the **single portrait photo** you actively take or select. We do **not** create, extract, or store any faceprint, facial geometry data, or biometric identifier |
| When we collect it | Only when you actively tap "Generate" |
| Purpose | Solely to generate the ID photo: background replacement, smart cropping, spec fitting |
| Shared with third parties | Yes — only the Tencent Cloud Marketplace "Lianhua Tech" ID Photo API (vendor ID 42071). No other recipient |
| Where it is stored | In transit it only passes through the vendor's server (located in mainland China). It is **not routed through our servers** and is not written to any object storage. The generated result is saved to your device's photo album |
| Retention period | Vendor-side: automatically deleted within 24 hours. Device-side: managed by you |
| How it is deleted | Automatically deleted by the vendor within 24 hours; you may delete local results at any time from your photo album or via Settings → Data Export; you may also email wzzvictory_tjsd@163.com to request deletion and receive confirmation |
| Used for identification / advertising / model training | **No.** Face data is never used for identity recognition, profiling, advertising, or model training |

#### 3.1.2 Detailed Processing Flow

When you actively select or take a portrait and tap "Generate", that portrait photo will be:

- Sent directly as a base64-encoded HTTPS POST to the Tencent Cloud Marketplace "Lianhua Tech" ID Photo API (vendor ID 42071);
- Not routed through our servers and not written to any object storage;
- Used solely for ID photo generation (background replacement, smart cropping, spec fitting).

The vendor automatically deletes your original photo and the generated result within 24 hours after generation completes, does not persistently store them, and does not use them for model training. We do not share your portrait photo with any third party other than that vendor, and we never sell your face data.

#### 3.1.3 We Do Not Create Faceprints

The live face detection on the camera page (face position, angle, lighting guidance) runs locally on your device using Apple's Vision framework; the detection results exist only in memory and are never stored or uploaded. The App has no facial recognition or identity-matching capability, maintains no face database, and does not use Face ID or any other biometric authentication.

#### 3.1.4 Your Consent and Control

Before sending, the App discloses the above data flow through a clear in-app dialog — what is sent, to whom, for what purpose, and for how long it is retained — and obtains your consent. **If consent is not granted, the App does not send any photo to the vendor and the generation feature is unavailable.** You can review or revoke this authorization at any time in Settings → Portrait Data Disclosure; after revoking, consent is requested again before the next generation.

#### 3.1.5 Third-Party Protection Level

Tencent Cloud Marketplace "Lianhua Tech" provides its service through the Tencent Cloud Marketplace platform. Its data processing is governed by the platform's service agreement and by the data processing arrangement between us and the vendor, which requires the vendor to protect your information at a standard no less protective than this policy and prohibits any use of your face data other than generating the ID photo you requested.

### 4. Storage and Security

- **Local-first**: in-app browsing and editing happen on device; AI-generated results are saved to your device's photo album by default
- **Direct vendor call**: only when you actively tap "Generate", your original photo is sent as base64 directly to the vendor's API endpoint, **without transiting our server or being written to any object storage**. The vendor auto-deletes data within 24 hours per its service terms; data never enters persistent storage
- **Storage location**: your data is primarily stored on your device
- **Retention period**: vendor-side files are auto-deleted within 24 hours; local photo album is managed by you
- **Safeguards**: HTTPS encryption in transit; AppKey and AppSecret are injected via Info.plist (not hard-coded in Swift sources); no device identifiers or user identity are sent to the vendor

### 5. Your Rights

You have the right to:
- Access and review your personal information (on your local device)
- Delete your generated results and local cache (Settings → Data Export)
- Request deletion of the original photo retained by the vendor (email wzzvictory_tjsd@163.com; we will report back within 7 business days)
- Withdraw previously granted photo library permissions (iOS Settings → Privacy & Security → AI证件照)
- Contact the developer at wzzvictory_tjsd@163.com to exercise your data subject rights

### 6. Children's Privacy

The App is not directed to children under 14. If you are under 14, please use the App only with the consent and supervision of a parent or guardian. We do not knowingly collect personal information from children under 14 without verifiable parental consent.

### 7. AI-Generated Content Marking

In compliance with Chinese regulations on deep synthesis and generative AI services, all AI-generated content in the App will:
- Display an explicit **"AI Generated · AI证件照"** watermark
- Embed **C2PA** metadata
- Not be removable or modifiable through any technical means

Please note: AI-generated ID photos are for reference only. For official ID document use (passport, visa, driver license, etc.), the result is subject to the official authority's review.

### 8. Changes to This Policy

We may update this policy from time to time. Updated versions will be posted on this page with a revised Effective Date. We will notify you of material changes through in-app notifications or other means.

### 9. Contact Us

If you have any questions, comments, or complaints about this policy, please contact:
- Developer: wangzz
- Email: wzzvictory_tjsd@163.com

This policy is governed by the laws of China.
