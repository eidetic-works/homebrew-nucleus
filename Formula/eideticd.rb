class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.29"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.29/eideticd-darwin-arm64.tar.gz"
      sha256 "67a6c54f10bb2ebdabffed1ff5c003dd2ef4da4c5ca56306370ff4d4bc489082"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.29/eideticd-linux-amd64.tar.gz"
      sha256 "4d293e798b1e58990d2431a32604916d43da5db60a95cc33e00c9fe40aa1c530"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.29/eideticd-linux-arm64.tar.gz"
      sha256 "aac80f6a9aedac5c22676b53daf73579e6c9d0751c6fe871cd27e160e951ddb5"
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
    EOS
  end

  test do
    assert_match "eideticd", shell_output("#{bin}/eideticd -version 2>&1")
  end
end
