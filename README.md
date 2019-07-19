# Unit Test Creator Tool - UTCTOOL

Ferramenta para fazer a captura de ações do usuario em tempo real em qualquer rotina MVC.

A Unit Test Creator Tool foi desenvolvida para facilitar a criação de casos de testes apenas utilizando a rotina alvo pelo SmartClient o caso de teste é gerado automaticamente de acordo com as ações efetuadas!

### Novas Functionalidades
+ Execução do UTCTOOL apenas com parâmetro no .INI do server
+ Geração automática do Script para executar as ações automaticamente
+ Utilização do parametro utcfiles=123456 para gerar os arquivos de forma transparente
+ Geração dos arquivos na pasta UTCTOOL no Protheus Data

### Em desenvolvimento
+ Perceutal de cobertuda do fonte ao finalizar a criação do teste (Coverage)

### Tipos de teste
+ Inclusão de registro
+ Alteração de registro
+ Exclusão de registro
+ Testes negativos (validação de campo, modelo e submodelo)

### Utilização
1 - Aplicar tttp120_V4_00_x64.prw https://github.com/andrewsegas/UTCTOOL/releases

  ou
  
1 - Compilar os arquivos UTCTOOL.prw e UTCCLASS.prw, em caso de falta de chave de compilação basta mudar a função UTCTOOL para User Function

2 - Incluir os seguintes parametros no appserver.INI
## Parâmetros
| Parametro            |                Description                           |        valor                     | Default|
|:--------------------:|:----------------------------------------------------:|:--------------------------------:|:------:|
| UTCTOOL              | Utiliza ou não UTCTOOL                               | 1 = sim , 0 = não                | 0 |
| UTCFILES             | arquivos que serão gerados                           | 1 = TestCase PRW , 2 - TestGroup/Suite , 3 = Descritivo Kanoah , 4 = TestCase TIR python ,  5 = Template CSV , 6 = Rotina Automatica                | 1,3 |

ps: o parâmetro utcfiles pode ser utilizado com diversos numeros

Na configuração do ambiente deve ser colocado da seguinte forma
ex:

![Rotina!](/docs/im1.png "Rotina")


#### Iniciar o teste

![Teste!](/docs/im2.png "Teste")

![Continuação!](/docs/im3.png "Teste")

#### Teste negativo

![Negativo!](/docs/im4.png "Negativo")


#### Verificar a geração dos arquivos na pasta UTCTOOL
TestCase (PRW), Kanoah (Texto) e TIR (python)

![Template!](/docs/im6.png "Geração")
![python!](/docs/im7.png "Geração")
![Kanoah!](/docs/im8.png "Geração")

Video de exemplo: 
https://www.youtube.com/watch?v=maLGjmY--js&feature=youtu.be

Video Coffe & Code UTCTOOL: 
https://drive.google.com/open?id=11uhiKFwW-fio2XUYivpy-0qaifMpEVPE

### Funcionalidades possiveis (colaboradores?)
+ Inclusão automática do Kanoah
+ Verificação de tempo/performance das rotinas sem a necessidade de alterar as rotinas padrões
+ Inclusão de parametro automatico (MV_)
+ Inclusão de parametro automatico F12
+ mais

### Conhecimentos para manutenção
FwModelEvent (http://tdn.totvs.com/pages/viewpage.action?pageId=269552294)

em caso da geração CSV (Russia)
Casos de teste por template (http://tdn.totvs.com/pages/viewpage.action?pageId=273302121)
