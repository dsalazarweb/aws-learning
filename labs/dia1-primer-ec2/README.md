# Día 1 - Mi Primer Servidor EC2

## 📅 Fecha
Lunes, 16-17 de Febrero de 2026

## 🎯 Objetivo
Lanzar mi primer servidor EC2 en AWS, configurar un servidor web Apache, y acceder desde internet.

## ⏱️ Tiempo Real Invertido
- Estimado inicial: 1.5h
- **Tiempo real (incluyendo práctica extendida):** ~21 horas
- Motivo: Día de reposo médico aprovechado para práctica intensiva en profundidad

## 📦 Recursos Creados

### 1. Key Pair
- **Nombre:** `dia1-key` | **Archivo:** `dia1-key.pem` | **Permisos:** `chmod 400`

### 2. Security Group
- **ID:** `sg-0eb42302e756fba7b` | **Nombre:** `dia1-sg`
- Reglas: SSH (22) y HTTP (80) desde `0.0.0.0/0`

### 3. EC2 Instance
- **ID:** `i-0b5c12216c5d7df54`
- **Tipo:** `t2.micro` (1 vCPU, 1GB RAM)
- **AMI:** `ami-0136735c2bb5cf5bf` (Ubuntu 24.04 LTS)
- **IP Pública:** `34.226.192.146`
- **Zona:** `us-east-1b`
- **Estado final:** TERMINATED ✅

## 🛠️ Stack Tecnológico
- **Cloud:** AWS EC2 | **OS:** Ubuntu 24.04 LTS | **Web:** Apache 2.4 | **Tools:** AWS CLI, SSH, Bash

## 🔧 Comandos Ejecutados

```bash
# Key Pair
aws ec2 create-key-pair \
  --key-name dia1-key \
  --query 'KeyMaterial' \
  --output text > dia1-key.pem
chmod 400 dia1-key.pem

# Security Group
aws ec2 create-security-group \
  --group-name dia1-sg \
  --description "Security group para mi primer EC2"

aws ec2 authorize-security-group-ingress \
  --group-id sg-0eb42302e756fba7b \
  --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
  --group-id sg-0eb42302e756fba7b \
  --protocol tcp --port 80 --cidr 0.0.0.0/0

# Obtener AMI Ubuntu más reciente
AMI_ID=$(aws ec2 describe-images \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" \
  --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
  --output text)

# Lanzar instancia
aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type t2.micro \
  --key-name dia1-key \
  --security-group-ids sg-0eb42302e756fba7b \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MiPrimerServidor}]'

# SSH
ssh -i dia1-key.pem ubuntu@34.226.192.146

# Apache (dentro del SSH)
sudo apt update && sudo apt install -y apache2

# Terminar
aws ec2 terminate-instances --instance-ids i-0b5c12216c5d7df54
```

## 🎓 Conceptos Aprendidos

1. **Key Pairs** — SSH auth. AWS guarda la pública, tú la privada. Sin .pem = sin acceso.
2. **Security Groups** — Firewalls virtuales. Stateful. Todo bloqueado por defecto.
3. **AMI** — Imagen del OS. El ID varía por región.
4. **Instance Types** — t2.micro: 1vCPU, 1GB RAM. Burstable, free tier eligible.
5. **Estados** — `pending → running → stopping → stopped → terminated`
6. **IP Pública** — Dinámica: cambia en cada stop/start. Elastic IP = estática (costo).
7. **Stop vs Terminate** — Stop conserva datos pero cobra storage. Terminate = destrucción total.

## 📸 Screenshots

### Página web funcionando
![Navegador](./mi-primer-servidor-aws.png)

### Terminal SSH conectado
![Terminal](./consola-ssh.png)

## 💰 Análisis de Costos (Real)

| Recurso | Detalles | Costo Real |
|---------|----------|------------|
| Compute t2.micro | ~21h de práctica extendida | ~$0.06 |
| Storage EBS 8GB | Días activo | ~$0.01 |
| Data Transfer | <1MB | $0.00 |
| **Total Día 1** | | **$0.07 USD** |

> ⚠️ **Lección aprendida:** El costo estimado fue $0.03 pero el real fue $0.07 por dejar recursos corriendo durante la práctica extendida. Siempre TERMINATE cuando termines.

## 🚧 Problemas Encontrados

**1. Encoding UTF-8** — Faltaba `<meta charset="UTF-8">`. Fix: agregarlo en `<head>`.

**2. Bash heredoc syntax** — `echo` con `<` causaba errores. Fix: usar `cat << 'EOF'`.

**3. Seguridad** — Casi se commitea el `.pem`. Fix: `.gitignore` con `*.pem` antes del primer commit.

## ✅ Checklist
- [x] Key pair creado
- [x] Security group configurado (SSH + HTTP)
- [x] Instancia EC2 lanzada
- [x] Conexión SSH exitosa
- [x] Apache instalado y página personalizada
- [x] Acceso desde navegador verificado
- [x] Screenshots tomados
- [x] Instancia TERMINADA
- [x] Documentación completa
- [x] Costos analizados

## 💡 Lección más importante
> "Detener (stop) NO es suficiente para $0 costo. Siempre TERMINATE cuando termines de practicar."

## 📚 Referencias
- [AWS CLI EC2](https://docs.aws.amazon.com/cli/latest/reference/ec2/)
- [Ubuntu Cloud Images](https://cloud-images.ubuntu.com/)
- [Apache Docs](https://httpd.apache.org/docs/2.4/)

---
**Estado:** ✅ Completado | **Tiempo real:** ~21h | **Costo real:** $0.07 USD | **Siguiente:** S3
