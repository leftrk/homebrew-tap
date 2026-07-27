class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.26.0.tar.gz"
  sha256 "f1f437595cd5abfb3a2f6c8a3e24c5959369bdb2b8a25f85471598cce32793e9"
  license "SEE LICENSE FILE"
  version "0.26.0"
  head "https://github.com/Gitlawb/openclaude.git", branch: "main"





bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "03c7b5c81c4c358fdb12addf7bc3178077fdaf3f8ee4ce1235dab569f26f124d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b80e3919b9f1204cee0f61d3b8092ac4acc4c976a55036444ca8e199cfa411ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "92dd97aef00f256d2be852e0c475a64af739d60422f28544e1abd60511464118"
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
