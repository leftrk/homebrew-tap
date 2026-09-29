cask "wordroot" do
  version "11.0"
  sha256 "0c8d0a1ab15ff1baa46f27165f0e5f41bb52db59fe628f300761ce0edc305a92"

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
