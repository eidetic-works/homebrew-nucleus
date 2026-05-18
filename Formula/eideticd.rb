class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.25"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.25/eideticd-darwin-arm64.tar.gz"
      sha256 "deb04e44af28460e38ed679f8465c5b48f31ff78a72d18847f835399dbcea5aa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.25/eideticd-linux-amd64.tar.gz"
      sha256 "9726361c14a5beaa30a3f823634be075090b41c4a3d5dad5c3d3cdcacf6b58bd"
    end
  end

  def install
    bin.install "eideticd"
  end

  def caveats
    <<~EOS
      To start eideticd at login, run:
        eideticd -install

      Or manually via launchd:
        cp #{HOMEBREW_PREFIX}/share/eideticd/launchd.plist ~/Library/LaunchAgents/works.eidetic.eideticd.plist
        launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/works.eidetic.eideticd.plist

      Check it's running:
        curl --unix-socket /tmp/eidetic-daemon.sock http://localhost/healthz

      MCP bridge for Claude Code / Cursor:
        pip install eidetic-mcp
        claude mcp add eidetic -- python -m eidetic_mcp.server
    EOS
  end

  test do
    assert_match "eideticd", shell_output("#{bin}/eideticd -version 2>&1")
  end
end
