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






  # No bottle block for 0.27.2: the previous hashes were for the upstream
  # Gitlawb v0.27.0 build. The automated bottle workflow re-adds a bottle
  # block on the next release bump.

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
