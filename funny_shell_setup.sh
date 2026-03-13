#!/usr/bin/env bash
# ============================================================
#   🎭  FUNNY SHELL SETUP  🎭
#   Makes your terminal less boring and git more explainable
#   Run: bash funny_shell_setup.sh
#   Then: source ~/.bashrc  (or restart terminal)
# ============================================================

BASHRC="$HOME/.bashrc"
MARKER="# ===== FUNNY SHELL SETUP ====="

# Don't add twice
if grep -q "$MARKER" "$BASHRC" 2>/dev/null; then
  echo "✅ Already installed! Run: source ~/.bashrc to reload."
  exit 0
fi

cat >> "$BASHRC" << 'FUNNY_BLOCK'

# ===== FUNNY SHELL SETUP =====

# ─────────────────────────────────────────────
# 🎨  COLORFUL PROMPT
# Shows: user@host current-dir (git branch) $
# ─────────────────────────────────────────────
__git_branch() {
  git branch 2>/dev/null | grep '^\*' | sed 's/\* //'
}

__funny_prompt() {
  local EXIT=$?
  local RED='\[\e[31m\]'
  local GREEN='\[\e[32m\]'
  local YELLOW='\[\e[33m\]'
  local CYAN='\[\e[36m\]'
  local MAGENTA='\[\e[35m\]'
  local BOLD='\[\e[1m\]'
  local RESET='\[\e[0m\]'

  local BRANCH=$(__git_branch)
  local BRANCH_PART=""
  [ -n "$BRANCH" ] && BRANCH_PART=" ${MAGENTA}(${BRANCH})${RESET}"

  local STATUS_EMOJI="🟢"
  [ $EXIT -ne 0 ] && STATUS_EMOJI="💥"

  PS1="${BOLD}${CYAN}\u${RESET}@${GREEN}\h${RESET}:${YELLOW}\w${RESET}${BRANCH_PART} ${STATUS_EMOJI} \$ "
}
PROMPT_COMMAND=__funny_prompt


# ─────────────────────────────────────────────
# 😂  RANDOM GREETING ON NEW TERMINAL
# ─────────────────────────────────────────────
__funny_greeting() {
  local GREETINGS=(
    "👋 Oh look, YOU again. Let's make something cool."
    "🧠 Terminal activated. Coffee level: unknown."
    "🚀 Ready to deploy bugs to production?"
    "💡 Reminder: 'rm -rf /' is NOT a valid fix."
    "🎩 Welcome, wizard. Your keyboard is your wand."
    "🐧 Linux says hi. Windows cries in the corner."
    "☕ No coffee detected. Proceed with caution."
    "🤖 Beep boop. Human detected. Initializing sarcasm..."
  )
  local IDX=$(( RANDOM % ${#GREETINGS[@]} ))
  echo -e "${GREETINGS[$IDX]}"
}
__funny_greeting


# ─────────────────────────────────────────────
# 🔁  FUNNY ALIASES - Basic Commands
# ─────────────────────────────────────────────
alias please='sudo'                         # be polite
alias fucking='sudo'                        # be... less polite
alias pls='sudo'                            # lazy polite
alias ls='ls --color=auto -F'
alias ll='ls -lah --color=auto'             # list like a pro
alias la='ls -A'
alias cd..='cd ..'                          # typo forgiveness
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cls='clear'                           # windows refugee support
alias clr='clear'
alias c='clear'

alias mkdir='mkdir -pv'                     # make dirs verbosely
alias cp='cp -iv'                           # interactive copy (no accidents)
alias mv='mv -iv'                           # interactive move
alias rm='rm -I --preserve-root'           # safe rm (still be careful!)

alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# ─────────────────────────────────────────────
# 🕐  TIME & HISTORY
# ─────────────────────────────────────────────
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias h='history | tail -30'
alias path='echo $PATH | tr ":" "\n"'      # readable PATH

# ─────────────────────────────────────────────
# 🔥  FUNNY COMMAND WRAPPERS
# ─────────────────────────────────────────────

# 'make' with encouragement
make() {
  echo "🔨 Building... fingers crossed..."
  command make "$@"
  local EXIT=$?
  [ $EXIT -eq 0 ] && echo "✅ Build succeeded! You beautiful genius." \
                  || echo "💀 Build failed. That's okay, failure is just success in progress. (no it's not)"
  return $EXIT
}

# cd with attitude
cd() {
  builtin cd "$@" && echo "📂 Now in: $(pwd)"
}

# ping with commentary
ping() {
  echo "🏓 Pinging... please be home..."
  command ping "$@"
}

# python with a warning
python3() {
  echo "🐍 Summoning the snake..."
  command python3 "$@"
}

# ─────────────────────────────────────────────
# 🐙  GIT — FUNNY + EXPLAINABLE WRAPPERS
#   Every git command explains what it's doing
#   and adds a sprinkle of humor
# ─────────────────────────────────────────────

git() {
  local CMD="$1"
  shift

  case "$CMD" in

    init)
      echo "🎉 Creating a new git repo! This is where the magic (and chaos) begins."
      echo "   Git will now track every change you make. No pressure."
      command git init "$@"
      echo "✅ Repo initialized. Now add some files with: git add ."
      ;;

    clone)
      echo "📥 Cloning repository: $@"
      echo "   (Downloading someone else's hard work to your machine)"
      command git clone "$@"
      echo "✅ Cloned! It's yours now. Be gentle."
      ;;

    status)
      echo "🔍 Checking what you've been up to..."
      echo "   (M = modified, A = added, D = deleted, ? = untracked)"
      command git status "$@"
      ;;

    add)
      if [ "$1" = "." ]; then
        echo "📦 Staging ALL changed files..."
        echo "   ⚠️  You're adding everything. Hope you reviewed it!"
      else
        echo "📦 Staging: $@"
        echo "   These files are queued for the next commit."
      fi
      command git add "$@"
      echo "✅ Staged! Now commit with: git commit -m 'your message'"
      ;;

    commit)
      echo "💾 Saving a snapshot of your staged changes to history..."
      command git commit "$@"
      local EXIT=$?
      [ $EXIT -eq 0 ] && echo "✅ Committed! That moment is now immortalized forever." \
                      || echo "❌ Commit failed. Did you forget to add files? (git add .)"
      return $EXIT
      ;;

    push)
      echo "🚀 Launching your commits into the remote repo..."
      echo "   What's on your machine → goes to the server. This is the scary part."
      command git push "$@"
      local EXIT=$?
      [ $EXIT -eq 0 ] && echo "✅ Pushed! Your code is now in the cloud. Hope it works 🤞" \
                      || echo "💥 Push failed! Is the remote correct? Try: git pull first, then push again."
      return $EXIT
      ;;

    pull)
      echo "📡 Pulling latest changes from the remote..."
      echo "   Someone else may have pushed. You're about to find out."
      command git pull "$@"
      local EXIT=$?
      [ $EXIT -eq 0 ] && echo "✅ Up to date! You and remote are in sync. Beautiful." \
                      || echo "⚠️  Merge conflicts? Don't panic. Open the files and look for <<<<<<< markers."
      return $EXIT
      ;;

    fetch)
      echo "👀 Fetching remote info (without merging anything yet)..."
      echo "   It's like checking the mail but not opening the letters."
      command git fetch "$@"
      echo "✅ Fetched! Use 'git merge' or 'git pull' to actually apply changes."
      ;;

    merge)
      echo "🔀 Merging branches..."
      echo "   Combining two timelines of code. May the conflicts be few."
      command git merge "$@"
      local EXIT=$?
      [ $EXIT -eq 0 ] && echo "✅ Merged cleanly! No casualties." \
                      || echo "⚠️  Conflicts detected! Edit the conflicting files, then: git add . && git commit"
      return $EXIT
      ;;

    rebase)
      echo "🎢 Rebasing... (replaying your commits on top of another branch)"
      echo "   ⚠️  This rewrites history. Don't do this on shared/public branches!"
      command git rebase "$@"
      local EXIT=$?
      [ $EXIT -eq 0 ] && echo "✅ Rebased! Timeline altered. Marty McFly approved." \
                      || echo "⚠️  Rebase paused on conflict. Fix it, then: git rebase --continue"
      return $EXIT
      ;;

    branch)
      echo "🌿 Working with branches..."
      echo "   Branches let you work in isolation without breaking the main code."
      command git branch "$@"
      ;;

    checkout)
      echo "🚪 Switching context..."
      if [[ "$1" == "-b" ]]; then
        echo "   Creating AND switching to new branch: $2"
      else
        echo "   Switching to: $@"
      fi
      command git checkout "$@"
      local EXIT=$?
      [ $EXIT -eq 0 ] && echo "✅ Switched! You're now on: $(command git branch --show-current)" \
                      || echo "❌ Checkout failed. Unsaved changes? Try: git stash"
      return $EXIT
      ;;

    switch)
      echo "🔄 Switching branches to: $@"
      command git switch "$@"
      local EXIT=$?
      [ $EXIT -eq 0 ] && echo "✅ On branch: $(command git branch --show-current)"
      return $EXIT
      ;;

    stash)
      echo "🗃️  Stashing your work-in-progress..."
      echo "   Like shoving your mess under the bed when guests arrive."
      command git stash "$@"
      echo "✅ Stashed! Retrieve later with: git stash pop"
      ;;

    log)
      echo "📜 Showing commit history..."
      echo "   The greatest hits (and misses) of this repo:"
      # Show a pretty log if no args
      if [ $# -eq 0 ]; then
        command git log --oneline --graph --decorate --color -15
      else
        command git log "$@"
      fi
      ;;

    diff)
      echo "🔬 Showing what changed..."
      echo "   Red = removed lines, Green = added lines"
      command git diff "$@"
      ;;

    reset)
      echo "⏪ Resetting..."
      if [[ "$1" == "--hard" ]]; then
        echo "   ⚠️  HARD reset: ALL uncommitted changes will be DELETED. No undo."
        read -p "   Are you sure? (yes/N): " CONFIRM
        [[ "$CONFIRM" != "yes" ]] && echo "❌ Aborted. Phew." && return 1
      fi
      command git reset "$@"
      ;;

    revert)
      echo "↩️  Reverting a commit (creates a NEW commit that undoes the old one)..."
      echo "   Safe for shared branches! Unlike reset."
      command git revert "$@"
      ;;

    tag)
      echo "🏷️  Tagging..."
      echo "   Tags mark important points in history, like releases (v1.0, v2.3...)"
      command git tag "$@"
      ;;

    remote)
      echo "🌐 Managing remote connections..."
      echo "   Remotes are the servers your repo talks to (like GitHub/GitLab)"
      command git remote "$@"
      ;;

    *)
      # Passthrough for anything else
      command git "$CMD" "$@"
      ;;
  esac
}


# ─────────────────────────────────────────────
# 🎲  FUN EXTRAS
# ─────────────────────────────────────────────

# Flip a coin
coin() {
  [ $(( RANDOM % 2 )) -eq 0 ] && echo "🪙 Heads!" || echo "🪙 Tails!"
}

# Roll a dice
dice() {
  echo "🎲 You rolled: $(( (RANDOM % 6) + 1 ))"
}

# Compliment yourself
compliment() {
  local LIST=(
    "You're doing GREAT, champ! 🌟"
    "Honestly? A coding legend. 🏆"
    "Your commits spark joy. ✨"
    "Marie Kondo would approve of your code. 🌸"
    "10x developer energy detected. 🚀"
    "If code were art, you'd be in a museum. 🎨"
  )
  echo "${LIST[$((RANDOM % ${#LIST[@]}))]}"
}

# Sudo reminder
alias i-am-root='echo "🦸 With great power comes great responsibility. (and rm -rf /)"'

# Weather (if curl available)
weather() {
  curl -s "wttr.in/${1:-}" 2>/dev/null || echo "❌ curl not available or no network"
}

echo "🎭 Funny shell loaded! Try: compliment, coin, dice, weather <city>"

# ===== END FUNNY SHELL SETUP =====
FUNNY_BLOCK

echo ""
echo "✅ Funny shell setup installed to ~/.bashrc!"
echo ""
echo "  👉  Run this to activate now:"
echo "      source ~/.bashrc"
echo ""
echo "  🎁  What you get:"
echo "      - Colorful prompt with git branch + success/fail emoji"
echo "      - Random greeting on each new terminal"
echo "      - Explained git commands with humor"
echo "      - Funny aliases: please, fucking, pls (all = sudo)"
echo "      - Safe rm, interactive cp/mv"
echo "      - Fun commands: coin, dice, compliment, weather"
echo ""
