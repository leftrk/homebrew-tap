class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/leftrk/openclaude"
  # Built from the leftrk fork (carries local fixes, e.g. the auto-compact
  # message-count gate). The url/sha256/version fields below are maintained
  # automatically by leftrk/openclaude's homebrew-tap.yml workflow on every
  # pushed v* tag; it also drops the stale bottle block and dispatches a
  # bottle rebuild (bottle.yml re-adds fresh hashes). Edit by hand only for
  # emergencies.
  url "https://github.com/leftrk/openclaude/archive/refs/tags/v28.1.0.tar.gz"
  sha256 "b46807387ebaabfc79620c86b77a63138b989fedb425812a1d833493dcac72c1"
  license "SEE LICENSE FILE"
  version "28.1.0"
  head "https://github.com/leftrk/openclaude.git", branch: "main"


bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "961f0a7cebc02fa1d686be2356bd2adc542a8da39d12171105d3a4ffd6158c20"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "ac617f669fd278670faf35f249e96918629e65e3d5f99c6bd94744067185894f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "30aaa7c33cac34e22367b8c4a70e0d2ec6d56638bc8f080357717fb260f16e3f"
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
    # Ship only the runtime file set: the bundled dist/ plus the production
    # dependency tree (3 packages, ~10 MB). Prune node_modules down to
    # production deps and leave the source tree, scripts, dev deps, and
    # source maps behind — keeps the bottle at tens of MB, not hundreds.
    system "npm", "prune", "--omit=dev"
    libexec.install "bin", "vendor", "node_modules", "package.json", "README.md", "LICENSE"
    (libexec/"dist").install "dist/cli.mjs", "dist/sdk.mjs"
    (libexec/"src/entrypoints").install "src/entrypoints/sdk.d.ts",
                                        "src/entrypoints/sdk/coreTypes.generated.ts"
    bin.install_symlink libexec/"bin/openclaude"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openclaude --version")
  end
end
