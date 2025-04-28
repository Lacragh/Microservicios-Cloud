
# Proyecto Microservicios - Taller Ingeniería de Software V

## 🚀 Descripción General
Este proyecto implementa una arquitectura de microservicios desplegada en **Google Cloud Run**, utilizando **Docker** y **GitHub Actions** para automatizar los pipelines de desarrollo y despliegue.  
Incluye un frontend web y varios servicios backend independientes, comunicados de forma segura y escalable.

---

## 📆 Metodología Ágil

Se ha seleccionado la metodología **Kanban** debido a su simplicidad y adaptabilidad en equipos pequeños, permitiendo el control visual de tareas, la mejora continua y una entrega fluida de valor.

---

## 📂 Estrategia de Branching

### Desarrollo - Git Flow

- **main**: rama principal de producción estable.
- **develop**: rama base para integración de nuevas funcionalidades.
- **feature/**: ramas para nuevas funcionalidades (`feature/nombre`).
- **bugfix/**: ramas para corregir errores menores (`bugfix/nombre`).
- **hotfix/**: ramas para corregir errores urgentes en producción (`hotfix/nombre`).

### Infraestructura - Trunk-Based Development

- **infra/main**: rama principal para toda la infraestructura como código (IaC).

---

## 🛠️ Patrones de Diseño en la Nube

Se implementaron los siguientes patrones para asegurar escalabilidad y resiliencia:

- **Microservicios**: Cada módulo funciona de manera autónoma.
- **Secure Network Entry**: Sólo los endpoints públicos son accesibles; el tráfico interno entre servicios está controlado.
- **Stateless Services**: Cada microservicio procesa las solicitudes de forma independiente, sin mantener estados en memoria.
- **Bulkhead Pattern**: Previene el fallo en cascada en caso de error de un servicio.
- **Serverless Deployment**: El sistema está desplegado en Google Cloud Run, permitiendo ejecución bajo demanda, escalado automático y reducción de costos operativos.

---

## 📊 Arquitectura General

**Microservicios:**

- `auth-api`: Servicio de autenticación y login.
- `users-api`: Gestión de usuarios.
- `todos-api`: Gestión de tareas.
- `frontend`: Aplicación web para interacción de usuarios.
- `log-message-processor`: Procesamiento y almacenamiento de logs.
- `redis`: Broker de mensajes para comunicación asíncrona entre servicios.

**Infraestructura:**

- Todos los microservicios se despliegan como contenedores serverless en **Google Cloud Run**.
- Uso de **DockerHub** como repositorio de imágenes públicas.
- Comunicación segura entre servicios y exposición controlada al exterior.

---

## 🚛 Pipelines de Desarrollo (CI)

### Ubicación:
`.github/workflows/dev-pipeline.yml`

### Acciones:
- Clona el repositorio.
- Hace login en DockerHub.
- Construye las imágenes Docker para cada microservicio.
- Sube las imágenes al DockerHub del usuario `lacragh`.

### Activación:
- Push a `develop`.
- Push a ramas `feature/**`.
- Pull Requests hacia `develop`.

---

## 🏛️ Pipeline de Infraestructura (CD)

### Ubicación:
`.github/workflows/deploy.yml`

### Acciones:
- Autenticarse en Google Cloud Platform (GCP) utilizando `google-github-actions/auth`.
- Configurar `gcloud` CLI.
- Desplegar automáticamente cada microservicio en Google Cloud Run.
- Generar un `revision-suffix` único para asegurar actualizaciones forzadas de los servicios.

### Activación:
- Ejecución manual (`workflow_dispatch`).
- Push hacia ramas de infraestructura (`infra/main`).

### Requisitos:
- Tener configurados los secretos `GCP_CREDENTIALS`, `GCP_PROJECT_ID` y `GCP_REGION` en GitHub.

---


# 🚀 Infraestructura del Proyecto - Microservicio App Example

## 📋 Estructura de Infraestructura

- **Despliegue serverless** de microservicios en **Google Cloud Run**.
- **Contenerización** completa usando **Docker**.
- **Automatización de infraestructura** mediante **GitHub Actions**.

## 🚀 Servicios desplegados

- `auth-api`
- `users-api`
- `todos-api`
- `frontend`
- `redis`
- `zipkin`

Todos desplegados en **Google Cloud Run** región `us-central1`.

## 🔒 Seguridad

- Uso de `Secrets` en GitHub para manejar credenciales.
- Aislamiento de servicios y tráfico controlado.

## 📚 Referencias

- [Documentación de Google Cloud Run](https://cloud.google.com/run/docs)
- [GitHub Actions para Google Cloud](https://github.com/google-github-actions)

## 👨‍💻 Autores

**Luis Charria**

**Victor Manuel Garzon**

---
