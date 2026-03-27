# Fase 0 · Día 4 — Procesos y Servicios

## 📅 Fecha

Jueves, 26 de Marzo de 2026

## 🎯 Objetivo

Comprender cómo Linux gestiona procesos y servicios — ver qué está corriendo, controlarlo y entender systemd. Base directa para administrar servidores y contenedores en producción.

## ⏱️ Tiempo invertido

~2.5 horas

## 🖥️ Entorno

* **OS:** Ubuntu 24.04 LTS (WSL2) | **Usuario:** dsalazar | **Máquina:** DESKTOP-13M4CS8

---

## 📚 Concepto clave del día

Todo lo que corre en Linux es un proceso. Cada servicio es un proceso gestionado por systemd. Entender PID, señales y estados de proceso es lo mismo que entender por qué un contenedor Docker no responde o por qué un servicio en un servidor EC2 está caído. El diagnóstico siempre empieza aquí.

---

## 🔧 Comandos practicados

```bash
# Ver procesos activos
ps aux                              # todos los procesos del sistema
ps aux | grep bash                  # filtrar por nombre
ps -ef | head -20                   # formato alternativo, primeros 20

# Monitoreo en tiempo real
top                                 # monitor básico (M=memoria, P=CPU, q=salir)
htop                                # monitor interactivo mejorado (q=salir)

# Procesos en segundo plano
sleep 300 &                         # lanzar proceso en background
jobs                                # ver jobs activos en la sesión
kill PID                            # matar proceso por PID
killall sleep                       # matar todos los procesos con ese nombre

# Señales de kill
kill -15 PID                        # SIGTERM — terminación limpia (default)
kill -9 PID                         # SIGKILL — fuerza bruta, no ignorable

# Gestión de servicios con systemctl
systemctl status cron               # ver estado de un servicio
sudo systemctl stop cron            # detener servicio
sudo systemctl start cron           # iniciar servicio
sudo systemctl restart cron         # reiniciar servicio
sudo systemctl enable cron          # activar en arranque
sudo systemctl disable cron         # desactivar en arranque
systemctl list-units --type=service --state=running   # listar servicios activos

# Logs del sistema con journalctl
journalctl -n 20                    # últimas 20 líneas del sistema
journalctl -u cron -n 10            # logs de un servicio específico
journalctl -f                       # seguimiento en tiempo real (Ctrl+C para salir)
```

---

## 📸 Screenshots

### 1. ps aux — tabla de procesos del sistema

[![ps aux](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia04/screenshots/01-ps-aux.png)](/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia04/screenshots/01-ps-aux.png)

### 2. htop — monitor interactivo en tiempo real

[![htop](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia04/screenshots/02-htop.png)](/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia04/screenshots/02-htop.png)

### 3. jobs y kill — control de procesos en background

[![jobs kill](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia04/screenshots/03-jobs-kill.png)](/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia04/screenshots/03-jobs-kill.png)

### 4. killall — terminar múltiples procesos de golpe

[![killall](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia04/screenshots/04-killall.png)](/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia04/screenshots/04-killall.png)

### 5. Servicios activos — systemctl list-units

[![servicios activos](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia04/screenshots/05-servicios-activos.png)](/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia04/screenshots/05-servicios-activos.png)

### 6. Ciclo stop/start de cron con systemctl

[![systemctl cron](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia04/screenshots/06-systemctl-cron.png)](/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia04/screenshots/06-systemctl-cron.png)

### 7. journalctl — logs del sistema en tiempo real

[![journalctl](https://github.com/dsalazarweb/aws-learning/raw/main/labs/fase0-linux/dia04/screenshots/07-journalctl.png)](/dsalazarweb/aws-learning/blob/main/labs/fase0-linux/dia04/screenshots/07-journalctl.png)

---

## 🎓 Conceptos aprendidos

| Concepto | Descripción |
| --- | --- |
| `PID` | Process ID — identificador único de cada proceso en ejecución |
| `ps aux` | Snapshot de todos los procesos: usuario, PID, CPU, MEM, estado, comando |
| Estado `S` | Sleeping — proceso esperando evento (la mayoría del tiempo) |
| Estado `R` | Running — proceso usando CPU activamente |
| Estado `Z` | Zombie — proceso terminado que aún no fue recogido por su padre |
| `top` vs `htop` | `top` = disponible siempre; `htop` = más visual, requiere instalación |
| `&` al final | Lanza proceso en background, devuelve control al terminal |
| `jobs` | Lista procesos en background de la sesión actual |
| `kill -15` | SIGTERM: pide al proceso que termine limpiamente |
| `kill -9` | SIGKILL: fuerza terminación inmediata, no puede ser ignorada |
| `killall` | Mata todos los procesos con ese nombre de una vez |
| `systemctl` | Interfaz de systemd para gestionar servicios del sistema |
| `journalctl` | Visor de logs de systemd — centraliza todos los registros del sistema |
| PID cambia al reiniciar | Cada inicio de servicio genera un nuevo PID — nunca hardcodear PIDs |

**Estados de proceso en Linux:**

| Estado | Símbolo | Descripción |
| --- | --- | --- |
| Running | `R` | Usando CPU activamente |
| Sleeping | `S` | Esperando evento o I/O |
| Stopped | `T` | Pausado por señal |
| Zombie | `Z` | Terminado, esperando ser recogido |

**Señales de kill más usadas:**

| Señal | Número | Uso |
| --- | --- | --- |
| SIGTERM | 15 | Terminación limpia (default de `kill`) |
| SIGKILL | 9 | Fuerza bruta — último recurso |
| SIGHUP | 1 | Reload de configuración sin reiniciar |

---

## ✅ Checklist

* `ps aux` ejecutado e interpretado columna por columna
* `top` y `htop` comparados en tiempo real
* Proceso lanzado en background con `&` y controlado con `jobs`
* `kill` por PID ejecutado correctamente
* `killall` usado para terminar múltiples procesos
* `systemctl status/stop/start` probado con cron
* 13 servicios activos listados y reconocidos
* `journalctl` explorado: sistema, servicio específico y tiempo real
* Screenshots tomados y organizados
* Push a GitHub hecho

## 💡 Lección del día

> "En Linux un proceso es cualquier cosa que corre. En AWS un contenedor es un proceso. En Kubernetes un pod es un proceso. El comando cambia, el concepto no."

---

**Estado:** ✅ Completado | **Tiempo:** ~2.5h | **Siguiente:** Día 5 — Editores nano y vim
