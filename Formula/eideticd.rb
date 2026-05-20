class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.58"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.58/eideticd-darwin-arm64.tar.gz"
      sha256 "4d705876add75fba1b12fdb6cb34c64417a99f893544a3b83ac4669eef24f821"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.58/eideticd-linux-amd64.tar.gz"
      sha256 "dfd79944fac6992340c9a74b9df6ea6a2452dee9cf66fa4f926b6b0a0c6a2691"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.58/eideticd-linux-arm64.tar.gz"
      sha256 "e8bf8c1e277f5105d5c3748cb67d8b88aa369ce22c1248aa400a745156e9dbc1"
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
