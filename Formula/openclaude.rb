class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.27.0.tar.gz"
  sha256 "d12ddac1b4719ef7e04ea1cc96395e3b5968f89f9fe63ba3e55ede38ffac9586"
  license "SEE LICENSE FILE"
  version "0.27.0"
  head "https://github.com/Gitlawb/openclaude.git", branch: "main"






bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b7373ed2336ff6942169b55b4912735b4ee98e4f0ef70bec1424615d7ff61acc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9f886dadc620c84793c7cce54658076954e6813f2bc87c48fb07b15c7be97ff2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eef39b126c2109f7d6caddca676f6ca28b91195820506df3bb2b327e91b3c44c"
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
