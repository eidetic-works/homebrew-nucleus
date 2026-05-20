class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.45"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.45/eideticd-darwin-arm64.tar.gz"
      sha256 "e27bf8c319e2d08752d21d6ff09cb7d0c902e07ad06515566fd1598815d60de2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.45/eideticd-linux-amd64.tar.gz"
      sha256 "3392574ce55094e7c0b0a8c3dffa0dc57965c5b15a27616a0078008ba3af4742"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.45/eideticd-linux-arm64.tar.gz"
      sha256 "61f4dc1de2cb21fdcd0f0c3c451c78c64e63a1a7713fb4c75a8d00c0f6f9f704"
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
