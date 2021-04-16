class Qcachegrind < Formula
  desc "Visualize data generated by Cachegrind and Calltree"
  homepage "https://kcachegrind.github.io/"
  url "https://download.kde.org/stable/release-service/20.12.3/src/kcachegrind-20.12.3.tar.xz"
  sha256 "95e18b85ae69a522f1f0047960c2dbcc2553af284d18b45d5373746a7e5f69ea"
  license "GPL-2.0-or-later"

  # We don't match versions like 19.07.80 or 19.07.90 where the patch number
  # is 80+ (beta) or 90+ (RC), as these aren't stable releases.
  livecheck do
    url "https://download.kde.org/stable/release-service/"
    regex(%r{href=.*?v?(\d+\.\d+\.(?:(?![89]\d)\d+)(?:\.\d+)*)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "e5cf5bab48ed249a59ec1253f1354628668e1aade5b0ba4368a60c87af3a1ba3"
    sha256 cellar: :any, big_sur:       "551711827b98e918a5a600117c04ef5e9071abb4d30bac4da19d7374d3592513"
    sha256 cellar: :any, catalina:      "8c38ea071271992d0c86b2d9dad59e5a571300ac5d2a6f7cbe54400a351d75af"
    sha256 cellar: :any, mojave:        "fe609698ac38d0b92f85b85501c9d2e749ac1c339536ace0290e3294717a33b6"
  end

  depends_on "graphviz"
  depends_on "qt@5"

  def install
    spec = (ENV.compiler == :clang) ? "macx-clang" : "macx-g++"
    spec << "-arm64" if Hardware::CPU.arm?
    cd "qcachegrind" do
      system "#{Formula["qt@5"].opt_bin}/qmake", "-spec", spec,
                                               "-config", "release"
      system "make"
      prefix.install "qcachegrind.app"
      bin.install_symlink prefix/"qcachegrind.app/Contents/MacOS/qcachegrind"
    end
  end
end
