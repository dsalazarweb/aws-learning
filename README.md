# ☁️ AWS Cloud Administrator Journey: Zero to Production

> **Estado:** 🟢 En Progreso | **Inicio:** Feb 2026 | **Meta:** Ago 2026
> **Enfoque:** Infraestructura como Código (IaC), Automatización y Arquitectura Resiliente.

Este repositorio documenta mi camino desde los fundamentos de AWS hasta el despliegue de arquitecturas de producción complejas, utilizando estándares de la industria como Terraform, Docker y CI/CD.

## 📂 Estructura del Proyecto

El repositorio está organizado para simular un entorno de trabajo real:

- 📂 **`labs/`**: Prácticas diarias y laboratorios aislados (e.g., EC2, S3, VPC).
- 📂 **`terraform/`**: Infraestructura como Código (Módulos y despliegues).
- 📂 **`docker/`**: Contenedorización (Dockerfiles, Docker Compose).
- 📂 **`scripts/`**: Automatización con Bash y Python (Boto3).
- 📂 **`docs/`**: Diagramas de arquitectura y notas técnicas.
- 📂 **`practice/`**: Retos y simulación de exámenes de certificación.

---

## 📅 Roadmap 2026 (Febrero - Agosto)

### Phase 1: Compute & Networking Fundamentals (Feb - Mar)
- [x] **EC2 & Linux Basics:** Instancias, SSH, Security Groups, AMI.
- [ ] **Networking Core:** VPC, Subnets, Route Tables, Internet Gateways.
- [ ] **Storage:** S3 (Standard, Glacier), EBS, EFS.
- [ ] **IAM & Security:** Roles, Políticas, MFA, AWS CLI setup.

### Phase 2: High Availability & Database (Abr - May)
- [ ] **Database:** RDS (MySQL/PostgreSQL), DynamoDB.
- [ ] **Scaling:** ELB (Load Balancers), Auto Scaling Groups.
- [ ] **Monitoring:** CloudWatch, SNS, Alarms.

### Phase 3: Infrastructure as Code & Containers (Jun - Jul)
- [ ] **Terraform:** State management, Modules, Providers.
- [ ] **Containers:** Docker, ECR (Elastic Container Registry).
- [ ] **Orchestration:** Intro a ECS/EKS.

### Phase 4: DevOps & Production (Jul - Ago)
- [ ] **CI/CD:** AWS CodePipeline / GitHub Actions.
- [ ] **Serverless:** Lambda, API Gateway.
- [ ] **Proyecto Final:** Arquitectura completa 3-Tier automatizada.

---

## 🚀 Registro de Progreso

### Semana 1: Fundamentos de Cómputo
| Día | Actividad | Estado | Tech Stack |
| :--- | :--- | :---: | :--- |
| **01** | [Primer Servidor Web EC2 + Apache](./labs/dia1-primer-ec2/) | ✅ | Bash, EC2, SG |
| **02** | [Static Website Hosting con S3](./labs/dia2-s3/) | ✅ | S3, AWS CLI, Bash |
| **03** | *VPC: Red Virtual desde Cero* | ⏳ | VPC, Subnets, IGW |

---

## 🛠️ Tech Stack & Herramientas

- **Local Workstation:** Linux Mint 22.3 "Wilma"
- **Cloud Provider:** Amazon Web Services (AWS)
- **Cloud OS:** Ubuntu 24.04 LTS / Amazon Linux 2023
- **Infrastructure as Code (IaC):** Terraform (Phase 3)
- **Scripting:** Bash, Python (Boto3)
- **Version Control:** Git & GitHub (Identity: Protected via noreply email)

---
*Este proyecto es mantenido por [Diego Salazar]. La documentación detallada de cada laboratorio se encuentra dentro de su carpeta correspondiente en `labs/`.*
