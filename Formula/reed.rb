# The reed formula.
#
# **Kept up to date by the release workflow, not by hand.** `ReedKeep/reed-private`'s release job knows the
# version and has already computed every SHA-256 for its own `SHA256SUMS`, so it rewrites the four values
# below and commits. A formula whose checksum is edited by a person is a formula that is eventually wrong,
# and `brew` will refuse the install rather than tell you why in a way that helps.
class Reed < Formula
  desc "One folder, every machine you own"
  homepage "https://github.com/ReedKeep/reed"
  # The source is not published yet. `:cannot_represent` is the honest answer here, not `:proprietary`,
  # which Homebrew does not have.
  license :cannot_represent
  version "0.0.0"

  on_macos do
    # One universal binary: the installer asks `uname -s` and nothing else on Darwin, so Intel and Apple
    # Silicon take the same file and the kernel picks.
    url "https://github.com/ReedKeep/reed/releases/download/v0.0.0/reed-macos-universal.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  on_linux do
    on_intel do
      url "https://github.com/ReedKeep/reed/releases/download/v0.0.0/reed-linux-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_arm do
      url "https://github.com/ReedKeep/reed/releases/download/v0.0.0/reed-linux-aarch64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "reed"
  end

  def caveats
    <<~EOS
      reed needs Tailscale, signed in as you, on every machine you want it on.
      That is how your machines find each other and how reed knows a peer is
      yours — there is no server and no account.

        tailscale status      # every machine should be in this list

      Then, once per machine:

        reed up

      If anything is not working, `reed doctor` says which part in one screen.
    EOS
  end

  test do
    # It has to run, not merely land. A formula that only checks the file exists passes for a binary that
    # cannot start on the machine it was just installed on.
    assert_match "reed", shell_output("#{bin}/reed --version")
    # And exit 2 is documented as "misuse: no state of the world would have made this valid", so it is a
    # cheap check that this is really reed and really this vintage.
    assert_match "unknown command", shell_output("#{bin}/reed definitely-not-a-command 2>&1", 2)
  end
end
