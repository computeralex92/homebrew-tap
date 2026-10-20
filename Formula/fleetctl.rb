class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.93.1/fleetctl_v4.93.1_macos.tar.gz"
  sha256 "82b64c8d59f4420cdba08bc9c26d4ed5a7352e6bd200e1b6a8a52e6f1d37ca00"
  license "MIT"

  livecheck do
    url :stable
    regex(/^fleet-v?(\d+(?:\.\d+)+)$/i)
  end

  def install
    bin.install "fleetctl"
  end

  test do
    assert_predicate bin/"fleetctl", :executable?
  end
end
