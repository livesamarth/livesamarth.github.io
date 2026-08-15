# Local LaTeX Resume Development Workflow

Local development workflow for editing and compiling the resume without depending on Overleaf.

The repository is already configured with the required LaTeX class, fonts, build configuration, Makefile, Git configuration, and VS Code configuration.

## Toolchain

- **BasicTeX / TeX Live** — LaTeX distribution
- **XeLaTeX** — compiler used by the resume
- **latexmk** — build automation
- **VS Code** — editor
- **LaTeX Workshop** — VS Code LaTeX integration

---

## 1. Prerequisites

This workflow assumes macOS.

The required development tools are:

- Homebrew
- BasicTeX
- `xelatex`
- `latexmk`
- VS Code
- LaTeX Workshop

If the repository is being set up on a new machine, install the tools as described below.

### Homebrew

Verify Homebrew:

```bash
brew --version
```

### BasicTeX

Install BasicTeX:

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

### Required TeX Live packages

The resume depends on the packages used by `resume.tex` and `deedy-resume-openfont.cls`.

Install them with:

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

### Verify the tools

```bash
xelatex --version
latexmk -v
```

---

## 2. Clone the Repository

Clone the repository into the development directory:

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

## 3. VS Code

Install VS Code using Homebrew:

```bash
brew install --cask visual-studio-code
```

Open the repository:

```bash
cd ~/Developer/resume
code .
```

If the `code` command is unavailable, enable it from VS Code:

**Command Palette → Shell Command: Install 'code' command in PATH**

### LaTeX Workshop

Install the **LaTeX Workshop** extension in VS Code.

It provides:

- LaTeX syntax highlighting
- Automatic compilation
- Build diagnostics
- PDF preview
- SyncTeX
- Forward and inverse search

---

## 4. Daily Development Workflow

Open the repository:

```bash
cd ~/Developer/resume
code .
```

Open:

```text
resume.tex
```

Edit the resume and save with:

```text
Cmd + S
```

LaTeX Workshop automatically builds the document.

The development loop is:

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

The generated PDF can be viewed directly in VS Code.

---

## 5. Terminal Workflow

The resume can also be built without VS Code.

### Build

```bash
make
```

### Build and open the PDF

```bash
make open
```

### Clean generated files

```bash
make clean
```

### Clean and rebuild

```bash
make rebuild
```

The terminal workflow is useful for verifying that the project builds independently of the editor.

---

## 6. Useful Commands

| Command | Purpose |
|---|---|
| `make` | Build the resume |
| `make build` | Build the resume |
| `make open` | Build and open the PDF |
| `make clean` | Remove generated LaTeX files |
| `make rebuild` | Clean and rebuild |
| `latexmk resume.tex` | Build using the repository configuration |
| `xelatex --version` | Show XeLaTeX version |
| `latexmk -v` | Show latexmk version |
| `git status` | Check repository changes |
| `git diff` | Review source changes |

---

## 7. Recommended Daily Workflow

For normal resume editing:

```bash
cd ~/Developer/resume
code .
```

Then:

1. Open `resume.tex`.
2. Make the required changes.
3. Save with `Cmd + S`.
4. Review the automatically generated PDF.
5. Repeat until the resume is finalized.
6. Commit the source changes when ready.

For a quick terminal build:

```bash
cd ~/Developer/resume
make open
```

---

## 8. Troubleshooting

### Build fails after changes

Clean the generated files:

```bash
make clean
```

Then rebuild:

```bash
make
```

Or:

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

For example:

```bash
kpsewhich graphicx.sty
```

or:

```bash
kpsewhich substr.sty
```

---

## 9. Repository Structure

The repository contains the source and development configuration required for the local workflow:

```text
resume/
├── resume.tex
├── deedy-resume-openfont.cls
├── fonts/
│   ├── lato/
│   └── raleway/
├── Makefile
├── .latexmkrc
├── .gitignore
└── .vscode/
    └── settings.json
```

Generated LaTeX files and `resume.pdf` are build artifacts and are excluded from version control.

---

## 10. Development Architecture

The local development workflow is:

```text
                         VS Code
                            │
                       resume.tex
                            │
                         Save
                            │
                            ▼
                   LaTeX Workshop
                            │
                            ▼
                         latexmk
                            │
                            ▼
                         XeLaTeX
                            │
                  ┌─────────┴─────────┐
                  │                   │
                  ▼                   ▼
          deedy-resume-openfont   Project fonts
                  │                   │
                  └─────────┬─────────┘
                            ▼
                       resume.pdf
```

The same build system can be invoked directly from the terminal using `make`.

---

## 11. Source of Truth

The primary source file is:

```text
resume.tex
```

Resume content and formatting changes should be made in the repository rather than in generated files.

The PDF should be treated as a build artifact generated from the source.

The local repository is therefore the complete development environment for the resume.
