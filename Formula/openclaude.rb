class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.22.0.tar.gz"
  sha256 "3977bed29defcab0d65c6e33c80ece8ff9930166cd73b6859dd6582abf04560f"
  license "SEE LICENSE FILE"
  version "0.22.0"
  head "https://github.com/Gitlawb/openclaude.git", branch: "main"


  depends_on "bun" => :build
  depends_on "node"

  def install
    system "npm", "install", "--production"
    system "bun", "run", "build"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/openclaude"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openclaude --version")
  end
end
