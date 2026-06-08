# Fórmula do Homebrew para o wic.
#
# Esta é a CÓPIA DE REFERÊNCIA. A fórmula que vale fica no repo do tap:
#   github.com/gabrielfranca95/homebrew-tap  ->  Formula/wic.rb
# O usuário instala com:
#   brew install gabrielfranca95/tap/wic
#
# A cada release nova, atualize `url` (a tag) e `sha256` aqui e no tap.
class Wic < Formula
  desc "Assistente de terminal local: linguagem natural -> comando de shell"
  homepage "https://github.com/gabrielfranca95/wic"
  url "https://github.com/gabrielfranca95/wic/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0dc9a9736d2bde7c351944485280edab2aa2a24b5a15ac3d210e010b52b34d4c"
  license "MIT"

  # Dependências: o brew garante que existam antes de instalar o wic.
  depends_on "ollama"
  depends_on "python@3.12"

  def install
    libexec.install "wic"                      # pacote Python -> libexec/wic
    (libexec/"bin").install "bin/wic"          # launcher      -> libexec/bin/wic
    chmod 0755, libexec/"bin/wic"              # bit de execução (senão: Permission denied)
    bin.install_symlink libexec/"bin/wic"      # expõe `wic` no PATH (realpath acha o pacote)
    pkgshare.install "wic.sh"                  # wrapper opcional -> share/wic/wic.sh
  end

  def caveats
    <<~EOS
      O wic já funciona direto:  wic listar portas em uso

      (Opcional) Para que comandos como `cd`/`export` "peguem" no shell atual,
      adicione ao seu ~/.bashrc ou ~/.zshrc:

        source #{opt_pkgshare}/wic.sh

      No primeiro uso, o wic baixa o modelo local (~1 GB, uma vez só) e sobe o
      Ollama sozinho — você não precisa iniciar nenhum serviço manualmente.
    EOS
  end

  test do
    assert_match "wic 0.2", shell_output("#{bin}/wic --version")
    assert_path_exists pkgshare/"wic.sh"
  end
end
