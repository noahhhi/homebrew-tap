# Noahhhi Homebrew Tap

## Install HoRNDIS Userspace

```sh
brew install --cask noahhhi/tap/horndis
```

The Cask downloads the prebuilt universal `.pkg`; HoRNDIS does not compile
locally. One standard Installer authorization installs `/Applications/HoRNDIS
Status.app`, the `horndis` command, `man horndis`, and the persistent network
service. Macs without Homebrew can use the identical release `.pkg` directly.

If the menu app has been quit, reopen it from Applications or run:

```sh
horndis start
```

Project documentation and troubleshooting: [HoRNDIS Userspace](https://github.com/noahhhi/HoRNDIS-Userspace).

For a `brew bundle` `Brewfile`:

```ruby
tap "noahhhi/tap"
cask "horndis"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
