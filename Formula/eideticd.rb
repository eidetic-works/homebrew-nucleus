class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.31"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.31/eideticd-darwin-arm64.tar.gz"
      sha256 "0a34610af6e9011f4eeea97bb6208e1d965df53cd8e031bb26fe3847ec7f1285"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.31/eideticd-linux-amd64.tar.gz"
      sha256 "8e72fe2c5adc4a49b35f0da68ef9c049b39a4aeaf1e88426d53f90bdcd207a4b"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.31/eideticd-linux-arm64.tar.gz"
      sha256 "204c86604d13691ab296c4035df88c376ee60890de1242adf9158d3fe18e16de"
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

      MCP bridge for Claude Code / Cursor:
        pip install eidetic-mcp
        claude mcp add eidetic -- python -m eidetic_mcp.server

      Enable Sovereign Bridge (Cloudflare tunnel / iPhone access):
        eideticd -bridge :8420
        # token written to ~/.eidetic/bridge-token
    EOS
  end

  test do
    assert_match "eideticd", shell_output("#{bin}/eideticd -version 2>&1")
  end
end
