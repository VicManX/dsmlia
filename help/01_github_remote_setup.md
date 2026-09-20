# Publicar el repositorio en GitHub

Esta guía permite publicar un repositorio Git local en GitHub mediante GitHub
CLI (`gh`).

## 1. Verificar el repositorio local

Ejecutar desde la raíz del proyecto:

```bash
git status -sb
git branch --show-current
git remote -v
```

Antes de publicar, conviene confirmar que:

- la rama principal se llama `main`;
- los cambios necesarios ya tienen commit;
- no existen credenciales ni datos sensibles pendientes de subir;
- `origin`, si existe, apunta al repositorio correcto.

## 2. Verificar GitHub CLI

```bash
gh --version
gh auth status
```

Si no hay una sesión iniciada, autenticarse mediante el navegador:

```bash
gh auth login --hostname github.com --git-protocol ssh --web
```

Después, comprobar nuevamente:

```bash
gh auth status
```

## 3. Comprobar si el repositorio remoto existe

Para este proyecto:

```bash
gh repo view VicManX/dsmlia
```

Si GitHub muestra la información del repositorio, no es necesario volver a
crearlo.

## 4. Crear el repositorio remoto si no existe

Si `origin` ya está configurado pero el repositorio todavía no existe:

```bash
gh repo create VicManX/dsmlia --private
```

Se puede reemplazar `--private` por `--public` si el contenido debe ser visible
para cualquier persona.

Para un proyecto nuevo que aún no tenga remoto configurado, se puede crear el
repositorio, añadir `origin` y publicar la rama actual en un solo paso:

```bash
gh repo create VicManX/REPOSITORY_NAME \
  --private \
  --source=. \
  --remote=origin \
  --push
```

No se debe ejecutar esta variante si ya existe un remoto llamado `origin`.

## 5. Publicar la rama principal

Cuando el repositorio remoto ya existe y `origin` está configurado:

```bash
git push -u origin main
```

La opción `-u` asocia la rama local con `origin/main`. Después del primer
envío, normalmente será suficiente ejecutar:

```bash
git push
```

## 6. Verificar el resultado

```bash
git status -sb
gh repo view --web
```

Si las ramas están sincronizadas, `git status -sb` mostrará algo similar a:

```text
## main...origin/main
```

## Problemas frecuentes

### GitHub CLI no está autenticado

```text
You are not logged into any GitHub hosts
```

Solución:

```bash
gh auth login --hostname github.com --git-protocol ssh --web
```

### El remoto `origin` ya existe

Revisar primero su dirección:

```bash
git remote -v
```

Si es incorrecta, reemplazarla sin crear otro remoto:

```bash
git remote set-url origin git@github.com:USER/REPOSITORY.git
```

### Falló la autenticación SSH

Comprobar la conexión:

```bash
ssh -T git@github.com
```

Nunca se debe compartir ni subir una llave privada al repositorio.

### El push fue rechazado por cambios remotos

No usar `--force` sin entender primero la diferencia entre los historiales.
Inspeccionar el estado remoto:

```bash
git fetch origin
git log --oneline --graph --decorate --all
```

## Referencias

- [Agregar código local a GitHub](https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github)
- [Documentación de `gh repo create`](https://cli.github.com/manual/gh_repo_create)
- [Conectarse a GitHub mediante SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
