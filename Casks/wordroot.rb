cask "wordroot" do
  version "0.1.1"
  sha256 "b5ffba7f78bfa4ccd3d223d9fede6870e4242db4e64d614de99d64f4ed5e8f21"

  url "https://github.com/leftrk/word-root/releases/download/v0.1.1/Wordroot-0.1.1.zip"
  name "Wordroot"
  desc "词根词典，让词汇有迹可循"
  homepage "https://github.com/leftrk/word-root"

  depends_on macos: ">= :ventura"

  app "Wordroot.app"

  zap trash: [
    "~/Library/Preferences/dev.leftrk.wordroot.plist",
    "~/Library/Application Support/dev.leftrk.wordroot",
    "~/Library/Caches/dev.leftrk.wordroot",
  ]
end