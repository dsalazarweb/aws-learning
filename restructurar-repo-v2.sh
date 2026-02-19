#!/bin/bash
# Restructurar repo local para v2.0
# Ejecutar desde: ~/aws-learning

echo "🔄 Reestructurando repositorio a v2.0..."

# Crear nueva estructura de fases
mkdir -p labs/fase0-linux
mkdir -p labs/fase1-bash-python-git
mkdir -p labs/fase2-networking
mkdir -p labs/fase3-docker
mkdir -p labs/fase4-aws/v1-referencia
mkdir -p labs/fase5-cicd
mkdir -p labs/fase6-kubernetes
mkdir -p labs/fase7-terraform
mkdir -p labs/fase8-monitoring
mkdir -p labs/proyecto-final

# Mover labs v1.0 a carpeta de referencia dentro de fase4-aws
if [ -d "labs/dia1-primer-ec2" ]; then
  mv labs/dia1-primer-ec2 labs/fase4-aws/v1-referencia/
  echo "✅ dia1-primer-ec2 movido a fase4-aws/v1-referencia/"
fi

if [ -d "labs/dia2-s3" ]; then
  mv labs/dia2-s3 labs/fase4-aws/v1-referencia/
  echo "✅ dia2-s3 movido a fase4-aws/v1-referencia/"
fi

# Reemplazar README principal
cp ~/Descargas/README-v2-final.md README.md
echo "✅ README.md actualizado a v2.0"

echo ""
echo "📋 Nueva estructura:"
tree labs/ 2>/dev/null || find labs/ -type d | sort

echo ""
echo "🔍 git status:"
git status --short

echo ""
echo "¿Hacer commit del restructuring? (y/n)"
read confirm
if [ "$confirm" = "y" ]; then
  git add -A
  git commit -m "Roadmap v2.0: Restructure repo — foundation-first approach

- Labs reorganized into phases (fase0 through proyecto-final)
- v1.0 EC2 + S3 labs preserved in fase4-aws/v1-referencia/
- README updated with complete 8-10 month roadmap
- Reason: Build solid Linux/Networking/Docker base before AWS

New order: Linux → Bash → Networking → Docker → AWS → CI/CD → K8s → Terraform"

  git push origin main
  echo "✅ ¡Repositorio v2.0 publicado!"
fi
