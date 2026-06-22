class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  license "MIT"

  if OS.mac?
    url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.87.0/fleetctl_v4.87.0_macos.tar.gz"
    sha256 "e120376970999454621c8681dd93e5550a8abc215cdaf0fc829e4fdf6920c721"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.87.0/fleetctl_v4.87.0_linux_amd64.tar.gz"
      sha256 "5e66cac64e638653d10408c0cb29a4347777c20f42918c71c44f401dcd5782c9"
    end

    if Hardware::CPU.arm?
      url "https://github.com/fleetdm/fleet/releases/download/fleet-v4.87.0/fleetctl_v4.87.0_linux_arm64.tar.gz"
      sha256 "abfe74b1205db855d84089293e83f0da6879e9189b10d00e4b955103fabdb4ca"
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
    assert_predicate bin/"fleetctl", :executable?
  end
end
