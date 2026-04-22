class Typeback < Formula
  desc "macOS 输入法自动回切工具，支持 Liquid Glass 浮动指示器"
  homepage "https://github.com/leftrk/typeback"
  url "https://github.com/leftrk/typeback/releases/download/v1.0.0/TypeBack_1.0.0_darwin.tar.gz"
  sha256 "83850178defc112a7d89f62aa3c365f339364c1cf58f21224a6470950d369ac8"
  license "MIT"
  version "1.0.0"

  depends_on :macos => :sonoma

  def install
    bin.install "TypeBack"
  end

  def caveats
    <<~EOS
      TypeBack 需要辅助功能权限才能监听键盘事件：
        系统设置 → 隐私与安全性 → 辅助功能 → 添加 TypeBack

      如遇 Gatekeeper 拦截，运行：
        sudo xattr -dr com.apple.quarantine #{bin}/TypeBack

      启动 TypeBack：
        TypeBack
    EOS
  end

  test do
    assert_predicate bin/"TypeBack", :exist?
    assert_predicate bin/"TypeBack", :executable?
  end
end
