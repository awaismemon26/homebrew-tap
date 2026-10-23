cask "beam" do
  version "1.1.0"
  sha256 "56df5ced9c997be7a7a3aec47b8a0142015abeb3a03a9495b094150c55110914"

  url "https://github.com/awaismemon26/beam-macos/releases/download/v#{version}/Beam-#{version}.dmg"
  name "Beam"
  desc "Native window switcher and launcher"
  homepage "https://github.com/awaismemon26/beam-macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Beam.app"

  uninstall quit: "dev.beam.Beam"

  zap trash: [
    "~/Library/Application Support/Beam",
    "~/Library/Caches/dev.beam.Beam",
    "~/Library/HTTPStorages/dev.beam.Beam",
    "~/Library/Preferences/dev.beam.Beam.plist",
  ]

  caveats <<~EOS
    Beam isn't notarized yet. The first time you open it, macOS says it can't verify it:
    click Done, then open System Settings > Privacy & Security and click Open Anyway.
    Then open Beam again and turn on Accessibility when it asks.
  EOS
end
