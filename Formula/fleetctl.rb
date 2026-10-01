class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.92.2/fleetctl_v4.92.2_macos.tar.gz"
  sha256 "2d0599c2f56fb14c53753f4353134b853d695ea8864d95b5d775a8ac426d9b8d"
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
