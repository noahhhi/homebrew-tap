# Noahhhi Homebrew Tap

## How do I install these formulae?

Install HoRNDIS Userspace directly:

```sh
brew install noahhhi/tap/horndis
sudo horndis service install
```

The second command performs the one-time administrator-authorized service installation. Android USB tethering then reconnects automatically without disabling SIP or requesting Apple DriverKit entitlements.

Project documentation and troubleshooting: [HoRNDIS Userspace](https://github.com/noahhhi/HoRNDIS-Userspace).

For other formulae in this tap, use `brew install noahhhi/tap/<formula>`.

Or `brew tap noahhhi/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "noahhhi/tap"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
