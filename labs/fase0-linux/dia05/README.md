# Fase 0 · Día 5 — Editores de Texto: Nano y Vim

## 📅 Fecha

Lunes, 19 de Mayo de 2026

## 🎯 Objetivo

Aprender a editar archivos directamente desde la terminal sin interfaz gráfica. Es la habilidad más básica y crítica del trabajo en servidores remotos: todo lo que configures en AWS, Docker o Kubernetes lo harás con un editor de terminal.

## ⏱️ Tiempo invertido

~1.5 horas

## 🖥️ Entorno

* **OS:** Ubuntu 24.04 LTS (WSL2) | **Usuario:** dsalazar | **Máquina:** DESKTOP-13M4CS8

---

## 📚 Concepto clave del día

Cuando te conectas a un servidor via SSH no tienes VS Code, no tienes clic derecho, no hay GUI. Configurar Nginx, editar un Dockerfile, ajustar variables de entorno en producción — todo se hace con un editor de terminal. Dos estándares que debes dominar: **nano** para ediciones rápidas, **vim** para potencia real.

---

## 🛠️ Nano — El editor amigable

Sus atajos siempre visibles en la parte inferior. Ideal para ediciones rápidas.

```bash
nano archivo.txt           # abre si existe, crea si no existe
sudo nano /etc/nginx/nginx.conf   # patrón común en servidores
```

### Atajos esenciales
```
Ctrl + O    → guardar (pide confirmar nombre, Enter para aceptar)
Ctrl + X    → salir
Ctrl + W    → buscar texto
Ctrl + K    → cortar línea
Ctrl + U    → pegar línea
```

---

## 🛠️ Vim — El editor estándar del servidor

Vim está en prácticamente todas las distros Linux (incluyendo AMI de AWS). Es **modal** — no puedes escribir al abrirlo.

### Los tres modos
```
MODO NORMAL (default)  → navegar y comandos. Vuelves aquí con Esc
MODO INSERTAR (i)      → escribir texto normalmente
MODO COMANDO (:)       → guardar, buscar, sustituir
```

### Comandos críticos
```bash
:wq          # guardar y salir
:q!          # salir sin guardar
i / Esc      # entrar/salir de modo Insertar
dd / yy / p  # cortar / copiar / pegar línea
u            # deshacer
/patron      # buscar (n = siguiente)
:%s/old/new/g  # sustituir en todo el archivo
```

---

## 🚀 Laboratorios ejecutados

### Lab 1 — Nano: crear config de servidor
```bash
mkdir -p ~/labs/dia05 && cd ~/labs/dia05
nano servidor-web.conf
# escribir bloque nginx básico → Ctrl+O → Enter → Ctrl+X
cat servidor-web.conf
```

### Lab 2 — Vim: edición básica
```bash
vim practica.txt
# i → escribir → Esc → :wq
cat practica.txt
```

### Lab 3 — Vim: sustitución global
```bash
vim config.env
# i → escribir vars con 'localhost' → Esc
# :%s/localhost/10.0.1.5/g → :wq
cat config.env
```

---

## 📊 Conceptos aprendidos

| Concepto | Descripción |
|---------|-------|
| Editor modal | Vim separa modos: Normal, Insertar, Comando |
| `:wq` | Guardar y salir en vim |
| `:q!` | Descartar cambios y salir |
| `:%s/old/new/g` | Sustitución global en archivo |
| `/patron` | Búsqueda en vim |
| `Ctrl+O` / `Ctrl+X` | Guardar / salir en nano |

---

## 📊 Dashboard de Progreso

| Métrica | Valor |
|---------|-------|
| Días Completados | 5 |
| Fase Actual | Fase 0 — Linux |
| Próximo Reto | Día 06: SSH — Llaves y Conexiones Seguras |

---

## 🔗 Lab publicado en ceroaproduccion.dev

[/labs/linux-editores-texto](https://ceroaproduccion.dev/labs/linux-editores-texto)
