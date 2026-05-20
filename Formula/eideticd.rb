class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.55"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.55/eideticd-darwin-arm64.tar.gz"
      sha256 "94637bc89b40c7186b941952e4d90008d92d6b5e512a5e1bfaa810c6f2a125e0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.55/eideticd-linux-amd64.tar.gz"
      sha256 "4089ee941342e023ecfda12c61d78075412ee9f668e6e1b711c387d66b21ddc2"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.55/eideticd-linux-arm64.tar.gz"
      sha256 "facd25a0c6f0b0d15725d2c632cbd517c5360da13e29d80a94deff16f95d12d4"
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
