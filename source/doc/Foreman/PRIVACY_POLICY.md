---
layout: doc
title: Foreman 隐私政策
date: 2026-11-10
---
# Foreman 隐私政策 / Privacy Policy

生效日期 / Effective Date: 2026 年 11 月 10 日

---

## 中文版

wangzz（以下简称"我们"）高度重视用户隐私保护。本政策说明我们在您使用 Foreman（以下简称"本应用"）时如何收集、使用、存储、共享您的个人信息，以及您对这些信息的控制方式。请您在使用本应用前仔细阅读本政策。

### 1. 我们收集的信息

#### 1.1 您主动提供的信息

- 配对信息：您在 iPhone 与 Mac 之间扫码或输入配对码时生成的配对标识与密钥
- 反馈与咨询信息：当您通过应用内「意见反馈」联系我们时，您主动填写的邮箱地址及反馈内容
- 您在使用本应用时产生的数据：会话标题、收件箱状态、设置偏好等

#### 1.2 自动收集的信息

本应用不接入任何第三方广告或分析 SDK，不自动收集用于追踪的设备标识符。为维持连接与提醒功能，以下信息仅存储在您的设备本地或经您授权后用于推送：

- Apple 推送通知 Token：用于在会话需要您确认时向您发送提醒
- 免费额度计数：免费版每月可运行次数按自然月在本机计数
- 连接元数据：为完成设备配对、消息路由与故障排查，Relay 服务会处理设备标识（deviceId）、手机客户端标识（clientId）、配对与上下线时间、事件类型、限流与鉴权结果。这些记录不包含会话正文、代码或命令输出，也不会用于跨 App 或广告追踪

#### 1.3 我们不会收集的信息

Foreman 不会上传您的代码、会话正文、命令输出或预览画面到我们的服务器。这些内容只在您的 iPhone 与已配对的 Mac 之间端到端加密传输；Remote Relay 只转发密文，无法读取内容。除非您主动授予对应权限，本应用也不会收集：

- 精确地理位置
- 通讯录
- 健康数据

### 2. 我们如何使用这些信息

- 在您的 iPhone 与 Mac 之间建立加密连接，提供远程会话核心功能
- 维持连接状态、展示设备与会话信息、在后台提醒您处理待办
- 响应您的咨询与反馈
- 遵守适用的法律法规

我们不会将您的个人信息用于上述目的之外的用途，也不会向第三方出售您的个人信息。

### 3. 第三方服务

本应用不集成任何第三方广告、统计或分析 SDK。以下功能由 Apple 以系统服务形式提供：

- App Store 与 StoreKit：订阅的购买与校验在本机完成，我们不保存您的 Apple ID、支付信息或交易记录
- Apple Push Notification service（APNs）：仅传递会话标题、事件类型与会话标识，正文不进入推送内容

### 4. 信息存储与安全

- 存储地点：配对密钥保存在 iPhone 的 Keychain 中，会话与收件箱缓存保存在设备本地；会话正文仅存在于您本人的 Mac 上；连接元数据保存在位于中国大陆的 Relay 服务器
- 传输安全：所有会话内容经 X25519 密钥交换与 AES-256-GCM 端到端加密，服务器仅转发密文
- 存储期限：我们仅在实现本政策所述目的所必需的期间内保留您的个人信息；Relay 连接元数据最长保留 30 天，到期自动清理；解除配对或使用「清除本机数据」会删除本机保存的配对密钥与会话缓存
- 相机、麦克风与语音识别权限仅用于您主动发起的扫码、拍照与语音输入，相关音频与图像只在本机处理

### 5. 您的权利

您有权：

- 访问和查看您设备本地保存的配对与会话信息
- 删除您的个人信息（解除配对即删除密钥与缓存；「我的 → 数据 → 清除本机数据」与删除应用都会清除全部本地数据）
- 撤回您先前授予的权限（在系统「设置 → 隐私与安全性 → Foreman」中调整）
- 关闭推送提醒（在应用内「我的 → 通知」或系统设置中调整）

### 6. 未成年人保护

本应用的目标用户不包含未满 14 周岁的未成年人。如果您是未满 14 周岁的未成年人，请在监护人同意并陪同下使用本应用。我们不会在未获得监护人同意的情况下主动收集未成年人的个人信息。

### 7. 政策更新

我们可能会不定期更新本政策。更新后的政策将在本页面发布，并修改生效日期。重大变更我们会通过应用内通知或其他方式提示您。

### 8. 联系我们

如您对本政策有任何疑问、意见或投诉，请通过以下方式联系我们：

- 开发者：wangzz
- 邮箱：wzzvictory_tjsd@163.com
- 地址：Beijing, China

本政策的解释与争议解决适用 People's Republic of China 法律。

---

## English Version

wangzz ("we", "us", "our") values your privacy. This Privacy Policy describes how we collect, use, store, and share your personal information when you use Foreman (the "App"), and the choices you have regarding that information. Please read this policy carefully before using the App.

### 1. Information We Collect

#### 1.1 Information You Provide

- Pairing information: the pairing identifiers and keys generated when you pair your iPhone with your Mac via QR code or pairing code
- Feedback: the email address and content you voluntarily submit when contacting us through in-app feedback
- Usage data: session titles, inbox status, and preferences generated while using the App

#### 1.2 Information Collected Automatically

The App integrates no third-party advertising or analytics SDKs and collects no device identifiers for tracking. To maintain connectivity and notifications, the following is stored locally on your device or used for push notifications with your authorization:

- Apple Push Notification token: used to remind you when a session needs your confirmation
- Free-tier run counter: the monthly allowance for the free tier is counted on your device
- Connection metadata: to pair devices, route messages, and troubleshoot, the relay service processes a device identifier (deviceId), a phone client identifier (clientId), pairing and connect/disconnect times, event types, and rate-limit or authentication results. These records never include transcripts, code, or command output, and are not used for cross-app or advertising tracking

#### 1.3 Information We Do Not Collect

Foreman never uploads your code, session transcripts, command output, or preview frames to our servers. These contents travel end-to-end encrypted between your iPhone and your paired Mac only; the Remote Relay forwards ciphertext it cannot read. Unless you explicitly grant the corresponding permission, we also do not collect:

- Precise location
- Contacts
- Health data

### 2. How We Use Information

- To establish an encrypted connection between your iPhone and your Mac and provide the core remote-session functionality
- To maintain connection state, display device and session information, and remind you of pending items
- To respond to your inquiries and feedback
- To comply with applicable laws and regulations

We do not use your personal information for purposes beyond those stated above, nor do we sell your personal information to third parties.

### 3. Third-Party Services

The App integrates no third-party advertising, statistics, or analytics SDKs. The following capabilities are provided by Apple as system services:

- App Store and StoreKit: subscription purchase and verification happen on your device; we do not store your Apple ID, payment information, or transaction records
- Apple Push Notification service (APNs): delivers only session titles, event types, and session identifiers; transcripts never appear in push content

### 4. Storage and Security

- Location: pairing keys are stored in the iPhone Keychain; session and inbox caches are stored on your device; session transcripts exist only on your own Mac; connection metadata is stored on the relay server located in mainland China
- Security in transit: all session content is end-to-end encrypted with X25519 key exchange and AES-256-GCM; servers only forward ciphertext
- Retention: we retain your personal information only for as long as necessary to fulfill the purposes stated in this policy; relay connection metadata is kept for at most 30 days and pruned automatically. Unpairing or "Clear Local Data" deletes the pairing keys and caches stored on your device
- Camera, microphone, and speech-recognition permissions are used only when you actively scan, capture, or dictate; related audio and images are processed on your device only

### 5. Your Rights

You have the right to:

- Access and review the pairing and session information stored locally on your device
- Delete your personal information (unpairing deletes keys and caches; "Me → Data → Clear Local Data" and deleting the App both clear all local data)
- Withdraw previously granted permissions (via iOS Settings → Privacy & Security → Foreman)
- Turn off push notifications (via in-app "Me → Notifications" or system Settings)

### 6. Children's Privacy

The App is not directed to children under 14. If you are under 14, please use the App only with the consent and supervision of a parent or guardian. We do not knowingly collect personal information from children under 14 without verifiable parental consent.

### 7. Changes to This Policy

We may update this policy from time to time. Updated versions will be posted on this page with a revised Effective Date. We will notify you of material changes through in-app notifications or other means.

### 8. Contact Us

If you have any questions, comments, or complaints about this policy, please contact:

- Developer: wangzz
- Email: wzzvictory_tjsd@163.com
- Address: Beijing, China

This policy is governed by the laws of People's Republic of China.
