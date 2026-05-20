class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.42"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.42/eideticd-darwin-arm64.tar.gz"
      sha256 "4127c14ad212e6ff2043ef940891389cea4d754913c279c8ce2b139eed20d14c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.42/eideticd-linux-amd64.tar.gz"
      sha256 "e2a4553814337b08bac20b7f8f78c1393ca4956065c5590240ecbd49e2296a67"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.42/eideticd-linux-arm64.tar.gz"
      sha256 "e9538980b218d3c53e4b733f1dccf6d4fc4230fb5217dc393270bff62f633aff"
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
