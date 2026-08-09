class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/leftrk/openclaude"
  # Built from the leftrk fork (carries local fixes, e.g. the auto-compact
  # message-count gate). Release steps:
  #   1. tag the fork: git tag v<version> && git push origin v<version>
  #   2. update `url`/`version` below and refresh `sha256` from the tag tarball
  #   3. rebuild bottles and replace the stale hashes in the bottle block
  url "https://github.com/leftrk/openclaude/archive/refs/tags/v0.27.1.tar.gz"
  sha256 "09275b6e75c1cd6597318748cc4dc42256e293791b0756c168b60ca69cb6ca1f"
  license "SEE LICENSE FILE"
  version "0.27.1"
  head "https://github.com/leftrk/openclaude.git", branch: "main"






  # No bottle block for 0.27.1: the previous hashes were for the upstream
  # Gitlawb v0.27.0 build. Rebuild bottles from the leftrk fork release and
  # re-add a bottle block before pouring again.

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
