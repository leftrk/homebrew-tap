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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "074e02ec155c7f2fffe7083d2078f0cb25657ae95fa13ef60b6157ae774e1532"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "dcde74bde7c8a5f3620e50330697cdff26b5ecf7184151a280be24c7aeacf7e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "03caec4579b70efb4783b1be36c1ce9517cd583007e2b6e8001078aec815a82b"
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
