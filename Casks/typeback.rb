cask "typeback" do
  version "1.0.1"
  sha256 "72fc2845507c51e0b4f3ba2f45024dabf536679f08d9d7da440c7431a4d225e1"

  url "https://github.com/leftrk/typeback/releases/download/v#{version}/TypeBack.zip"
  name "TypeBack"
  desc "macOS 输入法自动回切工具"
  homepage "https://github.com/leftrk/typeback"

  depends_on macos: ">= :sonoma"

  app "TypeBack.app"

  zap trash: [
    "~/Library/Preferences/com.leftrk.typeback.plist",
    "~/Library/Application Support/com.leftrk.typeback",
    "~/Library/Caches/com.leftrk.typeback",
  ]

  caveats <<~EOS
    TypeBack 需要辅助功能权限才能监听键盘事件：
      系统设置 → 隐私与安全性 → 辅助功能 → 添加 TypeBack
  EOS
end
