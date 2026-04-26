class Rmsafe < Formula
  desc "Modern rm replacement with trash, undo, and Btrfs support"
  homepage "https://github.com/leftrk/rmsafe"
  license "GPL-2.0-only"
  url "https://files.pythonhosted.org/packages/source/r/rmsafe/rmsafe-1.1.1.tar.gz"
  sha256 "aef331dc6c072d55ed05fe9181b4b1dc2efdf7b1b3c3d416bdf1f5030f67ab6a"
  head "https://github.com/leftrk/rmsafe.git", branch: "main"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install_and_link(buildpath)
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
