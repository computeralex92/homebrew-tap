class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.95.0/fleetctl_v4.95.0_macos.tar.gz"
  sha256 "d392171049a5a5e4c49d26f092489d9b2dd1b17fd3379058688b57a2f2a2a10c"
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
