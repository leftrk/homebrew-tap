class Rmsafe < Formula
  desc "Modern rm replacement with trash, undo, and Btrfs support"
  homepage "https://github.com/leftrk/rmsafe"
  license "MIT"

  # PyPI package - Homebrew handles dependency resolution automatically
  pypi_packages "rmsafe"

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