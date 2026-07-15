class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.24.0.tar.gz"
  sha256 "e96df408e2b1746c7e981810016a7049ce490ebfd360eeae1cc891a9e1e2e382"
  license "SEE LICENSE FILE"
  version "0.24.0"
  head "https://github.com/Gitlawb/openclaude.git", branch: "main"



bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c9f13984d722fc14cc1fa8695d62ac657e16fd26188944a19f6cc64cd8a3d68e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "620b352466254c3722922a42f23835d00b6a14211e8b6e136013610007a58afb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b48d1714142892eb990d7df08f05484601bd38a5308ced2d7a969c57cc3e2bf5"
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
