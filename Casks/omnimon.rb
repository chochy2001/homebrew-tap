cask "omnimon" do
  version "4.0.7"
  sha256 "0459b7664600f2bf3cae3bd3d64eeec696aaf5d1226375a41e8a20f5cee8da24"

  url "https://github.com/chochy2001/omnimon/releases/download/v#{version}/OmniMon_#{version}_aarch64.dmg"
  name "OmniMon"
  desc "Cross-platform system monitor, process manager, and AI assistant"
  homepage "https://github.com/chochy2001/omnimon"

  depends_on macos: ">= :ventura"

  app "OmniMon.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/OmniMon.app"],
                   sudo: false
    ohai "Launching OmniMon..."
    system_command "/usr/bin/open", args: ["#{appdir}/OmniMon.app"]
  end

  uninstall quit: "com.omnimon.desktop"

  zap trash: [
    "~/Library/Application Support/com.omnimon.desktop",
    "~/Library/Caches/com.omnimon.desktop",
    "~/Library/Preferences/com.omnimon.desktop.plist",
    "~/.config/macmon",
    "~/.local/share/macmon"
  ]

  caveats <<~EOS
    OmniMon is now in your Applications folder.

    To open:  Cmd + Space → type "OmniMon"
    Or run:   open /Applications/OmniMon.app

    OmniMon also runs in your menu bar tray.

    If macOS blocks the app, run:
      sudo xattr -rd com.apple.quarantine /Applications/OmniMon.app
  EOS
end
