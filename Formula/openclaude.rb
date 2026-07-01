class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.21.0.tar.gz"
  sha256 "da1ad70f920e72bf1c0a4f99a13c424f5dd5afb83bd9c7a5247094b764011a8c"
  license "SEE LICENSE FILE"
  version "0.21.0"
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
