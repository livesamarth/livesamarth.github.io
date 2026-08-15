# Local LaTeX Resume Development Workflow

Local development and deployment workflow for editing, compiling, and publishing the resume without depending on Overleaf.

The repository is configured so that the **LaTeX source is the source of truth**. The resume can be built locally for development, and GitHub Actions automatically builds and deploys the latest PDF to GitHub Pages whenever changes are pushed to `main`.

## Toolchain

- **BasicTeX / TeX Live** — LaTeX distribution
- **XeLaTeX** — compiler used by the resume
- **latexmk** — LaTeX build automation
- **Make** — simple terminal build interface
- **VS Code** — editor
- **LaTeX Workshop** — VS Code LaTeX integration
- **GitHub Actions** — CI/CD
- **GitHub Pages** — production hosting

---

## 1. Repository Structure

```text
resume/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── .vscode/
│   └── settings.json
├── fonts/
│   ├── lato/
│   └── raleway/
├── resume.tex
├── deedy-resume-openfont.cls
├── Makefile
├── .latexmkrc
├── .gitignore
├── index.html
└── README.md
```

| File / Directory | Purpose |
|---|---|
| `resume.tex` | Resume source and content |
| `deedy-resume-openfont.cls` | Resume document class and layout |
| `fonts/` | Project-local Lato and Raleway fonts |
| `.latexmkrc` | LaTeX build configuration |
| `Makefile` | Local build commands |
| `.vscode/settings.json` | VS Code / LaTeX Workshop configuration |
| `.github/workflows/deploy.yml` | GitHub Actions CI/CD workflow |
| `index.html` | GitHub Pages website |
| `.gitignore` | Excludes generated files |

`resume.pdf` and other LaTeX auxiliary files are generated artifacts and are not committed to Git.

---

## 2. Prerequisites

This workflow assumes macOS.

### Homebrew

```bash
brew --version
```

### BasicTeX

```bash
brew install --cask basictex
```

Restart the terminal after installation.

Verify:

```bash
xelatex --version
```

### Update TeX Live

```bash
sudo tlmgr update --self
```

### Required LaTeX packages

```bash
sudo tlmgr install \
  fancyhdr \
  graphics \
  wrapfig \
  enumitem \
  blindtext \
  pgf \
  xcolor \
  geometry \
  hyperref \
  cite \
  fontspec \
  textpos \
  isodate \
  titlesec \
  substr \
  latexmk
```

### Verify

```bash
xelatex --version
latexmk -v
```

---

## 3. Clone the Repository

```bash
mkdir -p ~/Developer
cd ~/Developer
git clone <repository-url> resume
cd resume
```

For an existing checkout:

```bash
cd ~/Developer/resume
```

---

## 4. VS Code

Install VS Code:

```bash
brew install --cask visual-studio-code
```

Open the repository:

```bash
cd ~/Developer/resume
code .
```

If `code` is unavailable, enable it from VS Code:

**Command Palette → Shell Command: Install 'code' command in PATH**

Install the **LaTeX Workshop** extension.

It provides LaTeX syntax highlighting, automatic compilation, build diagnostics, PDF preview, SyncTeX, and forward/inverse search.

The repository already contains the required LaTeX Workshop configuration.

---

## 5. Local Development Workflow

Open:

```text
resume.tex
```

Edit and save with:

```text
Cmd + S
```

LaTeX Workshop automatically builds the document.

```text
Edit resume.tex
      ↓
    Save
      ↓
LaTeX Workshop
      ↓
    latexmk
      ↓
    XeLaTeX
      ↓
  resume.pdf
```

---

## 6. Terminal Workflow

Build:

```bash
make
```

Build and open the PDF:

```bash
make open
```

Clean generated files:

```bash
make clean
```

Clean and rebuild:

```bash
make rebuild
```

---

## 7. Git Workflow

Normal development:

```text
Edit
  ↓
Local build
  ↓
Review PDF
  ↓
git add
  ↓
git commit
  ↓
git push
```

Example:

```bash
git status
git add resume.tex
git commit -m "Update resume"
git push origin main
```

Do not commit generated LaTeX artifacts or the generated PDF.

---

## 8. GitHub Actions CI/CD

GitHub Actions provides the automated production build and deployment pipeline.

The workflow is defined in:

```text
.github/workflows/deploy.yml
```

It runs when changes are pushed to `main` and can also be manually triggered with `workflow_dispatch`.

```text
Local repository
      │
      │ git push origin main
      ▼
GitHub repository
      │
      ▼
GitHub Actions
      │
      ├── Checkout source
      ├── Build with XeLaTeX
      ├── Generate resume.pdf
      ├── Prepare website artifact
      └── Deploy artifact
             │
             ▼
       GitHub Pages
```

The production PDF is generated from the committed `resume.tex`; it does not need to be committed to the repository.

---

## 9. GitHub Pages

GitHub Pages should use:

```text
Build and deployment
        ↓
Source
        ↓
GitHub Actions
```

The deployment workflow publishes the generated website artifact.

`index.html` references the generated `resume.pdf`.

Every successful deployment therefore publishes the PDF generated from the latest `main` branch.

---

## 10. End-to-End Deployment

Edit the resume:

```bash
cd ~/Developer/resume
code .
```

Build and review locally:

```bash
make open
```

Commit and push:

```bash
git add resume.tex
git commit -m "Update resume"
git push origin main
```

GitHub automatically performs:

```text
Edit
  ↓
Local build/review
  ↓
git push
  ↓
GitHub Actions
  ↓
XeLaTeX
  ↓
resume.pdf
  ↓
GitHub Pages
  ↓
Live website
```

There is no manual PDF upload or deployment step.

---

## 11. Useful Commands

| Command | Purpose |
|---|---|
| `make` | Build the resume |
| `make build` | Build the resume |
| `make open` | Build and open the PDF |
| `make clean` | Remove generated LaTeX files |
| `make rebuild` | Clean and rebuild |
| `latexmk resume.tex` | Build using project configuration |
| `xelatex --version` | Show XeLaTeX version |
| `latexmk -v` | Show latexmk version |
| `git status` | Show working tree status |
| `git diff` | Review changes |
| `git log --oneline` | Review commit history |
| `git push origin main` | Push changes and trigger deployment |

---

## 12. Troubleshooting

### Local build fails

```bash
make clean
make
```

or:

```bash
make rebuild
```

### Check XeLaTeX

```bash
which xelatex
xelatex --version
```

### Check latexmk

```bash
which latexmk
latexmk -v
```

### Check a LaTeX package

```bash
kpsewhich graphicx.sty
```

or:

```bash
kpsewhich substr.sty
```

### GitHub Actions build fails

Open:

```text
GitHub repository
    → Actions
    → Build and Deploy Resume
```

Inspect the failed workflow step and its build log.

- **Local build failure** → fix the local LaTeX source/environment.
- **GitHub Actions build failure** → inspect the CI build log.
- **Deployment failure** → inspect the GitHub Pages/deployment job.

---

## 13. Source and Generated Files

### Source files

```text
resume.tex
deedy-resume-openfont.cls
fonts/
index.html
Makefile
.latexmkrc
.gitignore
.vscode/
.github/
```

### Generated files

```text
resume.pdf
*.aux
*.log
*.out
*.fls
*.fdb_latexmk
*.synctex.gz
*.xdv
*.toc
*.bcf
*.run.xml
```

Generated files should not be committed.

---

## 14. Development Architecture

```text
                           Git Repository
                                │
                     ┌──────────┴──────────┐
                     │                     │
                     ▼                     ▼
              Local Development      GitHub Actions
                     │                     │
                  VS Code              CI runner
                     │                     │
              LaTeX Workshop          TeX Live
                     │                     │
                  latexmk               XeLaTeX
                     │                     │
                  XeLaTeX                  │
                     │                     │
                     ▼                     ▼
              Local resume.pdf   Production resume.pdf
                                           │
                                           ▼
                                     GitHub Pages
                                           │
                                           ▼
                                      Live website
```

---

## 15. Final Daily Workflow

```bash
cd ~/Developer/resume
code .
```

Edit:

```text
resume.tex
```

Save and review the local PDF.

When satisfied:

```bash
git add .
git commit -m "Update resume"
git push origin main
```

GitHub Actions automatically:

```text
Build → Generate PDF → Package website → Deploy → GitHub Pages
```

The live website reflects the latest successfully deployed version of the LaTeX source on `main`.
