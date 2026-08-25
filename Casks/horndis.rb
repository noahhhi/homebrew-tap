cask "horndis" do
  version "0.3.7"
  sha256 "19eae6a755bed037152bdd252d1d75fa73cb00453e7a5f135a361357959753c0"

  url "https://github.com/noahhhi/HoRNDIS-Userspace/releases/download/v#{version}/HoRNDIS-Userspace-v#{version}-macos-universal.pkg"
  name "HoRNDIS Userspace"
  desc "Android RNDIS USB tethering without a kernel extension"
  homepage "https://github.com/noahhhi/HoRNDIS-Userspace"

  depends_on macos: :big_sur

  pkg "HoRNDIS-Userspace-v#{version}-macos-universal.pkg"

  uninstall quit:    "io.github.noahhhi.horndis.status",
            script:  {
              executable: "/Applications/HoRNDIS Status.app/Contents/Resources/horndis-uninstall",
              sudo:       true,
            },
            pkgutil: "io.github.noahhhi.horndis.pkg"

  caveats <<~EOS
    HoRNDIS installs its menu bar app in:
      /Applications/HoRNDIS Status.app

    It also installs the `horndis` command and `man horndis`. The package
    requests one administrator authorization to activate its fixed network
    service. HoRNDIS does not compile locally. Homebrew itself still lists the
    Command Line Tools or Xcode as a requirement for a fully supported Homebrew
    installation; the identical release package can be installed without them.

    If the menu bar app is quit, reopen it from Applications or run:
      horndis start
  EOS
end
