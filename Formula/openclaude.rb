class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/leftrk/openclaude"
  # Built from the leftrk fork (carries local fixes, e.g. the auto-compact
  # message-count gate). The url/sha256/version fields below are maintained
  # automatically by leftrk/openclaude's homebrew-tap.yml workflow on every
  # pushed v* tag; it also drops the stale bottle block and dispatches a
  # bottle rebuild (bottle.yml re-adds fresh hashes). Edit by hand only for
  # emergencies.
  url "https://github.com/leftrk/openclaude/archive/refs/tags/v28.0.0.tar.gz"
  sha256 "75d96db5139548976c86f3c2577e286e62d4b5e39469fcbcbc591a5250d8fba0"
  license "SEE LICENSE FILE"
  version "28.0.0"
  head "https://github.com/leftrk/openclaude.git", branch: "main"

bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bcd1c6e37186b2faaec3c44b7024ef30da599c5b1311c3e0a3b13576213710b3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "90615cd6a7595a46fb6fc983fcdc8873ac246746a3e5310513963403b80264cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af8e0ad25353005514037c4d68ab03287e015a081a700fcbad46a7062f325102"
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
