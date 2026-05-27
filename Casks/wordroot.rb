cask "wordroot" do
  version "0.1.0"
  sha256 "43305a80e593f97d0e19deb849a90681351e9e444282c1c7367e99e6bb86049b"

  url "https://github.com/leftrk/word-root/releases/download/v0.1.0/Wordroot.zip"
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