cask "typeback" do
  version "2.0.0"
  sha256 "09c3e7ce422b8f811ec3d200c8048d80613e6304624f9bfc1a3fd0647eee9e70"

  url "https://github.com/leftrk/typeback/releases/download/v#{version}/TypeBack.dmg"
  name "TypeBack"
  desc "macOS 输入法自动回切工具"
  homepage "https://github.com/leftrk/typeback"

  depends_on macos: ">= :sonoma"

  app "TypeBack.app"

  zap trash: [
    "~/Library/Preferences/com.huaguan.typeback.plist",
    "~/Library/Preferences/TypeBack.plist",
    "~/Library/Preferences/TypeBackStandalone.plist",
    "~/Library/Preferences/com.huaguan.typeback.app.plist",
    "~/Library/Preferences/com.typeback.app.plist",
    "~/Library/Application Support/com.huaguan.typeback",
    "~/Library/Application Support/com.typeback.app",
    "~/Library/Caches/com.huaguan.typeback",
    "~/Library/Caches/com.typeback.app",
  ]

  caveats <<~EOS
    TypeBack 需要辅助功能权限才能监听键盘事件：
      系统设置 → 隐私与安全性 → 辅助功能 → 添加 TypeBack

    1.1.7 更换了应用身份以避开 macOS 26 菜单栏缓存问题，升级后需要重新授权辅助功能权限。

    如 macOS 26 提示无法验证 TypeBack，可运行：
      xattr -dr com.apple.quarantine /Applications/TypeBack.app
  EOS
end
