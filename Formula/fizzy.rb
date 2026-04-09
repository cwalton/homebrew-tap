class Fizzy < Formula
  desc "Fizzy CLI and Agent Skills"
  homepage "https://github.com/basecamp/fizzy-cli"

  head "https://github.com/basecamp/fizzy-cli.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build",
      *std_go_args(ldflags: "-s -w -X main.version=HEAD"),
      "./cmd/fizzy"
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
