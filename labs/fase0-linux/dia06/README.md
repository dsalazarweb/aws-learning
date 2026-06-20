# Fase 0 · Día 6 — SSH: Llaves, Conexión y Configuración

## 📅 Fecha

Sábado, 20 de Junio de 2026

## 🎯 Objetivo

Aprender el ciclo completo de SSH desde cero: generar un par de llaves, levantar un servidor SSH, instalar la llave pública en ese servidor, ajustar permisos y dejar la conexión configurada para entrar con un solo comando. Es el **prerrequisito real para conectarse a una instancia EC2 en la Fase 4** — el mismo procedimiento, paso por paso.

## ⏱️ Tiempo invertido

~2 horas

## 🖥️ Entorno

* **OS:** Ubuntu 24.04 LTS (WSL2) | **Usuario:** dsalazar | **Máquina:** DESKTOP-13M4CS8

---

## 📚 Concepto clave del día

SSH (Secure Shell) es el protocolo con el que se administra cualquier servidor remoto del mundo. Cuando rentas una máquina en AWS, DigitalOcean o cualquier nube, no tienes monitor ni teclado físico: entras por SSH. La forma profesional de hacerlo **no es con contraseña**, sino con un **par de llaves criptográficas**:

- **Llave privada** → se queda en tu máquina, nunca se comparte. Es tu identidad.
- **Llave pública** → se copia al servidor. Es la cerradura que solo abre tu llave privada.

Quien tenga la llave privada que hace pareja con la pública instalada en el servidor, entra sin contraseña. Ese es el modelo que usaremos idéntico en EC2.

> **Cómo montamos el "servidor remoto" sin gastar:** en vez de rentar una máquina, instalamos un servidor SSH (`openssh-server`) dentro de nuestra propia WSL y nos conectamos a él vía `localhost`. El ciclo es exactamente el mismo que con un servidor real, pero gratis y sin salir del equipo.

---

## 🔧 Comandos practicados

```bash
# 1. Generar un par de llaves NUEVO y separado (no tocar la llave de GitHub)
ssh-keygen -t ed25519 -C "lab-ssh-dia06" -f ~/.ssh/id_ed25519_lab

# 2. Instalar y configurar el servidor SSH
sudo apt update && sudo apt install -y openssh-server
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config   # cambiar puerto por defecto
sudo grep -E '^Port' /etc/ssh/sshd_config

# 3. Desactivar la activación por socket (gotcha de Ubuntu 24.04)
sudo systemctl disable --now ssh.socket
sudo systemctl enable --now ssh.service
sudo systemctl restart ssh.service
sudo ss -tlnp | grep ssh                                    # verificar el puerto real

# 4. Copiar la llave pública al servidor + ajustar permisos
ssh-copy-id -i ~/.ssh/id_ed25519_lab.pub -p 2222 dsalazar@localhost
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys ~/.ssh/id_ed25519_lab
chmod 644 ~/.ssh/id_ed25519_lab.pub

# 5. Crear el archivo de configuración de cliente
cat > ~/.ssh/config <<'EOF'
Host labserver
    HostName localhost
    Port 2222
    User dsalazar
    IdentityFile ~/.ssh/id_ed25519_lab
EOF
chmod 600 ~/.ssh/config

# 6. Conectar con un solo comando
ssh labserver
```

---

## 📸 Paso a paso (cómo reconstruir el lab)

### 1. Generar el par de llaves

```bash
mkdir -p ~/labs/dia06 && cd ~/labs/dia06
ssh-keygen -t ed25519 -C "lab-ssh-dia06" -f ~/.ssh/id_ed25519_lab
```

`ssh-keygen` crea el par de llaves. Desglose de las opciones:

- `-t ed25519` → el **tipo** de algoritmo. Ed25519 es el estándar moderno: llaves cortas, rápidas y muy seguras. Reemplaza al viejo RSA.
- `-C "lab-ssh-dia06"` → un **comentario** que queda dentro de la llave pública para identificarla después.
- `-f ~/.ssh/id_ed25519_lab` → el **nombre del archivo** de salida. **Esto es lo más importante del día:** si no lo pones, `ssh-keygen` propone `~/.ssh/id_ed25519` y podría **sobrescribir tu llave de GitHub**. Al darle un nombre propio (`id_ed25519_lab`), la llave del lab queda separada.

Cuando pida *passphrase*, la dejamos vacía (Enter, Enter) porque es un lab local. En un servidor de producción sí conviene ponerle passphrase.

El resultado son dos archivos: `id_ed25519_lab` (privada) e `id_ed25519_lab.pub` (pública). El dibujo ASCII ("randomart") es una representación visual de la huella de la llave; sirve para reconocerla de un vistazo.

[![ssh-keygen](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia06/screenshots/01-ssh-keygen.png)](https://github.com/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia06/screenshots/01-ssh-keygen.png)

### 2. Instalar el servidor SSH y cambiar el puerto

```bash
sudo apt update && sudo apt install -y openssh-server
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
sudo grep -E '^Port' /etc/ssh/sshd_config
sudo service ssh restart
sudo service ssh status
```

`openssh-server` es el programa que **escucha** conexiones entrantes — el demonio `sshd`. Es exactamente lo que corre una instancia EC2 para que tú puedas entrar.

Con `sed` cambiamos el puerto por defecto (22) a **2222**. Cambiar el puerto es una práctica básica de *hardening* (reduce el ruido de bots que escanean el 22) y, sobre todo, nos obliga a entender el archivo `/etc/ssh/sshd_config`, que es donde se configura el servidor.

**Aquí aparece el primer tropiezo del lab** — y es uno bueno. El `status` muestra que el servicio está activo, pero al final del log dice:

```
Server listening on 0.0.0.0 port 22.
```

¡Sigue en el 22, no en el 2222! El archivo dice `Port 2222`, pero el servidor lo ignora. La pista está en la línea `TriggeredBy: ● ssh.socket`.

[![puerto 22 socket](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia06/screenshots/02-puerto-22-socket.png)](https://github.com/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia06/screenshots/02-puerto-22-socket.png)

### 3. Diagnosticar y corregir: la activación por socket

En Ubuntu 24.04 el SSH viene con **socket activation**: una unidad de systemd llamada `ssh.socket` se queda escuchando en el puerto 22 y solo "despierta" a `sshd` cuando llega una conexión. Esa unidad **tiene prioridad sobre** lo que escribas en `sshd_config`. Lo confirmamos:

```bash
sudo ss -tlnp | grep -E ':22|:2222'   # ¿quién escucha en qué puerto?
systemctl is-active ssh.socket        # active → el socket está mandando
systemctl cat ssh.socket | grep ListenStream   # ListenStream=0.0.0.0:22
```

La solución es desactivar el socket para que el servicio arranque "standalone" y lea nuestra configuración:

```bash
sudo systemctl disable --now ssh.socket   # apagar la activación por socket
sudo systemctl enable --now ssh.service   # que el servicio arranque solo
sudo systemctl restart ssh.service
sudo ss -tlnp | grep ssh                  # la prueba de fuego
```

Ahora sí, `ss` muestra `sshd` escuchando en `0.0.0.0:2222`. **La lección real:** cuando una configuración "no agarra", casi siempre hay una capa por encima decidiendo. Saber detectarla (`TriggeredBy`, `ss -tlnp`, `systemctl cat`) es el músculo de troubleshooting que se usa todos los días en producción.

[![puerto 2222 corregido](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia06/screenshots/03-puerto-2222-corregido.png)](https://github.com/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia06/screenshots/03-puerto-2222-corregido.png)

### 4. Copiar la llave al servidor y blindar permisos

```bash
ssh-copy-id -i ~/.ssh/id_ed25519_lab.pub -p 2222 dsalazar@localhost
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys ~/.ssh/id_ed25519_lab
chmod 644 ~/.ssh/id_ed25519_lab.pub
ls -l ~/.ssh
```

`ssh-copy-id` agrega tu llave **pública** al archivo `~/.ssh/authorized_keys` del servidor. Ese archivo es la lista de "llaves autorizadas a entrar". La primera vez pregunta si confías en el servidor (respondes `yes`) y luego pide tu contraseña de usuario **una última vez** — a partir de ahí ya entrarás con la llave.

Las opciones:
- `-i ~/.ssh/id_ed25519_lab.pub` → especifica **cuál** pública copiar (solo la del lab, no todas).
- `-p 2222` → el puerto del servidor (ojo: en `ssh-copy-id` y `ssh` el puerto se indica con `-p` minúscula).

**Los permisos no son opcional — SSH rechaza una llave si está demasiado abierta.** Esta es la causa del error más común al conectar a EC2:

| Comando | Permiso | Por qué |
|---|---|---|
| `chmod 700 ~/.ssh` | `drwx------` | Solo tú puedes entrar al directorio |
| `chmod 600 authorized_keys` | `-rw-------` | Solo tú lees/escribes la lista de llaves |
| `chmod 600 id_ed25519_lab` | `-rw-------` | La privada **debe** ser ilegible para otros |
| `chmod 644 id_ed25519_lab.pub` | `-rw-r--r--` | La pública puede leerla cualquiera |

[![ssh-copy-id y permisos](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia06/screenshots/04-ssh-copy-id-permisos.png)](https://github.com/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia06/screenshots/04-ssh-copy-id-permisos.png)

### 5. El archivo `~/.ssh/config` (el objetivo del día)

```bash
cat > ~/.ssh/config <<'EOF'
Host labserver
    HostName localhost
    Port 2222
    User dsalazar
    IdentityFile ~/.ssh/id_ed25519_lab
EOF
chmod 600 ~/.ssh/config
cat ~/.ssh/config
```

Sin este archivo tendrías que escribir el comando largo cada vez:
`ssh -i ~/.ssh/id_ed25519_lab -p 2222 dsalazar@localhost`.

El `config` guarda todos esos datos bajo un **apodo** (`labserver`). Cada bloque `Host` define un servidor:

- `Host labserver` → el apodo que escribirás (`ssh labserver`).
- `HostName` → la dirección real (IP o dominio; aquí `localhost`).
- `Port` → el puerto (2222).
- `User` → con qué usuario entrar.
- `IdentityFile` → qué llave privada usar.

En el trabajo real tendrás un bloque por servidor: `prod-web`, `staging-db`, etc. Es la diferencia entre memorizar IPs y trabajar como profesional.

[![archivo ssh config](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia06/screenshots/05-ssh-config.png)](https://github.com/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia06/screenshots/05-ssh-config.png)

### 6. La recompensa: conectar con un solo comando

```bash
ssh labserver "hostname; whoami; echo 'Entré usando solo: ssh labserver'"
```

Conexión exitosa, sin contraseña, usando la llave del lab. Lo que antes era un comando largo con cuatro parámetros ahora es `ssh labserver`. Este es el mismo flujo que usarás para entrar a un servidor EC2 en la Fase 4.

[![conexión labserver](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia06/screenshots/06-conexion-labserver.png)](https://github.com/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia06/screenshots/06-conexion-labserver.png)

---

## 🎓 Conceptos aprendidos

| Concepto | Descripción |
| --- | --- |
| Par de llaves | Privada (se queda contigo) + pública (se copia al servidor) |
| `ed25519` | Algoritmo de llave moderno: corto, rápido y seguro |
| `ssh-keygen -f` | Define el nombre de la llave — evita sobrescribir otras |
| `openssh-server` (`sshd`) | El demonio que escucha conexiones entrantes en el servidor |
| `sshd_config` | Archivo de configuración del **servidor** SSH |
| Socket activation | systemd escucha el puerto y arranca `sshd` bajo demanda; tiene prioridad sobre `sshd_config` |
| `ss -tlnp` | Muestra qué proceso escucha en qué puerto (diagnóstico clave) |
| `ssh-copy-id` | Instala tu llave pública en `authorized_keys` del servidor |
| `authorized_keys` | Lista de llaves públicas autorizadas a entrar |
| Permisos `600`/`700` | SSH rechaza la conexión si las llaves están demasiado abiertas |
| `~/.ssh/config` | Configuración del **cliente**: apodos por servidor |
| `Host` | Bloque que define un servidor (apodo, IP, puerto, usuario, llave) |

**Diferencia que conviene fijar:**

| Archivo | Lado | Para qué |
| --- | --- | --- |
| `sshd_config` | Servidor | Cómo se comporta el servidor (puerto, qué permite) |
| `~/.ssh/config` | Cliente | Cómo me conecto yo (apodos, llaves) |
| `authorized_keys` | Servidor | Quién tiene permiso de entrar |

---

## ✅ Checklist

* Par de llaves `ed25519` generado con nombre propio (sin tocar la de GitHub)
* `openssh-server` instalado y puerto cambiado a 2222 en `sshd_config`
* Detectada y corregida la activación por socket de Ubuntu 24.04
* Llave pública instalada con `ssh-copy-id`
* Permisos `700`/`600`/`644` aplicados y verificados
* `~/.ssh/config` creado con el bloque `Host labserver`
* Conexión exitosa con `ssh labserver` sin contraseña
* Screenshots tomados y organizados
* Push a GitHub hecho

## 💡 Lección del día

> "Conectarse a un servidor por SSH con llaves es la primera cosa que harás en cualquier nube. El servidor cambia —tu WSL hoy, una EC2 mañana— pero el ciclo llave → permisos → config → conexión es siempre el mismo."

---

**Estado:** ✅ Completado | **Tiempo:** ~2h | **Siguiente:** Día 7 — Logs del sistema (`journalctl`, `/var/log`)
