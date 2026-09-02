class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.90.2/fleetctl_v4.90.2_macos.tar.gz"
  sha256 "1c911e660272a2092c96deeb89928c11ff17418f3ddea2132f3a3ec7825bb0cc"
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
