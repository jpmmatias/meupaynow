<br />
<p align="center">

  <h3 align="center">Paynow - Treinadev</h3>

  <p align="center">
   Projeto Final Etapa 1 - Turma 6 - Treinadev
    <br />
    <br />
  </p>
</p>

<details open="open">
  <summary>Tabela de conteúdo</summary>
  <ol>
    <li>
      <a href="#about-the-project"> O Projeto</a>
      <ul>
        <li><a href="#built-with">Feito com..</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Começando</a>
    </li>
    <li><a href="#api">API</a></li>
    <li><a href="#acknowledgements">Agradecimentos</a></li>
  </ol>
</details>
<div id='about-the-project'></div>

## Sobre o Projeto

![Product Name Screen Shot](app/assets/images/paynow.png)

PayNow foi realizado durante a primeira etapa do Treinadev, um programa que tem como foco formar devs com boas práticas, vivência em time de desenvolvimento e que saibam avaliar problemas e entregar valor.

Tudo isso só é possível por meio de um treinamento patrocinado por empresas em conjunto com a Campus Code.

A aplicação web consiste em um serviço B2B de pagamentos, de configuração meios de pagamentos e de registro cobranças

<div id='built-with'></div>

### Feito com:

- [Ruby 3.1 ](https://www.ruby-lang.org/pt//)
- [Ruby on Rails](https://rubyonrails.org/)
- [Devise](https://github.com/heartcombo/devise)
- [FriendlyId](https://github.com/norman/friendly_id)
- [PaperTrail](https://github.com/paper-trail-gem/paper_trail)
- [Rspec](https://rspec.info/)
- [Capybara](https://github.com/teamcapybara/capybara)
- [Bootstrap 5](https://getbootstrap.com/)

<div id='getting-started'></div>

## Como Começar

### Instalar

#### Clone o repositório

```shell
git clone git@github.com:jpmmatias/meupaynow.git
cd meupaynow
```

#### Verifique sua versão Ruby

```shell
ruby -v
```

A saída deve começar com algo como `ruby 3.0.1`

#### Instale depedências

Usando [Bundler](https://github.com/bundler/bundler) e [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Serve

```shell
rails s
```

<div id='api'></div>

## API

O Api da PayNow é descrito abaixo.

## Pegar uma lista de cobranças

### Request

`GET /api/v1/billings"`

## Criar Cobrança

### Request

`POST /api/v1/products/:product_token/billings/`

## Pesquisar Cobranças

### Request

`POST /api/v1/billings/search`

## Filtrar cobranças pela data de vencimento

### Request

`/api/v1/billings/search?due_date=QUERY`

## Pegar todos os 'customers'

### Request

`GET /api/v1/:company_token/customer`

## Pegar customer especificio

### Request

`GET /api/v1/:company_token/customers/:token`

## Criar Novo 'Customer'

### Request

`POST /api/v1/:company_token/customers/`

<div id='acknowledgements'></div>

## Agradecimentos

Só tenho a agradecer a Campus Code e a todos intrutores por todo o apoio, conhecimento e oportunidade para concluir este projeto, e aos patrocinadores Rebase, Vindi, PORTAL SOLAR , Konduto e Smart Fit por tornarem isso possível.
