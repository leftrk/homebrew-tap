cask "typeback" do
  version "1.0.2"
  sha256 "b5b8f04d3a1c1c18e4f7849826d2d086021db63cbe49d2c02e611489c356781a"

  url "https://github.com/leftrk/typeback/releases/download/v#{version}/TypeBack.dmg"
  name "TypeBack"
  desc "macOS 输入法自动回切工具"
  homepage "https://github.com/leftrk/typeback"

  depends_on macos: ">= :sonoma"

  app "TypeBack.app"

  zap trash: [
    "~/Library/Preferences/com.huaguan.typeback.plist",
    "~/Library/Application Support/com.huaguan.typeback",
    "~/Library/Caches/com.huaguan.typeback",
  ]

  caveats <<~EOS
    TypeBack 需要辅助功能权限才能监听键盘事件：
      系统设置 → 隐私与安全性 → 辅助功能 → 添加 TypeBack

    已支持 Sparkle 自动更新，可在菜单栏点击"检查更新..."。
  EOS
end
