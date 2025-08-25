# Payment Microservices

## Visão Geral

Este é um projeto de **portfólio** com foco em demonstrar habilidades em **Java, Go, AWS, microsserviços, CAP theorem e boas práticas de engenharia de software**.  
O sistema simula um **banco digital simplificado**, com autenticação, pagamentos e extratos.

---

## 📌 Objetivos do Projeto
- Construir uma arquitetura **distribuída** usando microsserviços.
- Demonstrar **consistência vs disponibilidade** (CAP theorem) utilizando Postgres e DynamoDB.
- Implementar **segurança realista** com autenticação baseada em JWT, refresh tokens e rate limiting.
- Usar **infraestrutura na AWS** provisionada via **Terraform**.
- Praticar **observabilidade, testes automatizados e CI/CD**.

## 🏗️ Arquitetura

```mermaid
flowchart LR
    subgraph API Gateway
    end

    API Gateway --> Auth[Auth Service (Java + RDS + Redis)]
    API Gateway --> Payments[Payments Service (Go + Lambda + DynamoDB + S3)]
    API Gateway --> Statement[Statement Service (Java + RDS + Redis)]

    Payments -- evento --> SQS[(SQS)]
    SQS --> Statement
```

### **Auth Service (Java + Spring Boot + Postgres + Redis)**
  - Registro e login de usuários.
  - Rate limiting no login (Redis).
  - Geração e validação de JWT.
  - Refresh tokens.
  - Cache de perfil do usuário.

### Payments Service (Java + Spring Boot + DynamoDB + S3)

- Processamento de pagamentos (débitos e créditos).
- Persistência idempotente em DynamoDB.
- Geração de comprovantes em S3.
- Publicação de eventos no SQS. 

### Statement Service (Go + Lambda + Postgres + Redis)
- Consome eventos de pagamento do SQS.
- Atualiza saldo e histórico do usuário.
- Exposição de API para consulta de extratos.
- Cache para consultas de saldo.

## ⚙️ Tecnologias & Ferramentas

- **Linguagens**
    - **Java 21 + Spring Boot 3**
    - **Go (AWS Lambda)**

- **Bancos de Dados**
    - **Postgres (RDS)** – dados relacionais, consistência forte.
    - **DynamoDB** – pagamentos, idempotência, alta disponibilidade.
    - **Redis (ElastiCache)** – cache + rate limiting.

- **Infra & Cloud**
    - **AWS**: RDS, DynamoDB, Lambda, S3, SQS, CloudWatch, API Gateway, IAM.
    - **Terraform** – provisionamento da infraestrutura.
    - **Docker** – build e testes locais.
    - **GitHub Actions** – CI/CD.  
