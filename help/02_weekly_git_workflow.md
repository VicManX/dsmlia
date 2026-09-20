# Flujo semanal con Git

Esta guía propone trabajar cada semana en un branch independiente. La rama
`main` conserva el último estado estable del curso mientras el trabajo en curso
permanece aislado.

## Branches y tags

- Un **branch** es un espacio de trabajo que avanza con cada commit.
- Un **tag** identifica un commit concreto y sirve para marcar un hito.
- El branch semanal se crea antes de modificar la sesión.
- El tag semanal, si se utiliza, se crea después de fusionar el trabajo en
  `main`.

Convenciones recomendadas:

```text
Branch de sesión: session/week-01
Branch de tarea:  assignment/assignment-01
Tag semanal:      week-01
Tag de entrega:   assignment-01-submitted
```

No es necesario crear un tag antes del branch: si todavía no existen nuevos
commits, ambos apuntarían al mismo estado. Los tags tampoco son obligatorios;
son útiles cuando se desea conservar una referencia clara a una semana cerrada
o una entrega enviada.

## 1. Preparar `main`

Antes de comenzar una semana:

```bash
git switch main
git pull --ff-only origin main
git status -sb
```

El árbol de trabajo debe estar limpio antes de crear el branch.

## 2. Crear el branch semanal

```bash
git switch -c session/week-01
```

Verificar la rama activa:

```bash
git branch --show-current
```

## 3. Crear la sesión desde la plantilla

```bash
cp -r sessions/_template sessions/week_01
```

La estructura inicial será:

```text
sessions/week_01/
├── README.md
├── main.ipynb
└── figures/
```

Se deben completar los apuntes en `README.md` y desarrollar los ejemplos y
prácticas en `main.ipynb`.

## 4. Revisar y guardar avances

Examinar los cambios antes de prepararlos:

```bash
git status --short
git diff
```

Agregar solamente los archivos relacionados con la sesión:

```bash
git add sessions/week_01 README.md
git commit -m "Add week 01 session"
```

Si la semana requiere varios avances, se pueden hacer commits adicionales con
mensajes que describan cada unidad de trabajo:

```text
Add week 01 session structure
Add exploratory analysis examples
Complete week 01 notes
```

## 5. Publicar el branch

```bash
git push -u origin session/week-01
```

Los siguientes envíos desde el mismo branch pueden realizarse con:

```bash
git push
```

## 6. Crear el pull request

```bash
gh pr create \
  --base main \
  --head session/week-01 \
  --title "Add week 01 session" \
  --body "Adds the notes, notebook, and figures for week 01."
```

Abrirlo en el navegador para revisar los archivos:

```bash
gh pr view --web
```

Antes de fusionarlo, comprobar que:

- el notebook se ejecuta de principio a fin;
- no se añadieron datos grandes, credenciales o archivos temporales;
- los apuntes y figuras están actualizados;
- el pull request contiene únicamente cambios de esa semana.

## 7. Fusionar y eliminar el branch

Cuando la sesión esté completa:

```bash
gh pr merge --merge --delete-branch
```

Después, actualizar la copia local de `main`:

```bash
git switch main
git pull --ff-only origin main
```

Eliminar los branches terminados mantiene el repositorio fácil de navegar. El
historial de commits y el pull request permanecen disponibles después de la
eliminación.

## 8. Crear el tag semanal

Este paso es opcional y se realiza después del merge:

```bash
git tag -a week-01 -m "Complete week 01"
git push origin week-01
```

Verificar el tag:

```bash
git show week-01
```

Se recomienda publicar el tag de forma explícita en lugar de usar
`git push --tags`, para evitar enviar accidentalmente otros tags locales.

## 9. Comenzar la siguiente semana

Cada branch nuevo debe partir de un `main` actualizado:

```bash
git switch main
git pull --ff-only origin main
git switch -c session/week-02
```

## Resumen

```text
Actualizar main
      ↓
Crear branch semanal
      ↓
Trabajar y hacer commits
      ↓
Publicar branch y abrir pull request
      ↓
Revisar y fusionar en main
      ↓
Crear tag opcional sobre el resultado final
```

## Referencias

- [GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow)
- [Documentación de `git tag`](https://git-scm.com/docs/git-tag)
- [Crear un pull request con GitHub CLI](https://cli.github.com/manual/gh_pr_create)
- [Fusionar un pull request con GitHub CLI](https://cli.github.com/manual/gh_pr_merge)
