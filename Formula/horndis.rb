class Horndis < Formula
  desc "Entitlement-free Android RNDIS USB tethering for modern macOS"
  homepage "https://github.com/noahhhi/HoRNDIS-Userspace"
  url "https://github.com/noahhhi/HoRNDIS-Userspace/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "2b0b1b17a49fa192fab502a1df2f0e5fbad985a30f6e1421332ed5ac991021df"
  license "GPL-3.0-or-later"
  head "https://github.com/noahhhi/HoRNDIS-Userspace.git", branch: "main"

  depends_on macos: :big_sur

  def install
    system "make", "VERSION=#{version}"
    system "make", "install", "PREFIX=#{prefix}", "VERSION=#{version}"
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
  end
end
