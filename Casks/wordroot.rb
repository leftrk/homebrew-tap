cask "wordroot" do
  version "0.1.2"
  sha256 "c527f9c6bbff36f80496a79fc8c0fa85532702ca12603b44b9f41cd28113a1ee"

  url "https://github.com/leftrk/wordroot-dist/releases/download/v#{version}/Wordroot-#{version}.dmg"
  name "Wordroot"
  desc "词根词典，让词汇有迹可循"
  homepage "https://github.com/leftrk/wordroot-dist"

  depends_on macos: ">= :ventura"

  app "Wordroot.app"

  zap trash: [
    "~/Library/Preferences/dev.leftrk.wordroot.plist",
    "~/Library/Application Support/dev.leftrk.wordroot",
    "~/Library/Caches/dev.leftrk.wordroot",
  ]
end