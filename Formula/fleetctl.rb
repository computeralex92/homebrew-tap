class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"

  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.86.1/fleetctl_v4.86.1_macos.tar.gz"
  sha256 "d4f7db86dcb60dc241177505819c20619401dbbbd6003c0091a2888e1d921d36"
  license "MIT"

  livecheck do
    url "https://github.com/fleetdm/fleet/releases"
    regex(%r{href=.*?/tag/fleet-v?(\d+(?:\.\d+)+)"}i)
  end

  def install
    bin.install "fleetctl"
  end

  test do
    assert_predicate bin/"fleetctl", :executable?
  end
end
