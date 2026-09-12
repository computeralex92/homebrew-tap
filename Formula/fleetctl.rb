class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.91.1/fleetctl_v4.91.1_macos.tar.gz"
  sha256 "737f1312342b2440512624edd4db6a3ab978e9371330f70c86d37854ec168e8d"
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
