class Rmsafe < Formula
  desc "Modern rm replacement with trash, undo, and Btrfs support"
  homepage "https://github.com/leftrk/rmsafe"
  license "GPL-2.0-only"

  depends_on "python@3.11"

  resource "rmsafe" do
    url "https://files.pythonhosted.org/packages/py3/r/rmsafe/rmsafe-1.1.1-py3-none-any.whl"
    sha256 "598e58357c5e9a05efd3a3423d11bec83bb5ea00bae824ad4e476986f76cd8a1"
  end

  def install
    python3 = "python3.11"
    venv = virtualenv_create(libexec, python3)

    venv.install_resources(resources)
    bin.install_symlink libexec/"bin/rmsafe"
  end

  def caveats
    <<~EOS
      rmsafe provides safe file deletion with undo support.

      Commands:
        rmsafe trash file.txt      # Move to trash
        rmsafe list                # List trashed files
        rmsafe restore file.txt    # Restore from trash
        rmsafe undo                # Undo last deletion
        rmsafe empty --days 30     # Clean old files
        rmsafe status              # Show trash stats

      Recommended aliases (add to ~/.zshrc or ~/.bashrc):
        alias rm='rmsafe trash'
        alias rl='rmsafe list'
        alias rr='rmsafe restore'
    EOS
  end

  test do
    assert_predicate bin/"rmsafe", :exist?
    output = shell_output("#{bin}/rmsafe --help")
    assert_match "trash", output
    assert_match "restore", output
  end
end
