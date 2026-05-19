class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.28"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.28/eideticd-darwin-arm64.tar.gz"
      sha256 "1f6ba8f21eaec65f9d912abc40f5938c3ea62d5fab1cdb953f1f8be13615d1b6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.28/eideticd-linux-amd64.tar.gz"
      sha256 "328fa9a0649097523584c818fb21abab46938cfd562842564bf2a03128724c65"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.28/eideticd-linux-arm64.tar.gz"
      sha256 "30c1c24dcb7c88fef6a1322dd418cc067807bc31c7919e48d69ead50be522033"
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
