# 🎭 Funny Shell Setup

> *Because life's too short for a boring terminal.*

A single bash script that transforms your shell into a sarcastic, colorful, and actually-helpful development environment — with special focus on making `git` commands **explained and entertaining**.

---

## 🚀 Quick Start

```bash
# Run the installer
bash funny_shell_setup.sh

# Activate immediately (or just restart your terminal)
source ~/.bashrc
```

That's it. Your terminal will never be the same.

---

## ✨ Features

### 🎨 Colorful Smart Prompt
Your prompt now shows:
- **Username** and **hostname** in color
- **Current directory** highlighted
- **Git branch** when inside a repo
- **🟢 / 💥** emoji showing if your last command succeeded or failed

```
john@laptop:~/projects (main) 🟢 $
john@laptop:~/projects (main) 💥 $   ← something went wrong
```

---

### 👋 Random Greeting on Every Terminal
Each new terminal session gets a different snarky welcome:

```
🧠 Terminal activated. Coffee level: unknown.
🚀 Ready to deploy bugs to production?
💡 Reminder: 'rm -rf /' is NOT a valid fix.
```

---

### 🐙 Explained Git Commands
Every `git` command now tells you **what it's doing** and **why**, with humor included.

| Command | What you see |
|---|---|
| `git init` | Explains you're starting a tracked repo |
| `git add .` | Warns you're staging *everything* |
| `git commit` | Celebrates success or explains what went wrong |
| `git push` | "Your code is now in the cloud. Hope it works 🤞" |
| `git pull` | Warns about potential merge conflicts + how to fix them |
| `git merge` | Explains conflicts and gives recovery steps |
| `git rebase` | Warns about history rewriting + Star Wars reference |
| `git reset --hard` | **Asks for confirmation** before nuking your work |
| `git log` | Auto-pretty-prints with graph + colors (no args needed) |
| `git stash` | "Like shoving your mess under the bed when guests arrive" |
| `git checkout -b` | Explains branch creation clearly |

---

### 😄 Funny Aliases

| Alias | Does |
|---|---|
| `please` / `pls` / `fucking` | All equal `sudo` |
| `cls` / `clr` / `c` | `clear` (Windows refugee support) |
| `ll` | `ls -lah` — pretty file listing with sizes |
| `la` | `ls -A` — show hidden files |
| `cd..` | `cd ..` — typo forgiveness |
| `..` / `...` / `....` | Go up 1 / 2 / 3 directories |
| `now` | Print current date and time |
| `h` | Last 30 history entries |
| `path` | Print `$PATH` one entry per line |

---

### 🛡️ Safer Default Commands

| Command | Behavior |
|---|---|
| `rm` | Uses `-I` flag — asks before deleting multiple files |
| `cp` | Interactive (`-iv`) — won't silently overwrite |
| `mv` | Interactive (`-iv`) — won't silently overwrite |
| `mkdir` | Always creates parent dirs (`-p`) and shows what was created |

---

### 🎲 Fun Extras

```bash
coin          # 🪙 Flip a coin
dice          # 🎲 Roll a 6-sided die
compliment    # Get a random encouragement message
weather NYC   # Current weather (requires curl + internet)
```

---

### 🔧 Smart Command Wrappers

- **`make`** — Prints "fingers crossed..." before building, celebrates or commiserates after
- **`cd`** — Prints the full path after every directory change
- **`ping`** — Adds "please be home..." message
- **`python3`** — Announces "Summoning the snake..."

---

## 📋 Requirements

- **Bash** (tested on Bash 4+)
- Linux or macOS
- `curl` (optional — for the `weather` command)
- Git (for the git wrappers to be useful)

---

## 🔄 Uninstalling

The script adds a clearly marked block to `~/.bashrc`. To remove it, open the file and delete everything between:

```bash
# Remove the funny block from ~/.bashrc
sed -i '/# ===== FUNNY SHELL SETUP =====/,/# ===== END FUNNY SHELL SETUP =====/d' ~/.bashrc

# Reload your shell
source ~/.bashrc
```

Then run `source ~/.bashrc`.

---

## 📁 File Structure

```
.
├── funny_shell_setup.sh   # The installer — run this once
└── README.md              # You are here
```

---

## 🤝 Contributing

Found a git command that needs more explaining? Have a better joke? PRs welcome.

Suggested areas:
- More random greetings
- Additional git subcommand explanations (`bisect`, `cherry-pick`, `worktree`)
- Support for `zsh` / `fish`

---

## ⚠️ Disclaimer

This script modifies your `~/.bashrc`. It wraps some commands (`git`, `make`, `cd`, `python3`, `ping`) with shell functions that call through to the originals — so all real functionality is preserved. If anything acts unexpectedly, check the `~/.bashrc` block or uninstall as described above.

`rm` is made *safer* but **not safe** — it still deletes files. Think before you type.

---

*Made with ☕ and mild frustration at boring terminals.*
