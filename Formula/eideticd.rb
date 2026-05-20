class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.52"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.52/eideticd-darwin-arm64.tar.gz"
      sha256 "e78bccdab0dedecd988379dc250e57962b2427515e30edcc6a0772711e24adeb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.52/eideticd-linux-amd64.tar.gz"
      sha256 "d7f1fc2b2f907fd822d79008c2bce33f297013a0ddd728d29a0d140d89ccdb58"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.52/eideticd-linux-arm64.tar.gz"
      sha256 "a624f1fe56c2eb0d8aee2659c11dbe56ddfdcd944ea106a257faa2c2be298e3b"
    end
  end

  def install
    bin.install "eideticd"
    # Shell completions (v0.0.48+)
    if File.exist?("completions/eideticd.bash")
      bash_completion.install "completions/eideticd.bash" => "eideticd"
    end
    if File.exist?("completions/_eideticd")
      zsh_completion.install "completions/_eideticd"
    end
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
