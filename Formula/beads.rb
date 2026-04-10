class Beads < Formula
  desc "Memory upgrade for your coding agent (gastownhall fork with fizzy adapter)"
  homepage "https://github.com/gastownhall/beads"

  head "https://github.com/gastownhall/beads.git", branch: "main"

  depends_on "go" => :build
  depends_on "dolt"
  depends_on "icu4c@78"

  def install
    if OS.linux? && Hardware::CPU.arm64?
      ENV["CGO_ENABLED"] = "1"
      ENV["GO_EXTLINK_ENABLED"] = "1"
      ENV.append "GOFLAGS", "-buildmode=pie"
    end

    ENV["CGO_ENABLED"] = "1"

    ldflags = %W[
      -s -w
      -X main.Build=#{tap.user}
    ]
    system "go", "build", *std_go_args(ldflags:, output: bin/"bd"), "-tags", "gms_pure_go", "./cmd/bd"
  end

  def caveats
    <<~EOS
      This is the gastownhall fork of beads, patched with a fizzy adapter
      for use with the fizzy CLI. It is NOT the official steveyegge/beads.

      The binary is installed as `bd`.
    EOS
  end

  test do
    assert_match "bd", shell_output("#{bin}/bd --version")
  end
end
