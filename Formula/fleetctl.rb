class Fleetctl < Formula
  desc "Command-line interface for Fleet Device Management"
  homepage "https://fleetdm.com"
  url "https://github.com/fleetdm/fleet/archive/refs/tags/fleet-v4.87.0.tar.gz"
  sha256 "e936c930ae08e564488b677317507fc8c24ccfeaa01c5be9a16842c6fe884c61"
  license "MIT"
  livecheck do
    url :stable
    regex(/^fleet-v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build
  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/fleetctl"
  end

  test do
    assert_predicate bin/"fleetctl", :executable?
  end
end
