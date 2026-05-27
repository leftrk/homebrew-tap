cask "wordroot" do
  version "0.1.0"
  sha256 "4dee1403890c9c927102d5c83686bb749b94892cd293592ed19a3b4dd22dd616"

  url "https://github.com/leftrk/homebrew-tap/releases/download/v0.1.0-wordroot/Wordroot-0.1.0.dmg"
  name "Wordroot"
  desc "词根词典，让词汇有迹可循"
  homepage "https://github.com/leftrk/wordroot"

  depends_on macos: ">= :sonoma"

  app "Wordroot.app"

  zap trash: [
    "~/Library/Preferences/dev.leftrk.wordroot.plist",
    "~/Library/Application Support/dev.leftrk.wordroot",
    "~/Library/Caches/dev.leftrk.wordroot",
  ]
end