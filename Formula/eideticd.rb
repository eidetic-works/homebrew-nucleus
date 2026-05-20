class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.49"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.49/eideticd-darwin-arm64.tar.gz"
      sha256 "8b8d8d1a1026fbf711facb50ba225f0738cdca367fd9c6487675a8597ad2fba0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.49/eideticd-linux-amd64.tar.gz"
      sha256 "7f62cfd4d9274ae84264fd56d0ab2bff97ed682bd8e0cd8dc0605dc877e4d6d5"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.49/eideticd-linux-arm64.tar.gz"
      sha256 "e113e62600cd52f18542ea0e44be53ebe931f6da5f5830cd100b2b51305391d2"
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
