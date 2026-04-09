class Fizzy < Formula
  desc "Fizzy CLI and Agent Skills"
  homepage "https://github.com/basecamp/fizzy-cli"
  version "3.0.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/basecamp/fizzy-cli/releases/download/v#{version}/fizzy-v#{version}-macos-amd64.tar.gz"
      sha256 "1f7a4087b328709f1311684c194e82488a033f276632c0202970a29486c9179d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/basecamp/fizzy-cli/releases/download/v#{version}/fizzy-v#{version}-macos-arm64.tar.gz"
      sha256 "035c9a7978280f2747309995874288094776100877073747188734994263721a"
    end
  end

  def install
    bin.install "fizzy"
    
    # Install shell completions
    bash_completion.install "completions/fizzy.bash" => "fizzy"
    zsh_completion.install "completions/fizzy.zsh" => "_fizzy"
    fish_completion.install "completions/fizzy.fish"
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
