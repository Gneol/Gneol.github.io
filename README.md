# Gneol

A runtime for `.gneol` files. Describe your AI program in one plain-text file, deploy it with one command, and Gneol runs it as an agent — models, triggers, tools, schedules, all in one binary. No external server to deploy. No database. Just one executable.

---

## Quick Install

```bash
curl -sSL https://raw.githubusercontent.com/Gneol/Gneol/main/install.sh | bash
```

Install a specific version:

```bash
curl -sSL https://raw.githubusercontent.com/Gneol/Gneol/main/install.sh | bash -s -- --version v1.0.0
```

Or download a precompiled binary from the [Releases](https://github.com/Gneol/Gneol/releases) page.

---

## Your First Agent

Create `hello.gneol`:

```
program("Hello World")
  .model("fast-llm")

model("fast-llm")
  .provider("openrouter")
  .modelId("openai/gpt-4o-mini")
  .apiKey("OPENROUTER_API_KEY")
```

Deploy it and start chatting:

```bash
gneol start
# in another terminal:
gneol deploy -f hello.gneol -i
gneol
# Hello World ❯ hi there
# 💬 Hello! I'm your Hello World agent — ask me anything.
```

---

## The .gneol File

One plain-text file describes your entire agent: its model, subagents, scheduled triggers, event listeners, tools, and MCP servers. Deploying the file reconciles the runtime with your program — no manual setup.

```
program("My App")
  .model("fast-llm")
  .context("Policy").text("Never share internal keys.")

model("fast-llm")
  .provider("openrouter")
  .modelId("openai/gpt-4o-mini")
  .apiKey("OPENROUTER_API_KEY")

subagent("Marcus")
  .model("fast-llm")
  .description("CI monitoring specialist")

at("every:10min")
  .if("Backend health endpoint is reachable")
  .do("Run health probe")
```

---

## Documentation & Support

- **Full reference** — [Gneol docs](https://gneol.github.io/docs/)
- **Website** — [gneol.github.io](https://gneol.github.io/)
- **Issues** — [GitHub Issues](https://github.com/Gneol/Gneol/issues)

---
