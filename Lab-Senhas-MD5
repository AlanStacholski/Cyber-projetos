# Pequeno Laboratório de quebra de senhas (MD5 / John the Ripper)

> **Objetivo:** um laboratório mínimo e reproduzível para testar a força de senhas simples gerando hashes MD5 para senhas de teste e tentando quebrá-las com John the Ripper (versão Jumbo). Este repositório é *educacional* — **não** o use contra contas que você não possui ou sistemas que não está autorizado a testar.

---

## Visão geral

Este projeto demonstra um fluxo de trabalho completo para:

* gerar hashes MD5 de senhas de teste selecionadas,
* executar John the Ripper (jumbo) localmente para tentar recuperar essas senhas,
* coletar e interpretar resultados (john.pot),
* tirar conclusões de segurança e próximos passos.

Foi criado como um exercício de aprendizado pessoal e prova de conceito para melhorar a higiene de senhas.

---

## Estrutura do repositório (censurado)

```
<WORKDIR>/john_lab/
├─ john-1.9.0-jumbo-1-win64/run/   # Executáveis do John (mantidos no repo por conveniência)
├─ hashes_md5.txt                  # hash(es) MD5 gerado(s)
├─ mywordlist.txt                  # wordlist simples com candidatos
├─ john.pot                        # arquivo pot onde john armazena senhas quebradas
├─ README.md                       # este documento
└─ screenshots/                    # screenshots opcionais do terminal (censurados)
```

> NOTA: todos os caminhos absolutos/locais neste documento foram substituídos pelo placeholder `<WORKDIR>` para evitar vazar informações de pasta pessoal. Quando você executar comandos localmente, substitua `<WORKDIR>` pelo seu diretório de trabalho real.

---

## Pré-requisitos

* Windows (exemplos neste doc usam PowerShell) ou SO similar ao Unix.
* John the Ripper versão Jumbo (testado com `john-1.9.0-jumbo-1-win64`).
* Familiaridade básica com PowerShell ou shell.
* (Opcional) arquivo pequeno de wordlist para testes direcionados.

---

## Segurança e ética

Teste apenas senhas que você possui e sistemas que você está autorizado a testar. Se você usou qualquer senha real de conta durante os testes, **altere essas senhas imediatamente** e habilite 2FA quando possível. Este repo contém apenas hashes gerados localmente e uma wordlist pequena e intencionalmente fraca para demonstração.

---

## Início rápido (comandos censurados)

Substitua `<WORKDIR>` pela sua pasta local onde você mantém o repo.

### 1) Preparar arquivos

* Crie uma pequena wordlist `mywordlist.txt` com senhas candidatas (uma por linha).
* Crie `hashes_md5.txt` contendo hashes MD5 das senhas de teste.

Exemplo de snippet PowerShell (gerar MD5 de uma string de senha e salvar em `hashes_md5.txt`):

```powershell
# substitua "MyTestPassword123" pela senha que você quer fazer hash (apenas para seus próprios testes)
$pw = "MyTestPassword123"
$bytes = [System.Text.Encoding]::UTF8.GetBytes($pw)
$md5 = [System.Security.Cryptography.MD5]::Create()
$hash = [System.BitConverter]::ToString($md5.ComputeHash($bytes)).Replace('-', '').ToLower()
$hash | Out-File -FilePath "<WORKDIR>/hashes_md5.txt" -Encoding utf8
```

> O arquivo `hashes_md5.txt` deve conter um hash MD5 por linha.

### 2) Executar John the Ripper

Abra um terminal em `<WORKDIR>` e execute John com o formato raw-md5 e sua wordlist. Ajuste o nome do executável do john se o seu for diferente.

```powershell
.\john-1.9.0-jumbo-1-win64\run\john-avx.exe --format=raw-md5 --wordlist="mywordlist.txt" "hashes_md5.txt"
```

Notas:

* Use a flag `--test` (ex. `john-avx.exe --test`) para fazer benchmark da sua versão.
* Avisos sobre OpenMP ou outras dicas de performance são informativos; eles não impedem a quebra.

### 3) Inspecionar resultados

Mostrar senhas quebradas do arquivo `pot` do John usando `--show` (John normalmente encontra o arquivo pot automaticamente se executado da mesma pasta `run`). Se você quiser apontar para um arquivo pot específico, passe `--pot=<caminho>`.

```powershell
.\john-1.9.0-jumbo-1-win64\run\john-avx.exe --show "hashes_md5.txt" --pot="<WORKDIR>/john.pot"
```

Se `--show` não exibir entradas quebradas, certifique-se de que o `john.pot` usado pelo `--show` é o mesmo arquivo onde John salvou os resultados (fonte comum de confusão).

---

## Exemplos de saídas (resumo, censurado)

* John relata métricas de candidatos-por-segundo (c/s) durante execuções (mais alto em versões otimizadas como AVX).
* Após uma quebra bem-sucedida, o arquivo pot contém linhas na forma `HASH:senha`.
* Executar `--show` com o arquivo pot correto retorna a(s) senha(s) quebrada(s) e quantos hashes permanecem não quebrados.

---

## Recomendações de segurança e conclusões

* MD5 é criptograficamente quebrado para armazenamento de senhas — **não** use MD5 para hash de senhas em produção.
* Prefira algoritmos modernos de hash de senhas (ex. Argon2, bcrypt, scrypt, PBKDF2 com parâmetros adequados).
* Use frases-senha longas em vez de senhas curtas e habilite 2FA.
* Use um gerenciador de senhas (Bitwarden, KeePass, 1Password) para gerar e armazenar credenciais únicas.
* Audite regularmente e gire quaisquer senhas que possam ter sido usadas em testes.

---

## Preparando este repositório para GitHub e LinkedIn

Entradas sugeridas para `.gitignore` (adicionar na raiz do repo):

```
# evitar vazar artefatos locais
john.pot
*.log
*.bak
.DS_Store

# SO / Editor
Thumbs.db
.vscode/
```

Nome sugerido para repo GitHub: `john-lab-password-audit`
Arquivos sugeridos para adicionar antes de publicar:

* `LICENSE` (ex. MIT) — inclua uma nota curta de que o repo é apenas para uso educacional.
* `CONTRIBUTING.md` (opcional)
* screenshots higienizados em `screenshots/` (garanta que não há caminhos/identificadores privados)

### Comandos git rápidos

```bash
git init
git add .
git commit -m "Commit inicial — README john_lab e arquivos de teste (caminhos censurados)"
git branch -M main
git remote add origin <seu-remote-github>
git push -u origin main
```

---

## Notas sobre censura e privacidade

Este repositório intencionalmente censura nomes de pastas pessoais/locais e caminhos absolutos. Em qualquer lugar no código ou exemplos onde você vê `<WORKDIR>` ou placeholders similares, substitua pelo seu caminho local e privado ao executar localmente. **Não** publique arquivos não censurados (especialmente `john.pot`) em repositórios públicos.

---

## Licença e Propósito

Este projeto foi criado **exclusivamente para fins educacionais**.

* **Uso:** É permitido o uso, estudo e modificação por indivíduos e instituições para aprendizado e ensino.
* **Restrição:** O **uso comercial** (venda, integração em produtos pagos, etc.) **não é permitido**.
* **Responsabilidade:** Utilize o material responsavelmente e cite a fonte.
