# Awais's Homebrew tap

macOS apps by [Awais Memon](https://github.com/awaismemon26), installable with [Homebrew](https://brew.sh).

```bash
brew install --cask awaismemon26/tap/<app>
```

Or add the tap once, then use short names: `brew tap awaismemon26/tap`, then `brew install --cask <app>`.

## Apps

| App | Install | What it is |
|---|---|---|
| [Beam](https://github.com/awaismemon26/beam-macos) | `brew install --cask awaismemon26/tap/beam` | Window switcher and management |

Update with `brew upgrade --cask <app>`. Uninstall with `brew uninstall --cask <app>`; add `--zap` to also delete
the app's settings and data.

### Apps that aren't notarized

An app that isn't notarized by Apple says so in its caveats (shown after installing). The first time you open it,
macOS says it can't verify the app: click **Done**, then open **System Settings ▸ Privacy & Security** and click
**Open Anyway**.

## Maintaining

```
Casks/<token>.rb      one file per macOS app (.app, .dmg, .pkg)
Formula/<name>.rb     command-line tools, if any are added later
```

### Adding an app

1. Pick a token: the app name in lowercase, with words separated by hyphens (`Beam` → `beam`, `Foo Bar` → `foo-bar`).
   The file name must match it: `Casks/foo-bar.rb`.
2. Write the cask: copy `Casks/beam.rb`, or the template below. Get the checksum with
   `shasum -a 256 FooBar-1.0.0.dmg`. If the app isn't notarized, add a `caveats` block with the Open Anyway steps
   (see `Casks/beam.rb`).
3. Add a row to the **Apps** table above.
4. Check it locally, then push. The **Check** workflow runs the same checks on every push and pull request.

   ```bash
   brew tap awaismemon26/tap "$PWD"     # once: tap this folder (later: brew update)
   brew style awaismemon26/tap
   brew audit --cask --strict awaismemon26/tap/foo-bar
   ```

### Cask template

```ruby
cask "foo-bar" do
  version "1.0.0"
  sha256 "<sha256 of the download>"

  url "https://github.com/awaismemon26/foo-bar/releases/download/v#{version}/FooBar-#{version}.dmg"
  name "Foo Bar"
  desc "One line, no app name, no trailing period"
  homepage "https://github.com/awaismemon26/foo-bar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Foo Bar.app"

  zap trash: [
    "~/Library/Application Support/Foo Bar",
    "~/Library/Preferences/dev.example.FooBar.plist",
  ]
end
```

### New versions

The **Bump versions** workflow runs daily. For each cask it reads the `livecheck` block (for GitHub apps: the
latest published release), and when there's a newer version it opens a pull request that updates `version` and
`sha256`. Merge the PR and users get the update with `brew upgrade`. Run it by hand from the Actions tab right after
publishing a release.

- Livecheck only sees public releases: an app's repository must be public.
- One-time repository setting: **Settings ▸ Actions ▸ General ▸ Workflow permissions ▸ Allow GitHub Actions to
  create and approve pull requests**.
- To update by hand instead, change `version` and `sha256` and push. Beam also attaches a ready-made `beam.rb` to
  every release.
