import { defineConfig } from "jsr:@yuki-yano/zeno";

export default defineConfig(() => ({
  snippets: [
    // Editor
    {
      name: "claude",
      keyword: "c",
      snippet: "claude",
    },
    {
      name: "nvim",
      keyword: "v",
      snippet: "nvim",
    },

    // Docker
    {
      name: "docker",
      keyword: "dc",
      snippet: "docker",
    },
    {
      name: "docker compose",
      keyword: "dcp",
      snippet: "docker compose",
    },
    {
      name: "docker compose up",
      keyword: "dup",
      snippet: "docker compose up -d",
    },

    // Deno
    {
      name: "deno",
      keyword: "dn",
      snippet: "deno",
    },
    {
      name: "deno run",
      keyword: "r",
      snippet: "run",
      context: {
        lbuffer: "^deno\\s",
      },
    },
    {
      name: "deno task",
      keyword: "t",
      snippet: "task",
      context: {
        lbuffer: "^deno\\s",
      },
    },

    // fzf-make
    {
      name: "fzf-make",
      keyword: "fm",
      snippet: "fzf-make",
    },
    {
      name: "fzf-make repeat",
      keyword: "r",
      snippet: "repeat",
      context: {
        lbuffer: "^fzf-make",
      },
    },
    {
      name: "fzf-make history",
      keyword: "h",
      snippet: "history",
      context: {
        lbuffer: "^fzf-make",
      },
    },

    // lazygit
    {
      name: "lazygit",
      keyword: "lg",
      snippet: "lazygit",
    },

    // mise
    {
      name: "mise",
      keyword: "m",
      snippet: "mise",
    },
    {
      name: "mise run",
      keyword: "r",
      snippet: "run",
      context: {
        lbuffer: "^mise\\s",
      },
    },

    // zellij
    {
      name: "zellij",
      keyword: "zel",
      snippet: "zellij",
    },

    // systemctl
    {
      name: "systemctl",
      keyword: "sc",
      snippet: "systemctl",
      context: {
        lbuffer: "^(sudo\\s)?",
      },
    },

    // brew
    {
      name: "brew install",
      keyword: "i",
      snippet: "install {{package_name}}",
      context: {
        lbuffer: "^brew",
      },
    },

    // Utilities
    {
      name: "null",
      keyword: "null",
      snippet: ">/dev/null 2>&1",
      context: {
        lbuffer: ".+\\s",
      },
    },
    {
      name: "help option",
      keyword: "-H",
      snippet: "--help",
      context: {
        lbuffer: "^.*\\s",
      },
    },
    {
      name: "branch",
      keyword: "B",
      snippet: "git symbolic-ref --short HEAD",
      context: {
        lbuffer: "^git\\s+checkout\\s+",
      },
      evaluate: true,
    },
  ],

  completions: [
    {
      name: "go task",
      patterns: ["^task $"],
      sourceCommand: "task --list-all 2>/dev/null | sed '1d'",
      options: {
        "--prompt": "'Task> '",
      },
      callback: "sed -n 's/^\\* \\([^:]*\\):.*/\\1/p'",
    },
    {
      name: "dot command",
      patterns: ["^dot $"],
      sourceCommand: "dot --list-all 2>/dev/null | sed '1d'",
      options: {
        "--prompt": "'dot> '",
      },
      callback: "sed -n 's/^\\* \\([^:]*\\):.*/\\1/p'",
    },
    {
      name: "glow",
      patterns: ["^glow $"],
      sourceCommand: 'fd ".*\\.md" -d 2',
      options: {
        "--prompt": "'glow> '",
      },
    },
    {
      name: "glow stash",
      patterns: ["^glow stash $"],
      sourceCommand: 'fd ".*\\.md" -d 2',
      options: {
        "--prompt": "'glow stash> '",
      },
    },
    {
      name: "zellij session",
      patterns: ["^zellij (a|d|k|attach|delete|kill) $"],
      sourceCommand: "zellij list-sessions --short",
      options: {
        "--prompt": "'zellij sessions> '",
      },
    },
    {
      name: "zellij layout",
      patterns: ["^zellij(.*)(--layout|-l) $"],
      sourceCommand: "get-zellij-layout-list.sh",
      options: {
        "--prompt": "'zellij layouts> '",
      },
    },
  ],
}));
