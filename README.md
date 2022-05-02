# Flutter Puzzle

ソフトウェアデザイン2022/04より。

## リリースビルド(android)

### アプリ署名用のキーストアを生成する

```zsh
keytool -genkey -v -keystore /tmp/keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias alias -storetype JKS
```

### `android/key.properties`ファイルを作成する

```txt
storePassword=password
keyPassword=password
keyAlias=alias
storeFile=/tmp/keystore.jks
```


### `key.properties`ファイルを元にアプリをビルドする設定を追加する

```diff
diff --git a/android/app/build.gradle b/android/app/build.gradle
index b30f2cf..f1ce01e 100644
--- a/android/app/build.gradle
+++ b/android/app/build.gradle
@@ -1,3 +1,8 @@
+def keystoreProperties = new Properties()
+def keystorePropertiesFile = rootProject.file('key.properties')
+if (keystorePropertiesFile.exists()) {
+    keystoreProperties.load(new FileInputStream(keystorePropertiesFile));
+}
 def localProperties = new Properties()
 def localPropertiesFile = rootProject.file('local.properties')
 if (localPropertiesFile.exists()) {
@@ -50,11 +55,21 @@ android {
         versionName flutterVersionName
     }

+    signingConfigs {
+        release {
+            keyAlias keystoreProperties['keyAlias']
+            keyPassword keystoreProperties['keyPassword']
+            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
+            storePassword keystoreProperties['storePassword']
+        }
+    }
+
     buildTypes {
         release {
             // TODO: Add your own signing config for the release build.
             // Signing with the debug keys for now, so `flutter run --release` works.
-            signingConfig signingConfigs.debug
+            // signingConfig signingConfigs.debug
+            signingConfig signingConfigs.release
         }
     }
 }
```

### APKファイルとしてAndroidをビルドする

```
% flutter build apk

💪 Building with sound null safety 💪

Running Gradle task 'assembleRelease'...                            3.6s
✓  Built build/app/outputs/flutter-apk/app-release.apk (16.5MB).
```

## firebase.toolsのインストール

`FIREBASE_TOKEN`を生成する為に、firebase.toolsをインストールする

```zsh
% curl -sL https://firebase.tools | bash
Password: PCのログインパスワードを入れるといいみたい
-- Checking for existing firebase-tools on PATH...
-- Checking your machine type...
-- Downloading binary from https://firebase.tools/bin/macos/latest
######################################################################## 100.0%##-=#=-#
-- Setting permissions on binary...
-- Checking your PATH variable...
-- firebase-tools@10.7.2 is now installed
-- All Done!
```

`firebase login:ci`コマンドを叩くとブラウザが起動する。
アカウント選択画面になるので、選択したアカウントをもってアクセスをリクエストする。
