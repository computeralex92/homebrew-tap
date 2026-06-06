class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.86.1/fleetctl_v4.86.1_macos.zip"
  sha256 "ab6510afc7686f5416596da16476b5a996dfa86d5b7dded6d77f85ff228f96a0"
  license "MIT"

  def install
    bin.install "fleetctl"
  end

  test do
    assert_match "fleetctl - version", shell_output("#{bin}/fleetctl --version 2>&1")
  end
end
