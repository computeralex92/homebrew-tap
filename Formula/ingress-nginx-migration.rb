class IngressNginxMigration < Formula
  desc "Tool to migrate from ingress-nginx to Traefik"
  homepage "https://github.com/traefik/ingress-nginx-migration"
  url "https://github.com/traefik/ingress-nginx-migration/releases/download/v1.2.1/ingress-nginx-migration-v1.2.1-darwin-arm64.tar.gz"
  version "1.2.1"
  sha256 "f5ba92c6cb695a712df5c038062b65afcdbe2c279d6fd444cda2c255b4d2a6a1"
  license "Apache-2.0"
  version_scheme 1

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_intel do
      url "https://github.com/traefik/ingress-nginx-migration/releases/download/v1.2.1/ingress-nginx-migration-v1.2.1-darwin-amd64.tar.gz"
      sha256 "eb32a29724fce2a1b132132577b38bca3eb3561820780c0d54ddf8014ac04a33"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/traefik/ingress-nginx-migration/releases/download/v1.2.1/ingress-nginx-migration-v1.2.1-linux-amd64.tar.gz"
      sha256 "f9e674b28164f965744d5ffb70c2ab97a4c15b937becb904973dd8a230860380"
    end
    on_arm do
      url "https://github.com/traefik/ingress-nginx-migration/releases/download/v1.2.1/ingress-nginx-migration-v1.2.1-linux-arm64.tar.gz"
      sha256 "a2382ff16a5bd38227d68395bae80fcaac2c393a57a447bb7ed0961a3ed52324"
    end
  end

  def install
    bin.install "ingress-nginx-migration"
  end

  test do
    assert_predicate bin/"ingress-nginx-migration", :executable?
  end
end
