class Openclaude < Formula
  desc "OpenClaude opens coding-agent workflows to any LLM — OpenAI, Gemini, DeepSeek, Ollama, and 200+ models"
  homepage "https://github.com/leftrk/openclaude"
  # Built from the leftrk fork (carries local fixes, e.g. the auto-compact
  # message-count gate). The url/sha256/version fields below are maintained
  # automatically by leftrk/openclaude's homebrew-tap.yml workflow on every
  # pushed v* tag; it also drops the stale bottle block and dispatches a
  # bottle rebuild (bottle.yml re-adds fresh hashes). Edit by hand only for
  # emergencies.
  url "https://github.com/leftrk/openclaude/archive/refs/tags/v29.1.0.tar.gz"
  sha256 "9948da880a3c8bee414efcccc68797b2177029341d310ee20f24b18a5e5eb44f"
  license "SEE LICENSE FILE"
  version "29.1.0"
  head "https://github.com/leftrk/openclaude.git", branch: "main"







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
