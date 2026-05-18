class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.26"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.26/eideticd-darwin-arm64.tar.gz"
      sha256 "972aac35967098ebf02254ddd42351725465b7765e669284e131cfb5897cc638"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.26/eideticd-linux-amd64.tar.gz"
      sha256 "56c9abb2b4eb2e5a293daa490cf8936a47da8c8a72c09063238efabc3eaf3080"
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
