class Rmsafe < Formula
  include Language::Python::Virtualenv

  desc "Modern rm replacement with trash, undo, and Btrfs support"
  homepage "https://github.com/leftrk/rmsafe"
  url "https://files.pythonhosted.org/packages/source/r/rmsafe/rmsafe-1.1.1.tar.gz"
  sha256 "aef331dc6c072d55ed05fe9181b4b1dc2efdf7b1b3c3d416bdf1f5030f67ab6a"
  license "GPL-2.0-only"
  head "https://github.com/leftrk/rmsafe.git", branch: "main"

  depends_on "python@3.11"

  resource "typer" do
    url "https://files.pythonhosted.org/packages/source/t/typer/typer-0.25.0.tar.gz"
    sha256 "123eaf9f19bb40fd268310e12a542c0c6b4fab9c98d9d23342a01ff95e3ce930"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/source/r/rich/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  def install
    virtualenv_install_with_resources
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
