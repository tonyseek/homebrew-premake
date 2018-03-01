class Premake5 < Formula
  desc "Write once, build anywhere Lua-based build system"
  homepage "https://premake.github.io/"
  url "https://github.com/premake/premake-core/releases/download/v5.0.0-alpha12/premake-5.0.0-alpha12-src.zip"
  sha256 "5fa4a9f5b100024e23e2b9117ffa4935a6ac3c0a61aa027c3211388d53536751"
  version_scheme 1
  head "https://github.com/premake/premake-core.git"

  def install
    if build.head?
      system "make", "-f", "Bootstrap.mak", "osx"
      system "./premake5", "gmake"
    end

    system "make", "-C", "build/gmake.macosx"
    bin.install "bin/release/premake5"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/premake5 --version")
  end
end
