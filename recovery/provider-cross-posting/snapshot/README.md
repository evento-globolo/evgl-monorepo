# evgl-monorepo

Integrated development and deployment view of Evento Globolo. Dedicated
repositories remain independently releasable; this repository pins them as
submodules so one commit describes a tested system composition.

```sh
git submodule update --init --recursive
cp .env.example .env
docker compose up --build
```

## Composition

- Rust provider libraries and encrypted token vault
- Axum cross-post API and WebSocket jobs
- MASH, Leptos, and Dioxus Rust web servers
- typed clients, interfaces, CLI, distributed sync, and Cloudflare edge code
