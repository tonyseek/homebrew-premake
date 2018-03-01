class Premake4 < Formula
  desc "Write once, build anywhere Lua-based build system"
  homepage "https://premake.github.io/"
  version_scheme 1
  url "https://downloads.sourceforge.net/project/premake/Premake/4.4/premake-4.4-beta5-src.zip"
  sha256 "0fa1ed02c5229d931e87995123cdb11d44fcc8bd99bba8e8bb1bbc0aaa798161"

  conflicts_with "premake", :because => "both install premake4 or premake5"

  head do
    url "https://github.com/premake/premake-4.x.git"

    resource "premake4-build" do
      url "https://downloads.sourceforge.net/project/premake/Premake/4.4/premake-4.4-beta5-macosx.tar.gz"
      sha256 "4812a431761b1b37b32be33c2ab324b8c7d0fe602b4e5b91f8826cb196537d6e"
    end
  end

  def install
    if build.head?
      resource("premake4-build").stage do
        libexec.install "premake4"
      end
      system libexec/"premake4", "embed"
      system libexec/"premake4", "gmake"
      system "make", "config=release"
    else
      system "make", "-C", "build/gmake.macosx"
    end

    bin.install "bin/release/premake4"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/premake4 --version", 1)
  end
end
