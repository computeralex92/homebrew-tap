class IngressNginxMigration < Formula
  desc "Tool to migrate from ingress-nginx to Traefik"
  homepage "https://github.com/traefik/ingress-nginx-migration"
  url "https://github.com/traefik/ingress-nginx-migration/releases/download/v1.2.1/ingress-nginx-migration-v1.2.1-darwin-arm64.tar.gz"
  sha256 "f5ba92c6cb695a712df5c038062b65afcdbe2c279d6fd444cda2c255b4d2a6a1"
  license "Apache-2.0"
  version_scheme 1

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    depends_on arch: :arm64
  end

  def install
    bin.install "ingress-nginx-migration"
  end

  test do
    assert_predicate bin/"ingress-nginx-migration", :executable?
  end
end
