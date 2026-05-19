class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.27"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.27/eideticd-darwin-arm64.tar.gz"
      sha256 "f9487fa978d742cd4590b267099d11608d3d3e18ac3d785615c4b3b9601cf114"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.27/eideticd-linux-amd64.tar.gz"
      sha256 "82c91f1397338773c6bd2ce72747abb1b58265f03bb423563efc4abd540bc1fd"
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
