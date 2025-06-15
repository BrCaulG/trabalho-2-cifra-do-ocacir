programa {
  inclua biblioteca Texto 
  funcao inicio() {
    cadeia mensagemOriginal 
    inteiro chaveDeslocamento 
    cadeia operacaoEscolhida 
    cadeia mensagemResultante = "" 
    
    
    cadeia alfabetoMaiusculo = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    cadeia alfabetoMinusculo = "abcdefghijklmnopqrstuvwxyz"
    
    
    escreva("Digite a mensagem: ")
    leia(mensagemOriginal)

    escreva("Digite a chave de deslocamento (valor inteiro): ")
    leia(chaveDeslocamento)
    
    
    chaveDeslocamento = chaveDeslocamento % 26 
    
    
    se (chaveDeslocamento < 0) {
      chaveDeslocamento = chaveDeslocamento + 26
    }

    escreva("Escolha a operação (criptografar/descriptografar): ")
    leia(operacaoEscolhida)

    
    operacaoEscolhida = Texto.caixa_baixa(operacaoEscolhida) 

    
    para (inteiro i = 0; i < Texto.numero_caracteres(mensagemOriginal); i++) {
      caracter charAtual = Texto.obter_caracter(mensagemOriginal, i)
      inteiro indiceNoAlfabeto = -1 

  
      para (inteiro j = 0; j < Texto.numero_caracteres(alfabetoMaiusculo); j++) {
        se (charAtual == Texto.obter_caracter(alfabetoMaiusculo, j)) {
          indiceNoAlfabeto = j
          pare 
        }
      }

     
      se (indiceNoAlfabeto != -1) {
        inteiro novoIndice = 0
        se (operacaoEscolhida == "criptografar") {
          novoIndice = (indiceNoAlfabeto + chaveDeslocamento) % 26
        } senao se (operacaoEscolhida == "descriptografar") {
         
          novoIndice = (indiceNoAlfabeto - chaveDeslocamento) % 26
         
          se (novoIndice < 0) {
              novoIndice = novoIndice + 26
          }
        }
        mensagemResultante = mensagemResultante + Texto.obter_caracter(alfabetoMaiusculo, novoIndice)
      }
     
      senao { 
        indiceNoAlfabeto = -1
        para (inteiro j = 0; j < Texto.numero_caracteres(alfabetoMinusculo); j++) {
          se (charAtual == Texto.obter_caracter(alfabetoMinusculo, j)) {
            indiceNoAlfabeto = j
            pare 
          }
        }

       
        se (indiceNoAlfabeto != -1) {
          inteiro novoIndice = 0
          se (operacaoEscolhida == "criptografar") {
            novoIndice = (indiceNoAlfabeto + chaveDeslocamento) % 26
          } senao se (operacaoEscolhida == "descriptografar") {
           
            novoIndice = (indiceNoAlfabeto - chaveDeslocamento) % 26
           
            se (novoIndice < 0) {
                novoIndice = novoIndice + 26
            }
          }
          mensagemResultante = mensagemResultante + Texto.obter_caracter(alfabetoMinusculo, novoIndice)
        }
        
        senao {
          mensagemResultante = mensagemResultante + charAtual 
        }
      }
    } 

    se (operacaoEscolhida == "criptografar") {
      escreva("Mensagem criptografada: ", mensagemResultante, "\n")
    } senao se (operacaoEscolhida == "descriptografar") {
      escreva("Mensagem descriptografada: ", mensagemResultante, "\n")
    } senao {
      escreva("Operação inválida. Por favor, escolha 'criptografar' ou 'descriptografar'.\n")
    }
  }
}
