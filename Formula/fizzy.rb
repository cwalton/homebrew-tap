class Fizzy < Formula
  desc "Fizzy CLI and Agent Skills"
  homepage "https://github.com/basecamp/fizzy-cli"
  version "3.0.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/basecamp/fizzy-cli/releases/download/v#{version}/fizzy-darwin-amd64"
      sha256 "9a34bb62cffbccf2a1ac681f76c63a3815773a2172dbf53022d50f44de8286db"
    end
    if Hardware::CPU.arm?
      url "https://github.com/basecamp/fizzy-cli/releases/download/v#{version}/fizzy-darwin-arm64"
      sha256 "207b588854d1b610e466f62f9a67e7293a971f983cb4c34e3fd42f90e894e2de"
    end
  end

  def install
    bin.install "fizzy-darwin-#{Hardware::CPU.intel? ? "amd64" : "arm64"}" => "fizzy"
  end

  def caveats
    <<~EOS
      To get started with Fizzy, run:
        fizzy setup
    EOS
  end

  test do
    system "#{bin}/fizzy", "version"
  end
end
