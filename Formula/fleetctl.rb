class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.88.0/fleetctl_v4.88.0_macos.tar.gz"
  sha256 "e6cd3e2e28c955a9f64c8f12c50e1e78935b7a30dac0f9253726725633f19b5d"
  license "MIT"

  livecheck do
    url :stable
    regex(/^fleet-v?(\d+(?:\.\d+)+)$/i)
  end

  on_linux do
    on_intel do
      url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.88.0/fleetctl_v4.88.0_linux_amd64.tar.gz"
      sha256 "847f9bfee46cd8a2f637975efbb4e8b5b2a5ed290af3759361721a4623338631"
    end
    on_arm do
      url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.88.0/fleetctl_v4.88.0_linux_arm64.tar.gz"
      sha256 "80d52c9b38960a6ddbaf9e6b1545f2aba24210e5c9274efe716eaf7ec33183a5"
    end
  end

  def install
    bin.install "fleetctl"
  end

  test do
    assert_predicate bin/"fleetctl", :executable?
  end
end
