require 'formula'

class Hub < Formula
  homepage "http://hub.github.com/"
  url "https://github.com/github/hub/releases/download/v2.2.0-rc1/hub-mac-amd64-2.2.0-rc1.tar.gz"
  sha1 "413ce80d32f6313cef010e0edb1e664e1fff7427"

  def install
    bin.install "hub"
    man1.install Dir["man/*"]
    bash_completion.install "etc/hub.bash_completion.sh"
    zsh_completion.install "etc/hub.zsh_completion" => "_hub"
  end

  test do
    HOMEBREW_REPOSITORY.cd do
      assert shell_output("#{bin}/hub version").split("\n").include?("hub version #{version}")
    end
  end
end
