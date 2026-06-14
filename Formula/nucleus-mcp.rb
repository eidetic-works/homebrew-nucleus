class NucleusMcp < Formula
  include Language::Python::Virtualenv

  desc "Sovereign Agent OS — Persistent Memory, Governance & Compliance for AI Agents"
  homepage "https://nucleusos.dev"
  url "https://files.pythonhosted.org/packages/56/e5/5a697279d8645abe28d73f8227ecd21d3a0a25700f7295d59f5bedb26257/nucleus_mcp-1.13.1.tar.gz"
  sha256 "8c7723c0952176bf6adc74df76070837dba674609f3ae857c86c0d1b03e1ae85"
  license "MIT"
  head "https://github.com/eidetic-works/nucleus-mcp.git", branch: "main"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install_and_link buildpath
  end

  test do
    output = shell_output("#{bin}/nucleus --version 2>&1", 0)
    assert_match version.to_s, output
  end
end
