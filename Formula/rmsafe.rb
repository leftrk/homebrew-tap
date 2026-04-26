class Rmsafe < Formula
  include Language::Python::Virtualenv

  desc "Modern rm replacement with trash, undo, and Btrfs support"
  homepage "https://github.com/leftrk/rmsafe"
  url "https://github.com/leftrk/rmsafe.git", tag: "v1.1.0"
  license "MIT"
  head "https://github.com/leftrk/rmsafe.git", branch: "main"

  depends_on "python@3.11"

  # Uses virtualenv_install_with_resources which handles dependencies automatically
  # from pyproject.toml when installing from git

  def install
    # Create virtualenv and install from git source
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install(buildpath)
    bin.install_symlink(venv.bin/"rmsafe")
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
    # Test CLI installation
    assert_predicate bin/"rmsafe", :exist?

    # Test --help
    output = shell_output("#{bin}/rmsafe --help")
    assert_match "trash", output
    assert_match "restore", output

    # Test trash operation
    test_file = testpath/"delete_me.txt"
    test_file.write "test content"
    result = shell_output("#{bin}/rmsafe trash #{test_file}", 0)
    assert_match "delete_me.txt", result
    assert !test_file.exist?
  end
end