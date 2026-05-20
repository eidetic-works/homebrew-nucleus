class Eideticd < Formula
  desc "Always-on memory daemon for AI workflows — captures Claude Code, Cursor, and Cowork sessions to local SQLite"
  homepage "https://eidetic.works"
  version "0.0.56"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.56/eideticd-darwin-arm64.tar.gz"
      sha256 "e58a1642d4f64ea3b3d34303d7666b2bd2530fb730d9c6c535a95f50b424d19f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.56/eideticd-linux-amd64.tar.gz"
      sha256 "78855a9a31ca149fcbc773a18925a95f5623a529c63afc926f540daf249359eb"
    end
    on_arm do
      url "https://github.com/eidetic-works/eidetic-daemon/releases/download/v0.0.56/eideticd-linux-arm64.tar.gz"
      sha256 "fc6d4cf8bd40593b458cf224c974646c1e33dd3efed185c86256d9d83b959fd5"
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
