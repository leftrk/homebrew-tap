class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/leftrk/openclaude"
  # Built from the leftrk fork (carries local fixes, e.g. the auto-compact
  # message-count gate). The url/sha256/version fields below are maintained
  # automatically by leftrk/openclaude's homebrew-tap.yml workflow on every
  # pushed v* tag; it also drops the stale bottle block and dispatches a
  # bottle rebuild (bottle.yml re-adds fresh hashes). Edit by hand only for
  # emergencies.
  url "https://github.com/leftrk/openclaude/archive/refs/tags/v28.2.0.tar.gz"
  sha256 "e002745ac1ef79cf5017ff03ef44a510b0adcdcd3b2a374d84c9b3715a890bd0"
  license "SEE LICENSE FILE"
  version "28.2.0"
  head "https://github.com/leftrk/openclaude.git", branch: "main"




bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "80668721d9aa0a08db89a19be096bc2e91ebdd72d284b50302650cde8eacbe99"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0156bbf0c58884e96c662ed71d955ff708a307341082edc9d7216793c3703ec8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d97e10b3f1a09763e135f3e8c162c582c64e9bc67712b7f56f62364366fc6632"
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
