cask "wordroot" do
  version "8.0"
  sha256 "886928f46532bf45d8f3c5dd2caa149ef10b23dda1b9f04119e36662b827a31c"

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
