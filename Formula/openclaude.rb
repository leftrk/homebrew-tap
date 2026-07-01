class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.21.0.tar.gz"
  sha256 "da1ad70f920e72bf1c0a4f99a13c424f5dd5afb83bd9c7a5247094b764011a8c"
  license "SEE LICENSE FILE"
  version "0.21.0"
  head "https://github.com/Gitlawb/openclaude.git", branch: "main"

  bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "536cf071f4a5a51afef07430cb91186f0bf1060529108a7530c86bd40bd650c8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2b8237ea0435098d3677e2144d39d1a11ee7953f88c514ec4b36c8f24a66ab04"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "df10b9156dd3442f6dae3426793a4a5436ad06b5d6023aa8b425978ea3217077"
  end

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
