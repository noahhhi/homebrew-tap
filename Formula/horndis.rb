class Horndis < Formula
  desc "Entitlement-free Android RNDIS USB tethering for modern macOS"
  homepage "https://github.com/noahhhi/HoRNDIS-Userspace"
  url "https://github.com/noahhhi/HoRNDIS-Userspace/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "87e6c44bf0daf1c3007cc04cf708da6a379ac8f3e0c413865610a9c4d4b3898c"
  license "GPL-3.0-or-later"
  head "https://github.com/noahhhi/HoRNDIS-Userspace.git", branch: "main"

  depends_on macos: :monterey

  def install
    system "make", "VERSION=#{version}"
    bin.install "build/horndis"
  end

  def caveats
    <<~EOS
      Install and start the privileged USB networking service once with:
        sudo horndis service install

      This copies the tested binary to /Library/PrivilegedHelperTools and asks
      for administrator authorization only during installation or upgrade.

      Alternatively, use Homebrew Services (do not run both service methods):
        sudo brew services start noahhhi/tap/horndis
    EOS
  end

  service do
    run [opt_bin/"horndis", "run"]
    require_root true
    keep_alive true
    process_type :interactive
    log_path var/"log/horndis.log"
    error_log_path var/"log/horndis.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/horndis --version")
  end
end
