cask "wordroot" do
  version "0.0.2"
  sha256 "555ce6aa2751a30e556bcafb36e50c458af9d4d5926fcddea799666a80f66457"

  url "https://github.com/leftrk/word-root/releases/download/v#{version}/Wordroot-#{version}.dmg"
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