class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.22.0.tar.gz"
  sha256 "3977bed29defcab0d65c6e33c80ece8ff9930166cd73b6859dd6582abf04560f"
  license "SEE LICENSE FILE"
  version "0.22.0"
  head "https://github.com/Gitlawb/openclaude.git", branch: "main"


bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b11ea8ac1b16a1904c069a4c0652a01125f362e3185bece5afb9cfe4e94acbf7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5db39868fe0e80387c21fe32a8957027e3380380eeb8bb503bff8fee1ffbd272"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dcba559eb61f3ef4e91e5869aea536e95c1114947d8de34637e4722c780d32b1"
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
