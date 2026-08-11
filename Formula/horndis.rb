class Horndis < Formula
  desc "Entitlement-free Android RNDIS USB tethering for modern macOS"
  homepage "https://github.com/noahhhi/HoRNDIS-Userspace"
  url "https://github.com/noahhhi/HoRNDIS-Userspace/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "92dcadabda2e9b7677c50d5824ba4ac56f8799989614c998b5c971982363a51f"
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
