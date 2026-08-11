class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/leftrk/openclaude"
  # Built from the leftrk fork (carries local fixes, e.g. the auto-compact
  # message-count gate). The url/sha256/version fields below are maintained
  # automatically by leftrk/openclaude's homebrew-tap.yml workflow on every
  # pushed v* tag; it also drops the stale bottle block and dispatches a
  # bottle rebuild (bottle.yml re-adds fresh hashes). Edit by hand only for
  # emergencies.
  url "https://github.com/leftrk/openclaude/archive/refs/tags/v29.0.0.tar.gz"
  sha256 "e0a06f13fa8a118a346d0284033cb80d1f29ef2b9754f2fd4810622ce4a5f7f1"
  license "SEE LICENSE FILE"
  version "29.0.0"
  head "https://github.com/leftrk/openclaude.git", branch: "main"






bottle do
    root_url "https://github.com/leftrk/homebrew-tap/releases/download/bottles"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "aff95e63af3611e2a3c03f1043f6d7bf2fbcea2c487809837d883778182f6442"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d6aa6818658a093d45997ccdb27de43982aebd9b28edb36528af5d767e59259b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8d015d4fc06c7140c7d8235b5c734f5bd00f294d65a2c43da4d05624500c2e1a"
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
