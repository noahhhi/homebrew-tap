class Horndis < Formula
  desc "Entitlement-free Android RNDIS USB tethering for modern macOS"
  homepage "https://github.com/noahhhi/HoRNDIS-Userspace"
  url "https://github.com/noahhhi/HoRNDIS-Userspace/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "b5b60b4375504cc2fc7b9a1c82ee60524861176a24fc63bc66eb71897c99f5b6"
  license "GPL-3.0-or-later"
  revision 1
  head "https://github.com/noahhhi/HoRNDIS-Userspace.git", branch: "main"

  depends_on macos: :big_sur

  def install
    system "make", "VERSION=#{version}"
    system "make", "install", "PREFIX=#{prefix}", "VERSION=#{version}"
    system "/usr/bin/codesign", "--force", "--deep", "--sign", "-", prefix/"HoRNDISStatus.app"
  end

  def caveats
    <<~EOS
      Install and start the network service and menu bar app once with:
        horndis-install

      This requests administrator authorization once for the fixed network
      service. Normal reconnects and menu use do not require it again.

      Before uninstalling the Formula, remove the persistent components with:
        horndis-status uninstall
        sudo horndis service uninstall
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/horndis --version")
    assert_match version.to_s, shell_output("#{bin}/horndis-status --version")
    assert_predicate prefix/"HoRNDISStatus.app/Contents/MacOS/horndis-status", :executable?
    assert_predicate prefix/"HoRNDISStatus.app/Contents/Resources/horndis", :executable?
    assert_path_exists prefix/"HoRNDISStatus.app/Contents/Resources/HoRNDISStatus.icns"
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", prefix/"HoRNDISStatus.app"
  end
end
