class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.92.1/fleetctl_v4.92.1_macos.tar.gz"
  sha256 "daf5ac5e5eba524054fcc43733efdefed313c43333d5187f7a38005e87594a43"
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
