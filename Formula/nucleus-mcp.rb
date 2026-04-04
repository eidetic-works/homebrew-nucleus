class NucleusMcp < Formula
  include Language::Python::Virtualenv

  desc "AI reliability that compounds — 114 MCP tools for persistent memory, governance, and training pipelines"
  homepage "https://nucleusos.dev"
  url "https://files.pythonhosted.org/packages/source/n/nucleus-mcp/nucleus_mcp-1.8.0.tar.gz"
  license "MIT"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "nucleus", shell_output("#{bin}/nucleus-mcp --help 2>&1", 0)
  end
end
