class TmuxSmartName < Formula
  include Language::Python::Virtualenv

  desc "Smart tmux window names like IDE tablines"
  homepage "https://github.com/leftrk/tmux-smart-name"
  url "https://github.com/leftrk/tmux-smart-name/archive/refs/tags/v1.0.7.tar.gz"
  sha256 "6459fc6cb579b556929d0e0d90227c8606d01c84751456e86bf288690b4a2838"
  license "MIT"
  head "https://github.com/leftrk/tmux-smart-name.git", branch: "master"

  depends_on "tmux"
  depends_on "python"

  resource "libtmux" do
    url "https://files.pythonhosted.org/packages/source/l/libtmux/libtmux-0.55.1.tar.gz"
    sha256 "dcee950537b8bda4337267bc2cb62b434c4c8da3a75c1546151674238ef14e20"
  end

  def install
    virtualenv_install_with_resources
    libexec.install "tmux_window_name.tmux"
  end

  def caveats
    <<~EOS
      To enable this plugin, add to your ~/.tmux.conf:

        With TPM (recommended):
          set -g @plugin 'leftrk/tmux-smart-name'

        Without TPM:
          run-shell #{libexec}/tmux_window_name.tmux

      Note: If using tmux-resurrect, load this plugin BEFORE it.
    EOS
  end

  test do
    assert_predicate libexec/"tmux_window_name.tmux", :exist?
    assert_predicate libexec/"bin/tmux-smart-name", :exist?
  end
end