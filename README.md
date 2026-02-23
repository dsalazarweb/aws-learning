# ☁️ DevOps & Cloud Administrator Journey: Zero to Production

> **Versión:** 2.0 | **Inicio:** Feb 2026 | **Meta:** 8-10 meses a trabajo real
> **Filosofía:** Base sólida primero → Integración → Portafolio demostrable

Este repositorio documenta un aprendizaje completo de DevOps y Cloud desde cero absoluto — Linux, redes, Bash, Python, Docker, AWS, Kubernetes, Terraform — con proyectos reales en cada etapa.

**Construido para quien empieza sin experiencia previa en terminal o cloud.**

---

## 📂 Estructura del Repositorio

```
aws-learning/
├── labs/                    # Prácticas por fase
│   ├── fase0-linux/
│   ├── fase1-bash-python-git/
│   ├── fase2-networking/
│   ├── fase3-docker/
│   ├── fase4-aws/
│   │   └── v1-referencia/   # Labs iniciales (EC2, S3)
│   ├── fase5-cicd/
│   ├── fase6-kubernetes/
│   ├── fase7-terraform/
│   ├── fase8-monitoring/
│   └── proyecto-final/
├── scripts/                 # Scripts de automatización propios
├── docs/                    # Diagramas y notas técnicas
├── docker/                  # Dockerfiles y Compose files
├── terraform/               # Infraestructura como Código
└── practice/                # Ejercicios y simulacros
```

---

## 🗺️ Roadmap Completo

### 🟢 FASE 0 — Linux + Terminal (Semanas 1-3)
| Día | Tema | Estado |
|-----|------|--------|
| 01 | [Sistema de archivos y navegación básica](./labs/fase0-linux/dia01/) | ⏳ |
| 02 | [Archivos: crear, mover, copiar, eliminar](./labs/fase0-linux/dia02/README.md) | ⏳ |
| 03 | Usuarios, grupos y permisos (`chmod`, `chown`) | ⏳ |
| 04 | Procesos y servicios (`ps`, `top`, `systemctl`) | ⏳ |
| 05 | Editor de texto `nano` y `vim` básico | ⏳ |
| 06 | SSH: llaves, conexión y configuración | ⏳ |
| 07 | Logs del sistema y diagnóstico | ⏳ |
| 08 | Gestión de paquetes (`apt`) | ⏳ |
| 09 | Red desde terminal (`ip`, `ping`, `curl`, `ss`) | ⏳ |
| 10 | **Proyecto Fase 0:** Servidor Ubuntu administrado 100% por terminal | ⏳ |

### 🔵 FASE 1 — Bash + Python esencial + Git Avanzado (Semanas 4-6)
| Día | Tema | Estado |
|-----|------|--------|
| 11 | Bash: variables, condicionales y bucles | ⏳ |
| 12 | Bash: funciones, argumentos y redirecciones (`\|`, `>`, `grep`) | ⏳ |
| 13 | Bash: script de automatización real (backup, monitoreo) | ⏳ |
| 14 | Python: sintaxis básica, variables, tipos de datos | ⏳ |
| 15 | Python: funciones, listas, diccionarios, archivos | ⏳ |
| 16 | Python: script práctico de automatización | ⏳ |
| 17 | Git: branching, merge, rebase y conflictos | ⏳ |
| 18 | **Proyecto Fase 1:** Scripts Bash + Python automatizando tareas reales | ⏳ |

### 🟣 FASE 2 — Networking (Semanas 7-8)
| Día | Tema | Estado |
|-----|------|--------|
| 19 | Modelo OSI: capas que importan en la práctica | ⏳ |
| 20 | IP, subnets y notación CIDR | ⏳ |
| 21 | DNS: cómo funciona (`dig`, `nslookup`) | ⏳ |
| 22 | TCP/UDP, puertos y firewalls (`ufw`) | ⏳ |
| 23 | HTTP/HTTPS: request, response y status codes | ⏳ |
| 24 | **Proyecto Fase 2:** Diseño de red que construiremos en AWS VPC | ⏳ |

### 🐳 FASE 3 — Docker (Semanas 9-11)
| Día | Tema | Estado |
|-----|------|--------|
| 25 | Contenedores vs VMs — qué resuelve Docker | ⏳ |
| 26 | Dockerfile: construir imágenes propias | ⏳ |
| 27 | Comandos esenciales: `run`, `ps`, `logs`, `exec` | ⏳ |
| 28 | Docker Compose: múltiples servicios | ⏳ |
| 29 | Docker Hub: publicar y versionar imágenes | ⏳ |
| 30 | **Proyecto Fase 3:** App web (Nginx + backend + DB) en contenedores | ⏳ |

### ☁️ FASE 4 — AWS con Base Sólida (Semanas 12-15)
| Día | Tema | Estado |
|-----|------|--------|
| — | [EC2: Primer servidor *(v1.0 referencia)*](./labs/fase4-aws/v1-referencia/dia1-primer-ec2/) | ✅ |
| — | [S3: Static Website Hosting *(v1.0 referencia)*](./labs/fase4-aws/v1-referencia/dia2-s3/) | ✅ |
| 31 | VPC: Red virtual desde cero | ⏳ |
| 32 | EC2 revisitado — entendiendo el OS debajo | ⏳ |
| 33 | IAM: usuarios, roles y políticas | ⏳ |
| 34 | S3 avanzado + Boto3 (Python automatizando AWS) | ⏳ |
| 35 | RDS: base de datos gestionada | ⏳ |
| 36 | ECS + ECR: desplegar Docker en AWS | ⏳ |
| 37 | Load Balancer + Auto Scaling | ⏳ |
| 38 | **Proyecto Fase 4:** App containerizada en AWS con red propia | ⏳ |

### ⚙️ FASE 5 — CI/CD (Semanas 16-17)
| Día | Tema | Estado |
|-----|------|--------|
| 39 | GitHub Actions: workflows y triggers | ⏳ |
| 40 | Pipeline: commit → build → test → deploy | ⏳ |
| 41 | Secrets y variables seguras | ⏳ |
| 42 | **Proyecto Fase 5:** Push a GitHub → deploy automático en AWS | ⏳ |

### ☸️ FASE 6 — Kubernetes (Semanas 18-20)
| Día | Tema | Estado |
|-----|------|--------|
| 43 | Por qué Kubernetes: el problema que resuelve | ⏳ |
| 44 | Pods, Deployments y Services | ⏳ |
| 45 | `kubectl` comandos esenciales | ⏳ |
| 46 | AWS EKS: Kubernetes gestionado | ⏳ |
| 47 | **Proyecto Fase 6:** App del Fase 3 migrada a Kubernetes | ⏳ |

### 🏗️ FASE 7 — Terraform (Semanas 21-23)
| Día | Tema | Estado |
|-----|------|--------|
| 48 | HCL: lenguaje y estructura básica | ⏳ |
| 49 | State management y providers | ⏳ |
| 50 | Módulos reutilizables | ⏳ |
| 51 | **Proyecto Fase 7:** Toda la infra de Fase 4 como código | ⏳ |

### 📊 FASE 8 — Monitoring (Semanas 24-25)
| Día | Tema | Estado |
|-----|------|--------|
| 52 | CloudWatch: métricas, logs y alarmas | ⏳ |
| 53 | Prometheus + Grafana | ⏳ |
| 54 | **Proyecto Fase 8:** Dashboard de producción de toda la infra | ⏳ |

### 🏆 PROYECTO FINAL — Portafolio (Semanas 26-28)
Arquitectura 3-tier completa: Frontend (S3+CloudFront) → Backend (ECS) → DB (RDS), con VPC propia, CI/CD automatizado, Terraform, Monitoring y scripts Python/Bash. Todo documentado y explicable en una entrevista.

---

## 💰 Costos Reales

| Período | Actividad | Costo Real |
|---------|-----------|------------|
| Feb 16-18, 2026 | EC2 (~21h) + S3 — v1.0 | $0.07 USD |
| Fases 0-3 | Linux, Bash, Python, Docker | $0.00 (todo local) |
| Fase 4+ | AWS con free tier | <$10/mes |

---

## 🛠️ Tech Stack Completo

**Fundamentos:** Linux · Bash · Python · Git
**Contenedores:** Docker · Kubernetes (EKS)
**Cloud:** AWS (EC2, S3, VPC, IAM, RDS, ECS, EKS)
**IaC:** Terraform
**CI/CD:** GitHub Actions
**Monitoring:** CloudWatch · Prometheus · Grafana

---

## 🤖 Sobre el uso de IA en este proyecto

La inteligencia artificial es una herramienta de apoyo en este aprendizaje, no un sustituto del mismo. Se usa para mejorar la estructura y redacción de la documentación, revisar errores de sintaxis cuando no es posible identificarlos manualmente, y entender el *por qué* detrás de cada solución — lo que luego se documenta para poder replicarlo sin asistencia.

También se consulta para obtener referencias de estudio y como revisor de notas tomadas después de leer o ver contenido técnico.

El reto real es usar la IA sin caer en copiar y pegar sin entender. Un profesional que sabe trabajar tanto de forma manual como asistida por herramientas resuelve más problemas y se adapta a cualquier entorno. Ese es el objetivo.

---

## 📌 Metodología

Cada día completado incluye: comandos ejecutados, conceptos aprendidos, screenshots que validan el trabajo, costos reales (en fases AWS) y notas sobre errores encontrados. Todo versionado en Git con commits descriptivos.

---

*Este proyecto es mantenido por [Diego Salazar](https://github.com/dsalazarweb). La documentación detallada de cada laboratorio se encuentra en su carpeta correspondiente dentro de `labs/`. Construido en público — cada commit cuenta la historia completa del aprendizaje.*
