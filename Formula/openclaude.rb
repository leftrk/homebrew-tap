class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.23.0.tar.gz"
  sha256 "0c3ca070da49bd7a1b3cf07700df9b213a755a79a0ff2e67ed8870218ebfe872"
  license "SEE LICENSE FILE"
  version "0.23.0"
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
    # NOTE: reactor/react-reconciler/scheduler live in package.json devDependencies
    # and scripts/build.ts resolves them at bundle time (production-react-bundle
    # plugin). std_npm_args / --production would skip devDependencies and break
    # the build with "Cannot find module 'react/package.json'".
    system "npm", "install"
    system "bun", "run", "build"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/openclaude"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openclaude --version")
  end
end
