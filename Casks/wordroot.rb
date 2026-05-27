cask "wordroot" do
  version "0.1.3"
  sha256 "80778475baf163d17ef247242e47199118a07d17fb7455678dff6dfa29d4a00e"

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