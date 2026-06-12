cask "wordroot" do
  version "0.2.0"
  sha256 "ccca608e4a48f6812c4448ff3a7401cec0e8bda537750b8b5948c751f6a586d3"

  url "https://github.com/leftrk/wordroot-releases/releases/download/v#{version}/Wordroot-#{version}.dmg"
  name "Wordroot"
  desc "English-Chinese dictionary with root/etyma analysis"
  homepage "https://github.com/leftrk/wordroot-releases"

  app "Wordroot.app"

  # macOS attaches com.apple.quarantine to anything Homebrew downloads, which
  # makes Gatekeeper show "cannot verify… malware" on first launch even though
  # the app is signed and notarised. Strip it after staging.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Wordroot.app"]
  end

  zap trash: [
    "~/Library/Application Support/Wordroot",
    "~/Library/Preferences/dev.leftrk.wordroot.plist",
  ]
end
