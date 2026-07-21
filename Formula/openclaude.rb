class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/Gitlawb/openclaude"
  url "https://github.com/Gitlawb/openclaude/archive/refs/tags/v0.25.0.tar.gz"
  sha256 "5e2e441d6b8c83b906f39a1cdc8cf27ea75ce3e0c4d0524adfad50f59d97fc91"
  license "SEE LICENSE FILE"
  version "0.25.0"
  head "https://github.com/Gitlawb/openclaude.git", branch: "main"




bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d1b7855a98c28984e2c298b27d27461215c51dfb21eae8292d767975f3e31995"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "226e6caa7a447323249ed20afa08cba63d380d6401a9ed7cd9a4d93f79ea37dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "edb23f2a4459e89c5f31f3be28fcc15b8ca615b6bc60fe5b7f145ed654e1d9f4"
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
