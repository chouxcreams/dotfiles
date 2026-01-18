import { defineConfig } from "jsr:@yuki-yano/zeno";

export default defineConfig(() => ({
  snippets: [
    // 基本コマンド
    {
      name: "git",
      keyword: "g",
      snippet: "git",
    },
    {
      name: "git status",
      keyword: "gs",
      snippet: "git status --short --branch",
    },
    {
      name: "git log",
      keyword: "gl",
      snippet: "git plog",
    },
    {
      name: "gp to git push",
      keyword: "gp",
      snippet: "git push",
    },

    // branch
    {
      name: "git branch",
      keyword: "br",
      snippet: "branch",
      context: {
        lbuffer: "^git",
      },
    },

    // switch
    {
      name: "git create new branch",
      keyword: "sc",
      snippet: "switch -c {{branch_name}}",
      context: {
        lbuffer: "^git",
      },
    },
    {
      name: "git switch branch",
      keyword: "gsw",
      snippet: "git switch {{branch_name}}",
    },
    {
      name: "git switch main",
      keyword: "gsm",
      snippet: "git switch main",
    },
    {
      name: "git switch",
      keyword: "sw",
      snippet: "switch {{branch_name}}",
      context: {
        lbuffer: "^git",
      },
    },
    {
      name: "git switch main",
      keyword: "sm",
      snippet: "switch main",
      context: {
        lbuffer: "^git",
      },
    },

    // push / pull
    {
      name: "git push",
      keyword: "p",
      snippet: "push",
      context: {
        lbuffer: "^git",
      },
    },
    {
      name: "git pull",
      keyword: "pl",
      snippet: "pull",
      context: {
        lbuffer: "^git",
      },
    },
    {
      name: "git set origin",
      keyword: "o",
      snippet: 'zsh -c "git symbolic-ref --short HEAD | sed \'s/^/origin /\'"',
      context: {
        lbuffer: "^git (push|pull)",
      },
      evaluate: true,
    },

    // commit
    {
      name: "git commit message",
      keyword: "gcim",
      snippet: "git commit -m '{{commit_message}}'",
    },
    {
      name: "git add all & commit",
      keyword: "gac",
      snippet: "git add . && git commit -m '{{commit_message}}'",
    },
    {
      name: "git add all, commit & push",
      keyword: "gacp",
      snippet: "git add . && git commit -m '{{commit_message}}' && git push",
    },

    // worktree
    {
      name: "create git worktree",
      keyword: "wtc",
      snippet: "wt-create {{branch_name}}",
      context: {
        lbuffer: "^git",
      },
    },
    {
      name: "git worktree",
      keyword: "wt",
      snippet: "worktree",
      context: {
        lbuffer: "^git",
      },
    },
    {
      name: "git worktree add",
      keyword: "a",
      snippet: "add",
      context: {
        lbuffer: "^git worktree",
      },
    },
    {
      name: "git worktree list",
      keyword: "ls",
      snippet: "list",
      context: {
        lbuffer: "^git worktree",
      },
    },
    {
      name: "git worktree remove",
      keyword: "rm",
      snippet: "remove",
      context: {
        lbuffer: "^git worktree",
      },
    },

    // GitHub Copilot
    {
      name: "github copilot suggest",
      keyword: "ghcs",
      snippet: "gh copilot suggest",
    },
    {
      name: "github copilot explain",
      keyword: "ghce",
      snippet: "gh copilot explain",
    },
  ],
}));
