#!/usr/bin/env bash
# ============================================================
# create_claude_project.sh
# Génère la structure d'un projet Claude Code
# Usage : ./create_claude_project.sh [nom_du_projet]
# ============================================================

PROJECT="${1:-claude_code_project}"

echo "🚀 Création du projet : $PROJECT"

# ── Racine ──────────────────────────────────────────────────
mkdir -p "$PROJECT"

# CLAUDE.md
cat > "$PROJECT/CLAUDE.md" << 'EOF'
# CLAUDE.md

Project memory and instructions for Claude.

## Project Overview
Describe your project here.

## Architecture
See docs/architecture.md for details.

## Development Guidelines
- Keep prompts modular
- Document architecture decisions
- Use skills for repeated workflows
EOF

# README.md
cat > "$PROJECT/README.md" << 'EOF'
# Claude Code Project

A modular repository structure designed for building Claude Code projects
with structured AI context, reusable skills, and automated development workflows.

## Getting Started
1. Clone the repository
2. Configure Claude settings in `.claude/settings.json`
3. Define project context in `CLAUDE.md`
4. Add reusable skills in `.claude/skills/`
5. Start building modules in `src/`
EOF

# ── docs/ ────────────────────────────────────────────────────
mkdir -p "$PROJECT/docs/decisions"
mkdir -p "$PROJECT/docs/runbooks"

cat > "$PROJECT/docs/architecture.md" << 'EOF'
# Architecture

## Overview
Describe the high-level architecture of your project here.

## Components
- **src/api/** – API layer
- **src/persistence/** – Data persistence layer

## Decisions
See the `decisions/` folder for Architecture Decision Records (ADRs).
EOF

cat > "$PROJECT/docs/decisions/.gitkeep" < /dev/null
cat > "$PROJECT/docs/runbooks/.gitkeep" < /dev/null

# ── .claude/ ─────────────────────────────────────────────────
mkdir -p "$PROJECT/.claude/hooks"
mkdir -p "$PROJECT/.claude/skills/code-review"
mkdir -p "$PROJECT/.claude/skills/refactor"
mkdir -p "$PROJECT/.claude/skills/release"

cat > "$PROJECT/.claude/settings.json" << 'EOF'
{
  "model": "claude-opus-4-5",
  "context_files": ["CLAUDE.md"],
  "hooks_enabled": true
}
EOF

# Skills SKILL.md
cat > "$PROJECT/.claude/skills/code-review/SKILL.md" << 'EOF'
# Skill: Code Review

## Description
Automated code review workflow for pull requests.

## Steps
1. Analyze changed files for style and logic issues
2. Check for security vulnerabilities
3. Verify test coverage
4. Generate review summary
EOF

cat > "$PROJECT/.claude/skills/refactor/SKILL.md" << 'EOF'
# Skill: Refactor

## Description
Guided refactoring workflow for improving code quality.

## Steps
1. Identify code smells and technical debt
2. Propose refactoring strategy
3. Apply changes incrementally
4. Run tests after each change
EOF

cat > "$PROJECT/.claude/skills/release/SKILL.md" << 'EOF'
# Skill: Release

## Description
Automated release preparation workflow.

## Steps
1. Bump version number
2. Update CHANGELOG.md
3. Run full test suite
4. Generate release notes
5. Create git tag
EOF

# ── tools/ ───────────────────────────────────────────────────
mkdir -p "$PROJECT/tools/scripts"
mkdir -p "$PROJECT/tools/prompts"

cat > "$PROJECT/tools/scripts/.gitkeep" < /dev/null

cat > "$PROJECT/tools/prompts/example.md" << 'EOF'
# Example Prompt

Use this template to define reusable prompts for your project.

## Prompt
```
Your prompt text here.
```

## Usage
Describe when and how to use this prompt.
EOF

# ── src/ ─────────────────────────────────────────────────────
mkdir -p "$PROJECT/src/api"
mkdir -p "$PROJECT/src/persistence"

cat > "$PROJECT/src/api/CLAUDE.md" << 'EOF'
# API Module

## Responsibility
Handles all external-facing endpoints and request validation.

## Conventions
- Use RESTful patterns
- Validate inputs at the boundary
- Return consistent JSON responses
EOF

cat > "$PROJECT/src/persistence/CLAUDE.md" << 'EOF'
# Persistence Module

## Responsibility
Manages data storage, retrieval, and migrations.

## Conventions
- Abstract database access behind repository classes
- Keep migrations versioned and reversible
EOF

# ── Résumé ───────────────────────────────────────────────────
echo ""
echo "✅ Structure créée avec succès !"
echo ""
find "$PROJECT" | sort | sed "s|[^/]*/|  |g"