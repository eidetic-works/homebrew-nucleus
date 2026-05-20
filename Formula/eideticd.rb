class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.44"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.44/eideticd-darwin-arm64.tar.gz"
      sha256 "2672b5c0e8deeca34a93c00cd1c0dfc22d2731cdb59173f481b047d83200bb16"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.44/eideticd-linux-amd64.tar.gz"
      sha256 "b30433a686f8e7dc3b1ac733d70083789bf4d0e0d5009c546e6a401a2b890618"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.44/eideticd-linux-arm64.tar.gz"
      sha256 "f679dc77b2fb9b2e6c7f7ea0ed759a878c7d3268ddca206231595132556083d8"
    end
  end

  def install
    bin.install "eideticd"
  end

  def caveats
    <<~EOS
      Register eideticd as a login-time service (launchd / systemd-user):
        eideticd -install

      Check it's running:
        curl --unix-socket /tmp/eidetic-daemon.sock http://localhost/healthz

      Show your engram stats:
        eideticd -stats

      Validate cloud sync (Pro):
        eideticd --check

      MCP bridge for Claude Code / Cursor:
        pip install eidetic-mcp
        claude mcp add eidetic -- python -m eidetic_mcp.server

      Browse engrams in the browser:
        eideticd -bridge :8421
        open https://eidetic.works/dashboard
    EOS
  end

  test do
    system "#{bin}/eideticd", "-version"
  end
end
