# Homebrew tap for Beam

[Beam](https://github.com/awaismemon26/beam-macos) is a window switcher and launcher for macOS.

```bash
brew install --cask awaismemon26/tap/beam
```

Beam isn't notarized yet. The first time you open it, macOS says it can't verify it: click **Done**, then open
**System Settings ▸ Privacy & Security** and click **Open Anyway**. Then open Beam again and turn on
**Accessibility** when it asks.

Update with `brew upgrade --cask beam`. Uninstall with `brew uninstall --cask beam`; add `--zap` to also delete
Beam's settings and data.

## Maintaining

Every Beam release attaches `beam.rb`. Copy it to `Casks/beam.rb` here and push.
