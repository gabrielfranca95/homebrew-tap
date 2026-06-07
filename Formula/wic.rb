class Wic < Formula
  desc "Assistente de terminal local: linguagem natural -> comando de shell"
  homepage "https://github.com/gabrielfranca95/wic"
  url "https://github.com/gabrielfranca95/wic/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0dc9a9736d2bde7c351944485280edab2aa2a24b5a15ac3d210e010b52b34d4c"
  license "MIT"

  depends_on "ollama"
  depends_on "python@3.12"

  def install
    libexec.install "wic"
    (libexec/"bin").install "bin/wic"
    chmod 0755, libexec/"bin/wic"
    bin.install_symlink libexec/"bin/wic"
    pkgshare.install "wic.sh"
  end

  def caveats
    <<~EOS
      O wic já funciona direto:  wic listar portas em uso

      (Opcional) Para que comandos como `cd`/`export` "peguem" no shell atual,
      adicione ao seu ~/.bashrc ou ~/.zshrc:

        source #{opt_pkgshare}/wic.sh

      No primeiro uso, o wic baixa o modelo local (~1 GB, uma vez só).
      Requer o serviço do Ollama no ar:
        Linux:  systemctl status ollama
        macOS:  abra o app do Ollama (ou: ollama serve)
    EOS
  end

  test do
    assert_match "wic 0.2", shell_output("#{bin}/wic --version")
    assert_path_exists pkgshare/"wic.sh"
  end
end
