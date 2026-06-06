cask "typeback" do
  version "1.1.5"
  sha256 "53ef5d00053960f1b9deb52cf8131e115ebbe41a58189c05f2c34ccf22f3f390"

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
    "~/Library/Preferences/com.huaguan.typeback.fixed.plist",
    "~/Library/Preferences/com.huaguan.typeback.macos26test.plist",
    "~/Library/Preferences/com.huaguan.typeback.test.plist",
    "~/Library/Preferences/com.huaguan.typeback.v111.plist",
    "~/Library/Preferences/com.huaguan.typeback.v2test.plist",
    "~/Library/Preferences/com.test.fresh.typeback.plist",
    "~/Library/Preferences/com.jordanbaird.Ice.plist",
    "~/Library/Application Support/com.huaguan.typeback",
    "~/Library/Caches/com.huaguan.typeback",
  ]

  caveats <<~EOS
    TypeBack 需要辅助功能权限才能监听键盘事件：
      系统设置 → 隐私与安全性 → 辅助功能 → 添加 TypeBack

    如 macOS 26 提示无法验证 TypeBack，可运行：
      xattr -dr com.apple.quarantine /Applications/TypeBack.app
  EOS
end
