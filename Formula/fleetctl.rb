class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  license "MIT"

  if OS.mac?
    url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.86.1/fleetctl_v4.86.1_macos.zip"
    sha256 "ab6510afc7686f5416596da16476b5a996dfa86d5b7dded6d77f85ff228f96a0"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.86.1/fleetctl_v4.86.1_linux_amd64.zip"
      sha256 "2883b8166c8b09a584de75708558c926b74df4eab48229972b098d40570952d0"
    end

    if Hardware::CPU.arm?
      url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.86.1/fleetctl_v4.86.1_linux_arm64.zip"
      sha256 "92ceee1089c4be0d74afc5289f6e3faa165efb38d4a1a9059fe06c13794cfbbd"
    end
  end

  livecheck do
    url "https://github.com/fleetdm/fleet/releases"
    regex(%r{href=.*?/tag/fleet-v?(\d+(?:\.\d+)+)"}i)
  end

  def install
    bin.install "fleetctl"
  end

  test do
    assert_match "fleetctl - version", shell_output("#{bin}/fleetctl --version 2>&1")
  end
end
