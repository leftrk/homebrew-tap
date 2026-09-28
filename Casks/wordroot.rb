cask "wordroot" do
  version "10.0"
  sha256 "7d4c3cc862241279a1d12e5fd2ae83f6e4bee0b83e6b446b92d4b779b7815d6c"

  url "https://github.com/leftrk/wordroot-releases/releases/download/v#{version}/Wordroot-#{version}.dmg"
  name "Wordroot"
  desc "English-Chinese dictionary with root/etyma analysis"
  homepage "https://github.com/leftrk/wordroot-releases"

  app "Wordroot.app"

  # macOS attaches com.apple.quarantine to anything Homebrew downloads, which
  # makes Gatekeeper show "cannot verify… malware" on first launch even though
  # the app is signed and notarised. Strip it after staging.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Wordroot.app"]
  end

  zap trash: [
    "~/Library/Application Support/Wordroot",
    "~/Library/Preferences/dev.leftrk.wordroot.plist",
  ]
end
